//
//  NSObject+Property.m
//  Artwork
//
//  Created by ChenTianyu on 15/8/10.
//  Copyright (c) 2015年 guangguang. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

-(id)property
{
    return objc_getAssociatedObject(self, "Property");
}
-(void)setProperty:(NSMutableDictionary *)property
{
    objc_setAssociatedObject(self, "Property", property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
