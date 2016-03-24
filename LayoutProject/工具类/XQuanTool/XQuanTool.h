//
//  XQuanTool.h
//  Artwork
//
//  Created by ChenTianyu on 15/8/10.
//  Copyright (c) 2015年 guangguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


//默认头像
#define IMAGESEX(sex) [UIImage imageNamed:(sex == 0) ? @"male_default" : ((sex == 1) ? @"female_default" : @"male_default")]

//STR
#define XQUAN_IMAGESTR_TINY(imageid)   [NSString stringWithFormat:@"http://7xnm3j.com2.z0.glb.qiniucdn.com/%@_tiny", imageid]

//URL
#define  XQUAN_IMAGEURL_TINY(imageid) imageid != nil ? [NSURL URLWithString:[NSString stringWithFormat:@"http://7xnm3j.com2.z0.glb.qiniucdn.com/%@_tiny", imageid]] : nil

#define XQUAN_IMAGEURL_LARGE(imageid)      imageid != nil ? [NSURL URLWithString:[NSString stringWithFormat:@"http://7xnm3j.com2.z0.glb.qiniucdn.com/%@_large", imageid]] : nil
#define XQUAN_IMAGEURL_ORIGINAL(imageid)      imageid != nil ? [NSURL URLWithString:[NSString stringWithFormat:@"http://7xnm3j.com2.z0.glb.qiniucdn.com/%@", imageid]] : nil

//名字颜色
#define XCOLOR_NAME XQUANRGBCOLOR(87, 107, 149)
//时间颜色
#define XCOLOR_TIME XQUANRGBCOLOR(177, 177, 177)

#define XQUANRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


typedef NS_ENUM(NSInteger, XQuanAction) {
    XQuanAction_Header                      = 0,//头像
    XQuanAction_Praise                      = 1,//赞
    XQuanAction_Comment                     = 2,//评论
    XQuanAction_Transpond                   = 3,//转发
    XQuanAction_Collect                     = 4,//收藏
    XQuanAction_Delete                      = 5,//删除
    XQuanAction_Report                      = 6,//举报
    XQuanAction_Content                     = 7,//内容
    XQuanAction_Labels                      = 8,//标签
};

@interface XQuanTool : NSObject


+(NSString *)dateToQuanDate:(NSDate *)date;

+(NSString *)dateToQuanTime:(int64_t)time;

+(NSDate *)dateLonglongToDate:(int64_t)time;

+(CGSize)getStringSize:(NSString *)content font:(UIFont *)font width:(CGFloat)width;
+(CGSize)getStringSize:(NSString *)content font:(UIFont *)font height:(CGFloat)height;

+(int64_t)longlongFromDate:(NSDate *)date;

@end
