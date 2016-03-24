//
//  AppDelegate.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/1/27.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime message:(NSString *)mStr;
// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key;

@end

