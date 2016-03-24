//
//  XLabelListCell.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/2.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "XLabelListCell.h"

@implementation XLabelListCell

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView
{
    static NSString *identifer = @"LabelListCell";
    
    XLabelListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XLabelListCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
