//
//  EZMessageListC.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/1.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZMessageListC.h"
#import "EZMessageListCell.h"
#import "EZMessageCell.h"

#import "EZChatVC.h"

#import "FMDB.h"
#import "EZMessageRecord.h"
#import "EZChatMessageModel.h"

#import "Masonry.h"
#import "EZKeyBoard.h"
#import "EZCommentKeyBoard.h"


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//http://www.cocoachina.com/industry/20130819/6821.html

@interface EZMessageListC ()
{
    EZMessageRecord *mrdao;
    NSMutableArray *messageArray;
}
@end

@implementation EZMessageListC

- (void)onleft {
    [mrdao onleftjia];
    
    [messageArray removeAllObjects];
    messageArray = [mrdao getMessageForAllPeople];
    [self.tableView reloadData];
}

//- (void)keyBoardBecomeFirstResponder {
//    [self scrollToBottomAnimated:YES];
//}

- (void)keyboardWillShow:(NSNotification *)note {
    NSDictionary *userInfo = [note userInfo];
    NSValue *value = [userInfo objectForKeyedSubscript:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardHeight = value.CGRectValue.size.height;
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:[duration floatValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        NSLog(@"keyboardHeight == %f",keyboardHeight);
        [self updateViewConstraintsForKeyboardHeight:keyboardHeight];
    }];
}

- (void)keyboardWillHidden:(NSNotification *)note {
    NSDictionary *userInfo = [note userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:[duration floatValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        [self updateViewConstraintsForKeyboardHeight:69];
    }];
}
- (void)updateViewConstraintsForKeyboardHeight:(CGFloat)keyboardHeight {
    WS(ws);

    [ccccc mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_bottomLayoutGuide).offset(-15-keyboardHeight);
    }];
    
    [self.view layoutIfNeeded];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    ///////////////评论使用案例///////
    WS(ws);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];

    ccccc   = [[[NSBundle mainBundle] loadNibNamed:@"EZCommentKeyBoard" owner:self options:nil] firstObject];
    
    [self.view addSubview:ccccc];
    [ccccc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.tv);
        make.height.mas_equalTo(@40);
        make.bottom.equalTo(ws.mas_bottomLayoutGuide).offset(-69);
    }];

    
    
    
    self.navigationItem.title = @"消息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(onleft)];

    
    messageArray = [NSMutableArray arrayWithCapacity:0];
    ////////////////////////////////////////////////
    mrdao=[[EZMessageRecord alloc]init];
    
    int result=[mrdao initDatabase:@"MessageRecord.db"];
    
    if (result) {
        [mrdao createMessageTable];
    }
    
//    [mrdao addMessage];
    
    NSArray *itemArr = [mrdao getMessage];
    
    NSLog(@"all === %@",itemArr);
    
    messageArray = [mrdao getMessageForAllPeople];
    NSLog(@"最新消息列表 == %@",messageArray);
    
//    NSLog(@"聊天消息chat_id2 = %@",[mrdao getMessageByChatid:@"chat_id2"]);
    
//    [mrdao removeMessageByChatid:@"chat_id2"];
//    [mrdao removeAllMessage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messageArray.count + 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifer = @"EZMessageListCell";
    static NSString *messageidentifer = @"EZMessageCell";
    EZMessageListCell *listCell = [tableView dequeueReusableCellWithIdentifier:identifer];
    EZMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:messageidentifer];
    
    if (indexPath.row < 2) {
        if ( listCell == nil ) {
            listCell = [[[NSBundle mainBundle] loadNibNamed:@"EZMessageListCell" owner:nil options:nil] lastObject];
        }
    } else {
        if ( messageCell == nil ) {
            messageCell = [[[NSBundle mainBundle] loadNibNamed:@"EZMessageCell" owner:nil options:nil] lastObject];
        }
    }
    
    if (indexPath.row == 0) {
        [listCell.img setImage:[UIImage imageNamed:@"notification"]];
        listCell.lab.text = @"我的通知";
    } else if (indexPath.row == 1) {
        [listCell.img setImage:[UIImage imageNamed:@"friend"]];
        listCell.lab.text = @"好友动态";
    }
    
    
    if (indexPath.row > 1) {
        messageCell.messagedata = [messageArray objectAtIndex:indexPath.row - 2];
        return messageCell;
    }
    
    
    return listCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld",(long)indexPath.row);
    
    if (indexPath.row > 1) {
        //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"XMessage" bundle:nil];
        //由storyboard根据myView的storyBoardID来获取我们要切换的视图
        EZChatVC *chatPage = [story instantiateViewControllerWithIdentifier:@"ezchatvc"];
        //由navigationController推向我们要推向的view
//        XChatView *chatPage = [[XChatView alloc] initWithNibName:@"XChatView" bundle:nil];
        chatPage.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatPage animated:NO];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 1) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EZChatMessageModel *item = [messageArray objectAtIndex:indexPath.row - 2];
        [mrdao removeMessageByChatid:item.chat_id];
        [messageArray removeObject:item];
    }
    [tableView reloadData];
    NSLog(@"row %ld",(long)indexPath.row);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
