//
//  ZLotteryManager.h
//  lottery
//
//  Created by 承希-开发 on 2019/2/27.
//  Copyright © 2019 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLotteryModel.h"

@interface ZLotteryManager : NSObject
@property (nonatomic,assign) CGFloat fontMultiple;

@property (nonatomic,assign) CGFloat contWidthMultiple;


+ (ZLotteryManager *)sharedManager ;

- (NSArray *)span:(ZLotteryModel *)model;

- (NSInteger)numAnd:(ZLotteryModel *)model;

- (BOOL)isBig:(ZLotteryModel *)model;


- (BOOL)isDouble:(ZLotteryModel *)model;

- (NSInteger)diff:(ZLotteryModel *)model;

////1:3数相等 2:2数相等 3:顺子 4:普通号
- (NSInteger)type:(ZLotteryModel *)model;

//历史相关
- (void)lotteryRecordForFromDate:(NSDate *)date
                           count:(NSUInteger)count
                        complete:(void (^)(NSArray *, NSDate*, BOOL))complete;

- (ZLotteryModel *)saveLotteryWithNum1:(NSString *)num1 num2:(NSString *)num2 num3:(NSString *)num3 ;
@end

