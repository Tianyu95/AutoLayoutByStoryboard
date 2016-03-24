//
//  EZMessageCell.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/4.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZChatMessageModel.h"

@interface EZMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userPic;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic, assign) EZChatMessageModel *messagedata;

@end
