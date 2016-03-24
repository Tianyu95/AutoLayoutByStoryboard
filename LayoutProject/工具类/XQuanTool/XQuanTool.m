//
//  XQuanTool.m
//  Artwork
//
//  Created by ChenTianyu on 15/8/10.
//  Copyright (c) 2015年 guangguang. All rights reserved.
//

#import "XQuanTool.h"

@implementation XQuanTool


+(NSString *)dateToQuanDate:(NSDate *)date
{
    NSString *result = @"未知";
    if(date){
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *offset = [cal components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date toDate:[NSDate date] options:0];
        if(offset.day > 0){
            result = [NSString stringWithFormat:@"%d天前", (int)offset.day];
        }else if(offset.hour > 0){
            result = [NSString stringWithFormat:@"%d小时前", (int)offset.hour];
        }else if(offset.minute > 0){
            result = [NSString stringWithFormat:@"%d分钟前", (int)offset.minute];
        }else if(offset.second > 0){
            result = @"刚刚";
        }
    }
    return result;
}

+(NSString *)dateToQuanTime:(int64_t)time
{
    NSString *result = @"未知";
    if(time > 0){
        NSDate *date = [XQuanTool dateLonglongToDate:time];
        result = [XQuanTool dateToQuanDate:date];
    }
    return result;
}

+(NSDate *)dateLonglongToDate:(int64_t)time
{
    if(time > 0){
        NSTimeZone* zone = [NSTimeZone systemTimeZone];
        NSDateFormatter *zoneformat = [[NSDateFormatter alloc] init];
        [zoneformat setDateFormat:@"yyyyMMddHHmmss"];
        [zoneformat setTimeZone:zone];
        return [zoneformat dateFromString:[NSString stringWithFormat:@"%lld",time]];
    }else{
        return nil;
    }
}

+(int64_t)longlongFromDate:(NSDate *)date
{
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyyMMddHHmmss"];
    [format setTimeZone:destinationTimeZone];
    NSString *destDateString = [format stringFromDate:date];
    return destDateString.longLongValue;
}


+(CGSize)getStringSize:(NSString *)content font:(UIFont *)font width:(CGFloat)width
{
    CGSize size;
    if(content && content.length > 0 && font){
#ifdef __IPHONE_7_0
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
        size= [content  boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
#else
        size=[content sizeWithFont:font constrainedToSize:CGSizeMake(width,MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
#endif
    }
    return size;
}

+(CGSize)getStringSize:(NSString *)content font:(UIFont *)font height:(CGFloat)height
{
    CGSize size;
    if(content && content.length > 0 && font){
#ifdef __IPHONE_7_0
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
        size= [content  boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
#else
        size=[content sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT,height) lineBreakMode:NSLineBreakByCharWrapping];
#endif
    }
    return size;
}


@end
