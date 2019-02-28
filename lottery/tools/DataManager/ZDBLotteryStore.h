//
//  ZDBLotteryStore.h
//  
//
//  Created by ZZZ on 16/3/13.
//  Copyright © 2016年 ZZZ. All rights reserved.
//

#import "ZDBLotteryStore.h"
#import "ZDBBaseStore.h"
#import "ZLotteryModel.h"

@interface ZDBLotteryStore : ZDBBaseStore

#pragma mark - 添加
/**
 *  添加记录
 */
- (BOOL)addLottery:(ZLotteryModel *)lottery;

#pragma mark - 查询
/**
 *  获取记录
 */
- (void)lotteryByFromDate:(NSDate *)date
                    count:(NSUInteger)count
                 complete:(void (^)(NSArray *data, BOOL hasMore))complete;


/**
 *  最后一条记录
 */
- (ZLotteryModel *)lastLottery;

#pragma mark - 删除
/**
 *  删除单条
 */
- (BOOL)deleteLotteryByLotteryID:(NSString *)lotteryID;

/**
 *  删除d某天的所有记录
 */
- (BOOL)deleteLottery:(NSDate *)date;

@end
