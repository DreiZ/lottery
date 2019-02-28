//
//  ZDBBaseStore.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/16.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import "ZDBBaseStore.h"

@implementation ZDBBaseStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [ZDBManager sharedInstance].commonQueue;
    }
    return self;
}

- (BOOL)createTable:(NSString *)tableName withSQL:(NSString *)sqlString
{
    __block BOOL ok = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if(![db tableExists:tableName]){
            ok = [db executeUpdate:sqlString withArgumentsInArray:nil];
        }
    }];
    return ok;
}

- (BOOL)excuteSQL:(NSString *)sqlString withArrParameter:(NSArray *)arrParameter
{
    __block BOOL ok = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withArgumentsInArray:arrParameter];
        }];
    }
    return ok;
}

- (BOOL)excuteSQL:(NSString *)sqlString withDicParameter:(NSDictionary *)dicParameter
{
    __block BOOL ok = NO;
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withParameterDictionary:dicParameter];
        }];
    }
    return ok;
}

- (BOOL)excuteSQL:(NSString *)sqlString,...
{
    __block BOOL ok = NO;
    if (self.dbQueue) {
        va_list args;
        va_list *p_args;
        p_args = &args;
        va_start(args, sqlString);
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            ok = [db executeUpdate:sqlString withVAList:*p_args];
        }];
        va_end(args);
    }
    return ok;
}

- (void)excuteQuerySQL:(NSString*)sqlStr resultBlock:(void(^)(FMResultSet * rsSet))resultBlock
{
    if (self.dbQueue) {
        [_dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet * retSet = [db executeQuery:sqlStr];
            if (resultBlock) {
                resultBlock(retSet);
            }
        }];
    }
}


#pragma mark tableview 新增字段
- (void)addColumnToTable:(NSString *)tableName columnName:(NSString *)columnName {
    if (self.dbQueue) {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            if (![db columnExists:columnName inTableWithName:tableName]){
                NSLog(@"%@表中%@字段不存在",tableName,columnName);
                NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ INTEGER",tableName,columnName];
                BOOL worked = [db executeUpdate:alertStr];
                if(worked){
                    NSLog(@"%@表插入%@字段成功",tableName,columnName);
                }else{
                    NSLog(@"%@表插入%@字段失败",tableName,columnName);
                }
            }else{
                NSLog(@"%@表中%@字段存在",tableName,columnName);
            }
        }];
    }
}
@end
