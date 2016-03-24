//
//  EZChatMessageModel.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/2/26.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EZMessageTypeSending = 0,    //自己发的
    EZMessageTypeReceiving       //
    
} EZMessageType;

typedef enum {
    EZMessageMediaTypeText = 0,          // 文字
    EZMessageMediaTypePhoto = 1,         // 图片
    EZMessageMediaTypeVoice = 2,         // 语音
    EZMessageMediaTypeVideo = 3,
    EZMessageMediaTypeLocalPosition = 4,
} EZMessageMediaType;

@interface EZChatMessageModel : NSObject
{
}


//@property (nonatomic, strong) NSDate *createtime;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *chat_id;
@property (nonatomic, assign) EZMessageType msgtype;
@property (nonatomic, assign) EZMessageMediaType mediaType;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *image_id;
@property (nonatomic, strong) NSData *voice_id;
@property (nonatomic, copy) NSString *voice_duration;
@property (nonatomic, copy) NSString *msg_id;

@property (nonatomic, copy) NSString *sender_id;
@property (nonatomic, copy) NSString *sender_pic;
@property (nonatomic, copy) NSString *sender_name;

//chatid data
@property (nonatomic, copy) NSString *chat_pic;
@property (nonatomic, copy) NSString *chat_name;


@property (nonatomic, assign) BOOL showDateLabel;


@end
/*
 createtime         时间
 chat_id            聊天室id
 msgtype            消息是谁发的  我or对方
 mediaType          消息类型，text，image，voice
 content
 image_id
 voice_id
 voice_duration
 msg_id              消息id
 
 
 createtime         时间
 chat_id            聊天室id
 BOOL c1=[dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS Message (id integer PRIMARY KEY AUTOINCREMENT, createtime int64 NOT NULL, chat_id text NOT NULL, msgtype integer, mediatype integer, content text, image_id text, voice_id text, voice_duration, msgid integer NOT NULL);"];

 jsondata
 */


/*
 一条消息数据
 对方id
 <ToUserID>
 我的ID
 <FromUserID>
 时间
 <CreateTime>1348831860整型
 消息枚举
 <MsgType>[CDATA[text]]
 消息内容
 <Content>[this is a test]
 消息ID
 <MsgId>1234567890123456
 
 
 <MsgType><![CDATA[image]]></MsgType>
 <PicUrl><![CDATA[this is a url]]></PicUrl>图片链接 
 
 <MsgType><![CDATA[voice]]></MsgType>
 <MediaId><![CDATA[media_id]]></MediaId>
 语音消息媒体id
 
 MsgType   消息类型，文本为text，图片为image，语音为voice，
 文字
 图片
 语音
 */


///////////////////////////////////////////////////////////////////////
/*json

 ///////////////
 EZMessageModel~~~send
{
 "createtime":1234567890                    时间
 "touser":"OPENID"                          对方id
 "msgtype":"text"                           消息类型，文本为text，图片为image，语音为voice
 "text":
    {
    "content":"Hello World"
    }
"image":
    {
    "image_id":"MEDIA_ID"
    }
 "voice":
    {
    "voice_id":"MEDIA_ID"
    "voiceDuration":23                       音频时间
    }
 }
 
 EZMessageModel~~~receive
 {
 "createtime":1234567890
 "fromuser":"OPENID"
 "msgtype":"text" ~~~~消息类型，文本为text，图片为image，语音为voice
 "text":
    {
    "content":"Hello World"
    }
 "image":
    {
    "image_id":"MEDIA_ID"
    }
 "voice":
    {
    "voice_id":"MEDIA_ID"
    "voiceDuration":24 音频时间
    }
 }


 
 };
 
 返回数据示例（正确时的JSON返回结果）：
 
 {
 "errcode":0,                                      错误码
 "errmsg":"send job submission success",           错误信息
 "msg_id":34182,                                   消息发送任务的ID
 }

 
 
 ===send text========================
 {
 sn = {115};
 tid = {CarClubiAACxR};
 action = {ez08.cs.message};
 componentname = {0};
 category = {0};
 uri = {0};
 flags = {0};
 extra = {
 cid = {10016};
 
 token = {UwDxHd7LhAaZ29KOLyOZkw==};
 
 target = {10071};
 
 text = {12345};
 
 };
 encflags = {0};
 actionid = {0};
 cid = {0};
 }
 
 ====send pic====
 {
 sn = {119};
 tid = {CarClubiAACxR};
 action = {ez08.cs.message};
 componentname = {0};
 category = {0};
 uri = {0};
 flags = {0};
 extra = {
 cid = {10016};
 
 token = {UwDxHd7LhAaZ29KOLyOZkw==};
 
 target = {10071};
 
 imageurl = {KtT5Pf7oTLaym76OqnO2xw.jpg};
 
 };
 encflags = {0};
 actionid = {0};
 cid = {0};
 }
 */