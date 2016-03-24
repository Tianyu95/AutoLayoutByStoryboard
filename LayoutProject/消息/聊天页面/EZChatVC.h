//
//  EZChatVC.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/18.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZKeyBoard.h"
#import "EZChatDataSource.h"

@interface EZChatVC : UIViewController <EZKeyBoardDelegate>
{
    EZChatDataSource *dataSource;
}
@property (weak, nonatomic) IBOutlet UITableView *chatTable;

@property (nonatomic) NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet EZKeyBoard *keyboard;

- (void)supertapVoice;

@end
