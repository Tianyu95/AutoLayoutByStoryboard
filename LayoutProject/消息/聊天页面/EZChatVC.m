//
//  EZChatVC.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/18.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZChatVC.h"
#import "EZChatCellR.h"
#import "EZChatCellS.h"
#import "UIView+FDCollapsibleConstraints.h"
#import "UITableView+FDTemplateLayoutCell.h"

#import "AppDelegate.h"

#import "EZMessageRecord.h"

 #define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

@interface EZChatVC ()
{
    EZMessageRecord *mRecord;
    NSMutableArray *dataMessages;
    
}
@end

@implementation EZChatVC




//获取默认表情数组

- (NSArray *)defaultEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emoT];
        }
    }
    return array;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationItem.title = @"吴彦祖11";
    
//    self.automaticallyAdjustsScrollViewInsets = false;
    self.chatTable.estimatedRowHeight = 80;
    self.chatTable.rowHeight = UITableViewAutomaticDimension;
    
    self.chatTable.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doRotateAction:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];

}

- (void)delayMethod {
//    [AppDelegate registerLocalNotification:5 message:@"您有5条新消息"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!dataMessages) {
        dataMessages = [NSMutableArray arrayWithCapacity:0];
    }
    if (!mRecord) {
        mRecord = [[EZMessageRecord alloc] init];
        int result=[mRecord initDatabase:@"MessageRecord.db"];
        
        if (result) {
            [mRecord createMessageTable];
        }
        
        dataMessages = [mRecord getMessageByChatid:@"chat_id2"];
    }
    
    
    self.keyboard.delegate = self;
    self.keyboard.superVC = self;
    
    [self.keyboard replytext:@"@Leonardo:"];
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];
    
    
    dataSource = [[EZChatDataSource alloc] init];
    dataSource.superVC = self;
//    dataSource.vp = self;
//    dataSource.action = @selector(supertapVoice);
    self.chatTable.dataSource = dataSource;
    dataSource.dataArray = dataMessages;
    
    [self.chatTable reloadData];
//    NSArray *arrEmotion = [self defaultEmoticons];
//    for (NSString *str in arrEmotion) {
//        NSLog(@"emoji == %@",str);
//    }
    
//    UIView *sharedView = [[UIView alloc] init];
//    [sharedView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [sharedView setBackgroundColor:[UIColor greenColor]];
//    [self.view addSubview:sharedView];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:sharedView
//                                                           attribute:NSLayoutAttributeWidth
//                                                           relatedBy:NSLayoutRelationEqual
//                                                              toItem:self.view
//                                                           attribute:NSLayoutAttributeWidth
//                                                          multiplier:1
//                                                            constant:0]];
//    
//    [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:sharedView
//                                                            attribute:NSLayoutAttributeHeight
//                                                            relatedBy:NSLayoutRelationEqual
//                                                               toItem:self.view
//                                                            attribute:NSLayoutAttributeHeight
//                                                           multiplier:1
//                                                             constant:0]];
//    
//    [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:sharedView
//                                                            attribute:NSLayoutAttributeCenterX
//                                                            relatedBy:NSLayoutRelationEqual
//                                                               toItem:self.view
//                                                            attribute:NSLayoutAttributeCenterX
//                                                           multiplier:0.5
//                                                             constant:0]];
//    [self.view  addConstraint:[NSLayoutConstraint constraintWithItem:sharedView
//                                                            attribute:NSLayoutAttributeCenterY
//                                                            relatedBy:NSLayoutRelationEqual
//                                                               toItem:self.view
//                                                            attribute:NSLayoutAttributeCenterY
//                                                           multiplier:1
//                                                             constant:0]];
    
    
    
    
//    UIView *superView=sharedView.superview;
//    //添加约束，使按钮在屏幕水平方向的中央
//    NSLayoutConstraint *centerXContraint=[NSLayoutConstraint
//                                          constraintWithItem:sharedView
//                                          attribute:NSLayoutAttributeCenterX
//                                          relatedBy:NSLayoutRelationEqual
//                                          toItem:superView
//                                          attribute:NSLayoutAttributeCenterX
//                                          multiplier:1.0f
//                                          constant:0.0];
//    //添加约束，使按钮在屏幕垂直方向的中央
//    NSLayoutConstraint *centerYContraint=[NSLayoutConstraint
//                                          constraintWithItem:sharedView
//                                          attribute:NSLayoutAttributeCenterY
//                                          relatedBy:NSLayoutRelationEqual
//                                          toItem:superView
//                                          attribute:NSLayoutAttributeCenterY
//                                          multiplier:1.0f
//                                          constant:0.0];
//    
//    NSLayoutConstraint *hhhhContraint=[NSLayoutConstraint
//                                          constraintWithItem:sharedView
//                                          attribute:NSLayoutAttributeHeight
//                                          relatedBy:NSLayoutRelationEqual
//                                          toItem:superView
//                                          attribute:NSLayoutAttributeHeight
//                                          multiplier:1.0f
//                                          constant:10.0];
//
//    NSLayoutConstraint *wwwwContraint=[NSLayoutConstraint
//                                       constraintWithItem:sharedView
//                                       attribute:NSLayoutAttributeWidth
//                                       relatedBy:NSLayoutRelationEqual
//                                       toItem:superView
//                                       attribute:NSLayoutAttributeWidth
//                                       multiplier:1.0f
//                                       constant:0.0];
//    //给button的父节点添加约束
//    [superView addConstraints:@[centerXContraint,centerYContraint,hhhhContraint, wwwwContraint]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger rows = [self.chatTable numberOfRowsInSection:0];
    if (rows > 0) {
        [self.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                  atScrollPosition:UITableViewScrollPositionBottom
                          animated:animated];
    }
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath
              atScrollPosition:(UITableViewScrollPosition)position
                      animated:(BOOL)animated {
    
    [self.chatTable scrollToRowAtIndexPath:indexPath
              atScrollPosition:position
                      animated:animated];
}

//////////
- (void)doRotateAction:(NSNotification *)notification {
    if ([[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortrait
        || [[UIDevice currentDevice] orientation] == UIInterfaceOrientationPortraitUpsideDown) {
        //竖屏
        NSLog(@"竖屏");
    } else {
        //横屏
        NSLog(@"横屏");
    }
    
}

- (void)keyBoardBecomeFirstResponder {
    [self scrollToBottomAnimated:YES];
}

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
        [self updateViewConstraintsForKeyboardHeight:0];
    }];
    
}

- (void)updateViewConstraintsForKeyboardHeight:(CGFloat)keyboardHeight {
    if (_bottomConstraint) {
        [self.view removeConstraint:_bottomConstraint];
        _bottomConstraint = nil;
    }
    if (keyboardHeight) {
        _bottomConstraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.chatTable attribute:NSLayoutAttributeBottom multiplier:1.0 constant:keyboardHeight + 40];
        [self.view addConstraint:_bottomConstraint];
    }
    [self.view layoutIfNeeded];
}

#pragma mark - keyboardDelegate
- (void)keyboardSendMessage:(NSString *)message{
    NSLog(@"发送message ＝ %@",message);
    EZChatMessageModel *item = [[EZChatMessageModel alloc] init ];
    NSDate* tmpStartData = [NSDate date];
    item.createtime = [self stringFromDate:tmpStartData];
    item.chat_id = @"chat_id2";
    item.sender_id = @"user321";
    item.sender_pic = @"userpic";
    item.sender_name = @"chat_id2";
    item.msgtype = EZMessageTypeSending;
    item.mediaType = EZMessageMediaTypeText;
    item.content = message;
    item.image_id = @"";
    item.voice_id = nil;
    item.voice_duration = @"";
    item.msg_id = @"1234323";
    item.chat_pic = @"chat_id2";
    item.chat_name = @"chat_id2";
    [mRecord addMessage:item];

    [dataMessages removeAllObjects];
    [dataSource.dataArray removeAllObjects];
    dataMessages = [mRecord getMessageByChatid:@"chat_id2"];
    dataSource.dataArray = dataMessages;
    [self.chatTable reloadData];    
}
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:destinationTimeZone];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (void)keyboardSendPicture:(UIImage *)image {
    NSLog(@"发送pic ＝ %@",image);
    
}
- (void)keyboardSendVoice:(NSData *)voice time:(NSInteger)second
{
    NSLog(@"发送voice = %@",voice);
//    audio = [EZAVAudioPlayer sharedInstance];
//    audio.delegate = self;
//    [audio playSongWithData:voice];
    
    EZChatMessageModel *item = [[EZChatMessageModel alloc] init ];
    NSDate* tmpStartData = [NSDate date];
    item.createtime = [self stringFromDate:tmpStartData];
    item.chat_id = @"chat_id2";
    item.sender_id = @"user321";
    item.sender_pic = @"userpic";
    item.sender_name = @"chat_id2";
    item.msgtype = EZMessageTypeSending;
    item.mediaType = EZMessageMediaTypeVoice;
    item.content = @"";
    item.image_id = @"";
    item.voice_id = voice;
    item.voice_duration = [NSString stringWithFormat:@"%ld",(long)second];
    item.msg_id = @"1234323";
    item.chat_pic = @"chat_id2";
    item.chat_name = @"chat_id2";
    [mRecord addMessage:item];
    
    [dataMessages removeAllObjects];
    [dataSource.dataArray removeAllObjects];
    dataMessages = [mRecord getMessageByChatid:@"chat_id2"];
    dataSource.dataArray = dataMessages;
    [self.chatTable reloadData];
}

@end
