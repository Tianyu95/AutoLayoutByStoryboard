//
//  XZoneMode.h
//  LayoutProject
//
//  Created by C on 16/2/1.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <Foundation/Foundation.h>


#define contentLabelFont 15

@interface XZoneMode : NSObject

/**  转发提示文字内容   */
@property (copy, nonatomic) NSString *forwardRemindText;

/**  头像名称   */
@property (copy, nonatomic) NSString *userHeaderImageName;
/**  姓名   */
@property (copy, nonatomic) NSString *userNameText;
/**  时间   */
@property (copy, nonatomic) NSString *userTimeText;
/**  标签   */
@property (copy, nonatomic) NSString *userMarkText;

/**  原内容文本   */
@property (copy, nonatomic) NSString *contentText;
/**  修改内容文本   */
@property (copy, nonatomic) NSString *modifyContentText;
@property (assign,nonatomic) BOOL isShowFullText;

/**  图片1到9数组   */
@property (nonatomic,copy) NSArray *imageArray;

/**  评论1到4内容   */
@property (copy, nonatomic) NSArray *commentArray;

@end


//评论数据定义
@interface XZoneCommentMode : NSObject

@property (nonatomic, strong) NSString *xid;                //id
@property (nonatomic, strong) NSString *targetid;           //回复目标cid
@property (nonatomic, strong) NSString *content;            //评论内容
@property (nonatomic, strong) NSString *criticid;           //评论人id
@property (nonatomic, strong) NSString *rootid;             //原文id
@property (nonatomic, assign) int64_t   time;               //评论时间(年月日时分秒)
@property (nonatomic, strong) NSString *criticidname;       //评论人名字
@property (nonatomic, strong) NSString *criticidimageid;    //评论人头像id
@property (nonatomic, assign) int32_t   criticidsex;        //性别 (0：男性1：女性2: 未选择)
@property (nonatomic, strong) NSString *targetidname;       //目标cid名字

@end