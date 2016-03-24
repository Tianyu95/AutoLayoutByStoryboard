//
//  EZMoreTool.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/24.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZMoreTool.h"

@implementation EZMoreTool

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
//    [[NSBundle mainBundle] loadNibNamed:@"EZMoreTool" owner:self options:nil];
//    [self addSubview:self.contentView];
    
    self.btn1.layer.cornerRadius = 5;
    self.btn1.layer.masksToBounds = YES;
    self.btn1.layer.borderColor = [[UIColor grayColor] CGColor];
    self.btn1.layer.borderWidth = 0.5;
    
    self.btn2.layer.cornerRadius = 5;
    self.btn2.layer.masksToBounds = YES;
    self.btn2.layer.borderColor = [[UIColor grayColor] CGColor];
    self.btn2.layer.borderWidth = 0.5;
}



@end
