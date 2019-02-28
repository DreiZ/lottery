//
//  ZLotteryManage.m
//  lottery
//
//  Created by 承希-开发 on 2019/2/27.
//  Copyright © 2019 zzz. All rights reserved.
//

#import "ZLotteryManager.h"
#import "ZDBLotteryStore.h"

static ZLotteryManager *sharedManager;

@interface ZLotteryManager ()
@property (nonatomic,strong) ZDBLotteryStore *store;

@end

@implementation ZLotteryManager

+ (ZLotteryManager *)sharedManager {
    @synchronized (self) {
        if (!sharedManager) {
            sharedManager = [[ZLotteryManager alloc] init];
        }
    }
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _fontMultiple = 1;
    _contWidthMultiple = 1;
    
    _store = [[ZDBLotteryStore alloc] init];
}

- (NSArray *)span:(ZLotteryModel *)model
{
    NSMutableArray *tempArr = @[].mutableCopy;
    if (![model.lottery_num1 isEqualToString:model.lottery_num2]) {
        [tempArr addObject:model.lottery_num1];
        [tempArr addObject:model.lottery_num2];
        if (![model.lottery_num1 isEqualToString:model.lottery_num3] && ![model.lottery_num2 isEqualToString:model.lottery_num3]) {
            [tempArr addObject:model.lottery_num3];
        }
    }else{
        [tempArr addObject:model.lottery_num1];
        if (![model.lottery_num1 isEqualToString:model.lottery_num3]) {
            [tempArr addObject:model.lottery_num3];
        }
    }
    
    return tempArr;
}

- (NSInteger)numAnd:(ZLotteryModel *)model {
    return [model.lottery_num1 integerValue] + [model.lottery_num2 integerValue] + [model.lottery_num3 integerValue];
}

- (BOOL)isBig:(ZLotteryModel *)model {
    return [model.lottery_num1 integerValue] + [model.lottery_num2 integerValue] + [model.lottery_num3 integerValue] > 10 ? YES:NO;
}


- (BOOL)isDouble:(ZLotteryModel *)model {
    return ([model.lottery_num1 integerValue] + [model.lottery_num2 integerValue] + [model.lottery_num3 integerValue]) %2 == 0 ? YES:NO;
}

- (NSInteger)diff:(ZLotteryModel *)model {
    return [model.lottery_num3 integerValue] - [model.lottery_num1 integerValue];
}

//历史记录
- (void)lotteryRecordForFromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, NSDate*, BOOL))complete
{
    [self.store lotteryByFromDate:date count:20 complete:^(NSArray *data, BOOL hasMore) {
        complete(data,date, hasMore);
    }];
}
@end
