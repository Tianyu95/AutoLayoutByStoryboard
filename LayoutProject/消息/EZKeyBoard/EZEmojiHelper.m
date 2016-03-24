//
//  EZEmojiHelper.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/23.
//  Copyright © 2016年 guangguang. All rights reserved.
//http://www.cocoachina.com/ios/20140918/9661.html
//http://my.oschina.net/u/2340880/blog/529078?p=1


//http://kittenyang.com/emotionview/
#import "EZEmojiHelper.h"

@implementation EZEmojiHelper

+(instancetype)shareInstance
{
    static EZEmojiHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EZEmojiHelper alloc] init];
//        NSMutableDictionary *map = [NSMutableDictionary dictionaryWithContentsOfFile:
//                                    [[NSBundle mainBundle] pathForResource:@"CCCexpression" ofType:@"plist"]];
//        sharedInstance.emojiMap = map;
//        sharedInstance.emojiMapR = [NSMutableDictionary dictionaryWithCapacity:map.count];
//        for (int i = 0; i < [map allKeys].count; i++) {
//            NSString *key = [[map allKeys] objectAtIndex:i];
//            NSString *value = [map objectForKey:key];
//            [sharedInstance.emojiMapR setValue:key forKey:value];
//        }
        
        
        NSMutableArray *map = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CCCexpression" ofType:@"plist"]];
        sharedInstance.emojiMap = map;
        sharedInstance.emojiMapImg_str = [NSMutableDictionary dictionaryWithCapacity:map.count];
        sharedInstance.emojiMapStr_img = [NSMutableDictionary dictionaryWithCapacity:map.count];
        
        for (int i = 0; i < map.count; i++) {
            NSDictionary *item = [map objectAtIndex:i];
            NSString *str = [item objectForKey:@"chs"];
            NSString *img = [item objectForKey:@"png"];
            [sharedInstance.emojiMapStr_img setValue:str forKey:img];
            [sharedInstance.emojiMapImg_str setValue:img forKey:str];
        }
        
    });
    return sharedInstance;
}

@end
