//
//  EZContactRecord.h
//  LayoutProject
//
//  Created by ChenTianyu on 16/3/16.
//  Copyright © 2016年 guangguang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface EZContactRecord : NSObject
{
    FMDatabase *dataBase;
}

- (BOOL)initDatabase;

- (BOOL)createContactTable;


- (BOOL)addContact;

- (NSMutableArray *)getContact;


- (BOOL)removeContactByUid:(NSString *)chatid;
- (BOOL)removeAllContacts;


@end

