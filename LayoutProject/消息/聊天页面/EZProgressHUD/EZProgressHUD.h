//
//  EZProgressHUD.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/22.
//  Copyright © 2016年 guangguang. All rights reserved.
//
//重画覆盖view autolayout  弃用UUProgressHUD

#import <UIKit/UIKit.h>

@interface EZProgressHUD : UIView
{
    NSTimer *myTimer;
    int angle;
}
//@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *edgeImageView;

@property (nonatomic, strong, readonly) UIWindow *overlayWindow;


+ (void)show;

+ (void)dismissWithSuccess:(NSString *)str;

+ (void)dismissWithError:(NSString *)str;

+ (void)changeSubTitle:(NSString *)str;


@end
