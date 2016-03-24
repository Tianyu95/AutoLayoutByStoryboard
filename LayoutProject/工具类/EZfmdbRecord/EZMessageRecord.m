//
//  EZMessageRecord.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/9.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZMessageRecord.h"


@implementation EZMessageRecord

- (BOOL)initDatabase:(NSString *)dbName
{
    // 1 获取数据库对象
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"ezMessage.sqlite"];
    NSLog(@"path == %@",path);
    dataBase = [FMDatabase databaseWithPath:path];
    // 2 打开数据库，如果不存在则创建并且打开
    BOOL open = [dataBase open];
    if(open){
        NSLog(@"数据库打开成功");
    }
    return open;
}

- (BOOL)createMessageTable
{
    /*
     createtime         时间
     chat_id            聊天室id
     userid                senderid
     userpic
     username
     msgtype            消息是谁发的  我or对方
     mediaType          消息类型，text，image，voice
     content
     image_id
     voice_id
     voice_duration
     msg_id              消息id
     
     chat_pic
     chat_name
     
     createtime         时间
     chat_id            聊天室id

     jsondata
     */
    //3 创建表
    BOOL c1=[dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS Message (id integer PRIMARY KEY AUTOINCREMENT, createtime int64 NOT NULL, chat_id text NOT NULL, userid text NOT NULL, userpic text, username text NOT NULL,msgtype integer, mediatype integer, content text, image_id blob, voice_id blob, voice_duration text, msgid integer NOT NULL, chat_pic text, chat_name text NOT NULL);"];
    if(c1){
        NSLog(@"创建表成功");
    }
    return c1;
}

- (BOOL) onleftjia {
    NSString * insertSql=@"INSERT INTO Message(createtime, chat_id, userid, userpic, username, msgtype, mediatype, content, image_id, voice_id, voice_duration, msgid, chat_pic, chat_name) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    bool inflag1 = [dataBase executeUpdate:insertSql,@(20160317080852),@"chat_id5",@"user98",@"userpic",@"小新",@(1),@(0),@"小新content",@"",@"",@"",@(9878936218964),@"chat_id5",@"chat_id5"];
    return inflag1;

}
- (BOOL)addMessage {
    //4 插入数据
    NSString * insertSql=@"INSERT INTO Message(createtime, chat_id, userid, userpic, username, msgtype, mediatype, content, image_id, voice_id, voice_duration, msgid, chat_pic, chat_name) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

    //插入语句1
    bool inflag3 = [dataBase executeUpdateWithFormat:@"INSERT INTO Message(createtime, chat_id, userid, userpic, username, msgtype, mediatype, content, image_id, voice_id, voice_duration, msgid, chat_pic, chat_name) values(%ld,%@,%@,%@,%@,%d,%d,%@,%@,%@,%@,%d,%@,%@)",20160306151752,@"chat_id3",@"user321",@"小花",@"userpic",1,1,@"",@"imageid",@"",@"",12342314,@"chat_id3",@"chat_id3"];

    
    bool inflag1 = [dataBase executeUpdate:insertSql,@(20160316151752),@"chat_id1",@"user321",@"userpic",@"小花",@(1),@(0),@"12[发呆]3",@"",@"",@"",@(9878936218964),@"chat_id1",@"chat_id1"];

    bool inflag2 = [dataBase executeUpdate:insertSql withArgumentsInArray:@[@(20160316103752),@"chat_id2",@"user321",@"userpic",@"tianyu",@(0),@(2),@"",@"",@"voiceid",@"5s",@(75436741354325),@"chat_id2",@"chat_id2"]];
    
    bool inflag4 = [dataBase executeUpdate:insertSql withArgumentsInArray:@[@(20160316114752),@"chat_id2",@"user321",@"userpic",@"tianyu",@(1),@(0),@"hehe[发呆]",@"",@"",@"",@(8765953654),@"chat_id2",@"chat_id2"]];
    bool inflag5 = [dataBase executeUpdate:insertSql withArgumentsInArray:@[@(20160316082754),@"chat_id2",@"user321",@"userpic",@"tianyu",@(0),@(0),@"keke[憨笑]",@"",@"",@"",@(7225882656),@"chat_id2",@"chat_id2"]];
    bool inflag6 = [dataBase executeUpdate:insertSql withArgumentsInArray:@[@(20160316141952),@"chat_id3",@"user321",@"userpic",@"LEI",@(1),@(2),@"",@"",@"124135",@"10s",@(974672457),@"chat_id2",@"chat_id2"]];

    
    return inflag1;
}

- (BOOL)addMessage:(EZChatMessageModel *)item {
    NSString * insertSql=@"INSERT INTO Message(createtime, chat_id, userid, userpic, username, msgtype, mediatype, content, image_id, voice_id, voice_duration, msgid, chat_pic, chat_name) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    bool inflag1 = [dataBase executeUpdate:insertSql,item.createtime,item.chat_id,item.sender_id,item.sender_pic,item.sender_name,@(item.msgtype),@(item.mediaType),item.content,item.image_id,item.voice_id,item.voice_duration,item.msg_id,item.chat_pic,item.chat_name];
    return inflag1;
}
- (NSMutableArray *)getMessage {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    //查询数据FMDB的FMResultSet提供了多个方法来获取不同类型的数据
    NSDate* tmpStartData = [NSDate date];
    //You code here...
    //时间顺序查询
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM Message where createtime <%@ order by createtime desc",[self stringFromDate:tmpStartData]];//desc limit 0,10

    FMResultSet *result=[dataBase executeQuery:sql];
    while(result.next){
        EZChatMessageModel *item = [[EZChatMessageModel alloc] init];
//        item.createtime = [result dateForColumn:@"createtime"];
        item.createtime = [result stringForColumn:@"createtime"];
        item.chat_id = [result stringForColumn:@"chat_id"];
        item.sender_id = [result stringForColumn:@"userid"];
        item.sender_pic = [result stringForColumn:@"userpic"];
        item.sender_name = [result stringForColumn:@"username"];
        item.msgtype = [result intForColumn:@"msgtype"];
        item.mediaType = [result intForColumn:@"mediatype"];
        item.content = [result stringForColumn:@"content"];
        item.image_id = [result stringForColumn:@"image_id"];
        item.voice_id = [result dataForColumn:@"voice_id"];
        item.voice_duration = [result stringForColumn:@"voice_duration"];
        item.msg_id = [result stringForColumn:@"msgid"];
        item.chat_pic = [result stringForColumn:@"chat_pic"];
        item.chat_name = [result stringForColumn:@"chat_name"];
        
//        int ids=[result intForColumn:@"id"];
//        int ids = [result intForColumnIndex:0];
//        NSString * name = [result stringForColumnIndex:1];
        if (item.msgtype) {
            NSLog(@"yyyy = %d",item.msgtype);
        } else {
            NSLog(@"nnnn = %d",item.msgtype);
        }
        [arr addObject:item];
    }
    return arr;
}

//通过chatid查询
- (NSMutableArray *)getMessageByChatid:(NSString *)chatid {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    NSDate* tmpStartData = [NSDate date];
    //You code here...
//    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM Message where chat_id='%@' and createtime <'%@' order by createtime asc limit 0,10",chatid,[self stringFromDate:tmpStartData]];
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM Message where chat_id='%@' and createtime <'%@' order by createtime asc",chatid,[self stringFromDate:tmpStartData]];

    FMResultSet *result=[dataBase executeQuery:sql];
    while(result.next){
        EZChatMessageModel *item = [[EZChatMessageModel alloc] init];
//        item.createtime = [result dateForColumn:@"createtime"];
        item.createtime = [result stringForColumn:@"createtime"];
        item.chat_id = [result stringForColumn:@"chat_id"];
        item.sender_id = [result stringForColumn:@"userid"];
        item.sender_pic = [result stringForColumn:@"userpic"];
        item.sender_name = [result stringForColumn:@"username"];
        item.msgtype = [result intForColumn:@"msgtype"];
        item.mediaType = [result intForColumn:@"mediatype"];
        item.content = [result stringForColumn:@"content"];
        item.image_id = [result stringForColumn:@"image_id"];
        item.voice_id = [result dataForColumn:@"voice_id"];
        item.voice_duration = [result stringForColumn:@"voice_duration"];
        item.msg_id = [result stringForColumn:@"msgid"];
        item.chat_pic = [result stringForColumn:@"chat_pic"];
        item.chat_name = [result stringForColumn:@"chat_name"];
        //        int ids = [result intForColumnIndex:0];
        //        NSString * name = [result stringForColumnIndex:1];
        [arr addObject:item];
    }
    return arr;
}

//获取最新一条消息
- (NSMutableArray *)getMessageForAllPeople {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    //You code here...
    NSString *sql = @"SELECT * FROM Message where chat_id in(SELECT DISTINCT chat_id FROM Message) and createtime in (SELECT max(createtime) from Message group by chat_id) order by createtime desc";
    
    FMResultSet *result=[dataBase executeQuery:sql];
    while(result.next){
        EZChatMessageModel *item = [[EZChatMessageModel alloc] init];
//        item.createtime = [result dateForColumn:@"createtime"];
        item.createtime = [result stringForColumn:@"createtime"];
        item.chat_id = [result stringForColumn:@"chat_id"];
        item.sender_id = [result stringForColumn:@"userid"];
        item.sender_pic = [result stringForColumn:@"userpic"];
        item.sender_name = [result stringForColumn:@"username"];
        item.msgtype = [result intForColumn:@"msgtype"];
        item.mediaType = [result intForColumn:@"mediatype"];
        item.content = [result stringForColumn:@"content"];
        item.image_id = [result stringForColumn:@"image_id"];
        item.voice_id = [result dataForColumn:@"voice_id"];
        item.voice_duration = [result stringForColumn:@"voice_duration"];
        item.msg_id = [result stringForColumn:@"msgid"];
        item.chat_pic = [result stringForColumn:@"chat_pic"];
        item.chat_name = [result stringForColumn:@"chat_name"];

//        int ids=[result intForColumn:@"id"];
        [arr addObject:item];
    }
    
    return arr;
}




- (BOOL)removeMessageByChatid:(NSString *)chatid {
    NSString * delete = [NSString stringWithFormat:@"delete from Message Where chat_id = '%@'",chatid];
//    NSString * delete = @"delete from Message";
    BOOL dflag = [dataBase executeUpdate:delete];
    if(dflag){
        NSLog(@"删除成功");
    }
    return dflag;
}

- (BOOL)removeAllMessage {
    NSString * delete = @"delete from Message";
    BOOL dflag = [dataBase executeUpdate:delete];
    if(dflag){
        NSLog(@"删除成功");
    }
    return dflag;
}

- (NSDate *)dataFromString:(NSString *)str {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];

     NSDate *date = [dateFormatter dateFromString:str];
    return date;
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];

    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:destinationTimeZone];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
@end
