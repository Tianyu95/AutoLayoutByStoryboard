//
//  EZChatDataSource.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/10.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>  
#import "EZChatCellR.h"
#import "EZChatCellS.h"
#import "EZChatMessageModel.h"
#import "EZKeyBoard.h"

@interface EZChatDataSource : NSObject <UITableViewDataSource,EZChatCellRDelegate, EZChatCellSDelegate,EZKeyBoardDelegate>

//@property (nonatomic, assign) id vp;
//@property (nonatomic, assign) SEL action;

@property (nonatomic, assign) UIViewController *superVC;
@property (nonatomic, assign) NSMutableArray *dataArray;
@end
