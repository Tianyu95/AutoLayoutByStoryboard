//
//  EZContactRecord.m
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/16.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import "EZContactRecord.h"

@implementation EZContactRecord

- (BOOL)initDatabase
{
    // 1 获取数据库对象
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingPathComponent:@"ezContact.sqlite"];
    NSLog(@"path == %@",path);
    dataBase = [FMDatabase databaseWithPath:path];
    // 2 打开数据库，如果不存在则创建并且打开
    BOOL open = [dataBase open];
    if(open){
        NSLog(@"数据库打开成功");
    }
    return open;
}

- (BOOL)createContactTable
{
    /*
     uid
     user_name            姓名
     user_nickname        昵称
     user_image           头像
     sex                  性别
     phone                电话
     email
     */
    //3 创建表
    BOOL c1=[dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS Contact (id integer PRIMARY KEY AUTOINCREMENT, uid text NOT NULL, user_name text NOT NULL, user_nickname text NOT NULL, user_image blob, sex integer, phone text NOT NULL, email text);"];
    if(c1){
        NSLog(@"创建表成功");
    }
    return c1;
}

- (BOOL)addContact{
    //4 插入数据
    NSString * insertSql=@"INSERT INTO Contact(uid, user_name, user_nickname, user_image, sex, phone, email) values(?,?,?,?,?,?,?)";
    
    //插入语句1
    bool inflag3 = [dataBase executeUpdateWithFormat:@"INSERT INTO Contact(uid, user_name, user_nickname, user_image, sex, phone, email) values(%@,%@,%@,%@,%d,%@,%@)",@"00001",@"小明",@"小萌",@"461278934619",1,@"186001",@"abc@sina"];
    
    bool inflag1 = [dataBase executeUpdate:insertSql,@"00002",@"Nicolas",@"Nic",@"1324642",@(0),@"186002",@"jklj@sina"];
    
    bool inflag2 = [dataBase executeUpdate:insertSql withArgumentsInArray:@[@"00003",@"LILEI",@"Li",@"86452542",@(0),@"186003",@"jiofdjas@sina"]];
    
    bool inflag4 = [dataBase executeUpdate:insertSql withArgumentsInArray:@[@"00004",@"HANMEIMEI",@"Han",@"974314523",@(1),@"186004",@"han@sina"]];
    bool inflag5 = [dataBase executeUpdate:insertSql withArgumentsInArray:@[@"00005",@"Chasers",@"Cha",@"752345",@(1),@"186005",@"chasers@sina"]];
    bool inflag6 = [dataBase executeUpdate:insertSql withArgumentsInArray:@[@"00006",@"John Winston Lennon",@"John",@"5432523",@(0),@"186006",@"John@sina"]];
    return inflag1;
}

- (NSMutableArray *)getContact {
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    //查询数据FMDB的FMResultSet提供了多个方法来获取不同类型的数据
    //You code here...
    //时间顺序查询  select * from table order by name collate Chinese_PRC_CS_AS_KS_WS
    NSString *sql = @"SELECT * FROM Contact order by user_name asc, user_nickname asc";
    FMResultSet *result=[dataBase executeQuery:sql];
    while(result.next){
        int ids=[result intForColumn:@"id"];
        NSString * name=[result stringForColumn:@"user_name"];
        //        int ids = [result intForColumnIndex:0];
        //        NSString * name = [result stringForColumnIndex:1];
        NSLog(@"%@,%d",name,ids);
        [arr addObject:name];
    }
    return arr;
}

- (BOOL)removeContactByUid:(NSString *)uid {
    NSString * delete = [NSString stringWithFormat:@"delete from Contact Where uid = '%@'",uid];
    //    NSString * delete = @"delete from Message";
    BOOL dflag = [dataBase executeUpdate:delete];
    if(dflag){
        NSLog(@"删除成功");
    }
    return dflag;
}

@end
