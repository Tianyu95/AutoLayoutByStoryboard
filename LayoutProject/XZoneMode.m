//
//  XZoneMode.m
//  LayoutProject
//
//  Created by C on 16/2/1.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XZoneMode.h"


@implementation XZoneMode

- (void)setContentText:(NSString *)contentText{

    _contentText = contentText;

    // 如果文本内容大于136，截取出来并则传给_modifyContentTextx属性
    if ( _contentText.length > 136 ) {
        
        // 再截取136以内的字符，并且拼接一行空格，并复制给修改的_modifyContentText属性保存
        NSRange subRange = {0,136};
        NSString *subString = [_contentText substringWithRange:subRange];
        _modifyContentText = subString;
        
    }else{
        _modifyContentText = nil;
    }
}



@end


//评论数据定义
@implementation XZoneCommentMode

@end