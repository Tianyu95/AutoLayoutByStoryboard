//
//  EZChatDataSource.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/10.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZChatDataSource.h"
#import "EZChatCellR.h"
#import "EZChatCellS.h"
#import "UIView+FDCollapsibleConstraints.h"
#import "EZChatVC.h"

#import "fmdb.h"

@implementation EZChatDataSource

- (void)reloadSql {
    
}
#pragma mark -
#pragma mark table view datasource delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString *CellIdentifier = @"Cellabc";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    // Configure the cell...
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //    }
    //    return cell;
    
    
    static NSString *identiferSent = @"identiferSentttt";
    static NSString *identiferReceive = @"identiferReceiveeee";
    EZChatCellR *receiveCell = [tableView dequeueReusableCellWithIdentifier:identiferReceive];
    EZChatCellS *sentCell = [tableView dequeueReusableCellWithIdentifier:identiferSent];
    
    EZChatMessageModel *item = [self.dataArray objectAtIndex:indexPath.row];
    
    if (receiveCell == nil) {
        receiveCell = [[[NSBundle mainBundle] loadNibNamed:@"EZChatCellR" owner:nil options:nil] lastObject];
        receiveCell.delegate = self;
    }
    if (sentCell == nil) {
        sentCell = [[[NSBundle mainBundle] loadNibNamed:@"EZChatCellS" owner:nil options:nil] lastObject];
        sentCell.delegate = self;
    }
    
    
    if (item.msgtype == EZMessageTypeSending) {
        sentCell.messagedata = item;
        [sentCell loadMessageData];
        return sentCell;
    }
    receiveCell.messagedata = item;
    return receiveCell;
}

- (void)tapVoice {
    NSLog(@"delegate tapVoice");
    
//    if (self.vp && [self.vp respondsToSelector:self.action]) {
//        [self.vp performSelector:self.action withObject:nil];
//    }
    
    /*
    //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard,
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"XMessage" bundle:nil];
    //由storyboard根据myView的storyBoardID来获取我们要切换的视图
    EZChatVC *chatPage = [story instantiateViewControllerWithIdentifier:@"ezchatvc"];
    //由navigationController推向我们要推向的view
    //        XChatView *chatPage = [[XChatView alloc] initWithNibName:@"XChatView" bundle:nil];
    chatPage.hidesBottomBarWhenPushed = YES;
    [self.superVC.navigationController pushViewController:chatPage animated:YES];
    */
}

@end
