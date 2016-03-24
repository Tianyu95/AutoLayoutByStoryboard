//
//  EZProgressHUD.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/22.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZProgressHUD.h"

@implementation EZProgressHUD
@synthesize overlayWindow;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (EZProgressHUD*)sharedView {
    static dispatch_once_t once;
    static EZProgressHUD *sharedView;
    
    dispatch_once(&once, ^ {
//        sharedView = [[EZProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        sharedView = [[[NSBundle mainBundle] loadNibNamed:@"EZProgressHUD" owner:self options:nil] lastObject];
        sharedView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [sharedView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self addSubview:sharedView];
    });
    return sharedView;
}

//- (void)awakeFromNib
//{
   // NSLog(@"awake from nib");
    //[[NSBundle mainBundle] loadNibNamed:@"EZProgressHUD" owner:self options:nil];
  //  [self addSubview:self.contentView];
//}

+ (void)show {
    [[EZProgressHUD sharedView] show];
}

- (void)show {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.superview) {
            [self.overlayWindow addSubview:self];
        
        //////////////////////////////
        [overlayWindow addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:overlayWindow
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:1
                                                               constant:0]];
        
        [overlayWindow  addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:overlayWindow
                                                               attribute:NSLayoutAttributeHeight
                                                              multiplier:1
                                                                constant:0]];
        
        [overlayWindow  addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterX
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:overlayWindow
                                                               attribute:NSLayoutAttributeCenterX
                                                              multiplier:1
                                                                constant:0]];
        [overlayWindow addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:overlayWindow
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0]];
        ///////////////////////////////
    }
        
        
//        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];

        
        self.subTitleLabel.text = @"Slide up to cancel";
        self.subTitleLabel.textColor = [UIColor whiteColor];
        
        self.titleLabel.text = @"Time Limit";
        self.titleLabel.textColor = [UIColor whiteColor];
        
        self.centerLabel.text = @"60";
        self.centerLabel.textColor = [UIColor yellowColor];
                
        if (myTimer)
            [myTimer invalidate];
        myTimer = nil;
        myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                   target:self
                                                 selector:@selector(startAnimation)
                                                 userInfo:nil
                                                  repeats:YES];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             self.alpha = 1;
                         }
                         completion:^(BOOL finished){
                         }];
        [self setNeedsDisplay];
    });
}
-(void) startAnimation
{
    angle -= 3;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.09];
    UIView.AnimationRepeatAutoreverses = YES;
    self.edgeImageView.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    float second = [self.centerLabel.text floatValue];
    if (second <= 10.0f) {
        self.centerLabel.textColor = [UIColor redColor];
    }else{
        self.centerLabel.textColor = [UIColor yellowColor];
    }
    self.centerLabel.text = [NSString stringWithFormat:@"%.1f",second-0.1];
    [UIView commitAnimations];
}

+ (void)changeSubTitle:(NSString *)str
{
    [[EZProgressHUD sharedView] setState:str];
}

- (void)setState:(NSString *)str
{
    self.subTitleLabel.text = str;
}

+ (void)dismissWithSuccess:(NSString *)str {
    [[EZProgressHUD sharedView] dismiss:str];
}

+ (void)dismissWithError:(NSString *)str {
    [[EZProgressHUD sharedView] dismiss:str];
}

- (void)dismiss:(NSString *)state {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [myTimer invalidate];
        myTimer = nil;
        self.subTitleLabel.text = nil;
        self.titleLabel.text = nil;
        self.centerLabel.text = state;
        self.centerLabel.textColor = [UIColor whiteColor];
        
        CGFloat timeLonger;
        if ([state isEqualToString:@"TooShort"]) {
            timeLonger = 1;
        }else{
            timeLonger = 0.6;
        }
        [UIView animateWithDuration:timeLonger
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             self.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             if(self.alpha == 0) {
//                                 [self.centerLabel removeFromSuperview];
//                                 self.centerLabel = nil;
//                                 [self.edgeImageView removeFromSuperview];
//                                 self.edgeImageView = nil;
//                                 [self.subTitleLabel removeFromSuperview];
//                                 self.subTitleLabel = nil;
                                 
                                 NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
                                 [windows removeObject:overlayWindow];
                                 overlayWindow = nil;
                                 
                                 [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
                                     if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
                                         [window makeKeyWindow];
                                         *stop = YES;
                                     }
                                 }];
                             }
                         }];
    });
}

- (UIWindow *)overlayWindow {
    if(!overlayWindow) {
        
//        overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        overlayWindow = [[UIWindow alloc] init];
        overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        overlayWindow.userInteractionEnabled = NO;
        [overlayWindow setTranslatesAutoresizingMaskIntoConstraints:NO];
        overlayWindow.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];

        [overlayWindow makeKeyAndVisible];
    }
    return overlayWindow;
}
@end
