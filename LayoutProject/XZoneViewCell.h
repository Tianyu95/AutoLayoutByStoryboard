//
//  XZoneViewCell.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/1.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XZoneViewCell;
@class XZoneMode;


@protocol XZoneViewCellDelegate <NSObject>

- (void)xZoneViewCellClickFullButton:(XZoneViewCell *)zoneViewCell;

@end

@interface XZoneViewCell : UITableViewCell

@property (nonatomic,strong) XZoneMode *zoneMode;

@property (nonatomic,weak) id<XZoneViewCellDelegate> delegate;

/**  创建Cell   */
+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

@end
