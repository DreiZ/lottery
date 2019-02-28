//
//  ZDBMessageStore.m
//  ZChat
//
//  Created by ZZZ on 16/3/13.
//  Copyright © 2016年 ZZZ. All rights reserved.
//

#import "ZDBLotteryStore.h"
#import "ZDBLotteryStoreSQL.h"

@implementation ZDBLotteryStore

- (id)init
{
    if (self = [super init]) {
        self.dbQueue = [ZDBManager sharedInstance].commonQueue;
        BOOL ok = [self createTable];
        if (!ok) {
            NSLog(@"DB: 记录表创建失败");
        }
    }
    return self;
}

- (BOOL)createTable
{
    NSString *sqlString = [NSString stringWithFormat:SQL_CREATE_LOTTERY_TABLE, LOTTERY_TABLE_NAME];
    return [self createTable:LOTTERY_TABLE_NAME withSQL:sqlString];
}

- (BOOL)addLottery:(ZLotteryModel *)lottery
{
    if (lottery == nil || !lottery.lottery_id ) {
        NSLog(@"返回----------_");
        return NO;
    }
    
//    lid, serial_num, num1, num2, num3, date,
    NSString *sqlString = [NSString stringWithFormat:SQL_ADD_LOTTERY, LOTTERY_TABLE_NAME];
    NSArray *arrPara = [NSArray arrayWithObjects:
                        lottery.lottery_id,
                        TLNoNilString(lottery.lottert_serial_number),
                        TLNoNilString(lottery.lottery_num1),
                        TLNoNilString(lottery.lottery_num2),
                        TLNoNilString(lottery.lottery_num3),
                        TLTimeStamp(lottery.lottery_day),
                        @"", @"", @"", @"", @"", nil];
    BOOL ok = [self excuteSQL:sqlString withArrParameter:arrPara];
    if (ok) {
        NSLog(@"保存成功");
    }
    return ok;
}

- (void)lotteryByFromDate:(NSDate *)date
                    count:(NSUInteger)count
                 complete:(void (^)(NSArray *, BOOL))complete
{
    __block NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_LOTTERY_PAGE, LOTTERY_TABLE_NAME, date,(long)(count + 1)];

    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            ZLotteryModel *lottery = [self p_createDBLotteryByFMResultSet:retSet];
            [data insertObject:lottery atIndex:0];
        }
        [retSet close];
    }];
    
    BOOL hasMore = NO;
    if (data.count == count + 1) {
        hasMore = YES;
        [data removeObjectAtIndex:0];
    }
    complete(data, hasMore);
}

- (ZLotteryModel *)lastLottery
{
    NSString *sqlString = [NSString stringWithFormat:SQL_SELECT_LAST_LOTTERY, LOTTERY_TABLE_NAME, LOTTERY_TABLE_NAME];
    __block ZLotteryModel * lottery;
    [self excuteQuerySQL:sqlString resultBlock:^(FMResultSet *retSet) {
        while ([retSet next]) {
            lottery = [self p_createDBLotteryByFMResultSet:retSet];
        }
        [retSet close];
    }];
    return lottery;
}

- (BOOL)deleteLotteryByLotteryID:(NSString *)lotteryID
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_LOTTERY_ID, LOTTERY_TABLE_NAME, lotteryID];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}


- (BOOL)deleteLottery:(NSDate *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *startFormatValue = [NSString stringWithFormat:@"%@000000",[formatter stringFromDate:date]];
    NSString *endFormatValue = [NSString stringWithFormat:@"%@235959",[formatter stringFromDate:date]];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate * startDate = [formatter dateFromString:startFormatValue];
    NSDate * endDate = [formatter dateFromString:endFormatValue];
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_LOTTERY_DATE, LOTTERY_TABLE_NAME, startDate, endDate];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

- (BOOL)deleteAllLottery
{
    NSString *sqlString = [NSString stringWithFormat:SQL_DELETE_LOTTERY_ALL, LOTTERY_TABLE_NAME];
    BOOL ok = [self excuteSQL:sqlString, nil];
    return ok;
}

#pragma mark - Private Methods -
- (ZLotteryModel *)p_createDBLotteryByFMResultSet:(FMResultSet *)retSet
{
//    lid, serial_num, num1, num2, num3, date
    ZLotteryModel * lottery = [[ZLotteryModel alloc] init];
    lottery.lottery_id = [retSet stringForColumn:@"lid"];
    lottery.lottert_serial_number = [retSet stringForColumn:@"serial_num"];
    lottery.lottery_num1 = [retSet stringForColumn:@"num1"];
    lottery.lottery_num2 = [retSet stringForColumn:@"num2"];
    lottery.lottery_num3 = [retSet stringForColumn:@"num3"];
    NSString *dateString = [retSet stringForColumn:@"date"];
    lottery.lottery_day = [NSDate dateWithTimeIntervalSince1970:dateString.doubleValue];
   
    return lottery;
}

@end
