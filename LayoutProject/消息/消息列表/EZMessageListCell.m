//
//  EZMessageListCell.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/4.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZMessageListCell.h"

@implementation EZMessageListCell

- (void)awakeFromNib {
    // Initialization code
    
    self.img.clipsToBounds = YES;
    self.img.layer.cornerRadius = 16;//CGRectGetWidth(self.img.frame) / 2;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
