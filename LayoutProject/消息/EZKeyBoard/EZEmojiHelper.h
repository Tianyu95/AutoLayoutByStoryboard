//
//  EZEmojiHelper.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/23.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZEmojiHelper : NSObject


/**
 *  all emoji
 */
@property (nonatomic, strong) NSMutableArray *emojiMap;

/**
 *  key:图片名 value:表情描述
 */
@property (nonatomic, strong) NSMutableDictionary *emojiMapImg_str;

/**
 *  key:表情描述 value:图片名
 */
@property (nonatomic, strong) NSMutableDictionary *emojiMapStr_img;

+(instancetype)shareInstance;

@end
