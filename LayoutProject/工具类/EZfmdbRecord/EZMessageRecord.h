//
//  EZMessageRecord.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/9.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "EZChatMessageModel.h"

@interface EZMessageRecord : NSObject
{
    FMDatabase *dataBase;
}

- (BOOL)initDatabase:(NSString *)dbName;

- (BOOL)createMessageTable;


- (BOOL)addMessage;
- (BOOL)addMessage:(EZChatMessageModel *)item;

- (NSMutableArray *)getMessage;

//通过chatid查询
- (NSMutableArray *)getMessageByChatid:(NSString *)chatid;

- (NSMutableArray *)getMessageForAllPeople;


- (BOOL)removeMessageByChatid:(NSString *)chatid;
- (BOOL)removeAllMessage;


- (BOOL) onleftjia;

@end
