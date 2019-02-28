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

//1:3数相等 2:2数相等 3:顺子 4:普通号
- (NSInteger)type:(ZLotteryModel *)model {
    if ([model.lottery_num1 isEqualToString:model.lottery_num2] && [model.lottery_num1 isEqualToString:model.lottery_num3]) {
        return 1;
    }else if ([model.lottery_num1 isEqualToString:model.lottery_num2] || [model.lottery_num1 isEqualToString:model.lottery_num3] || [model.lottery_num2 isEqualToString:model.lottery_num3]){
        return 2;
    }else {
        if (([model.lottery_num2 integerValue] - [model.lottery_num1 integerValue] == 1 && [model.lottery_num3 integerValue] - [model.lottery_num2 integerValue] == 1)) {
            return 3;
        }
        return 4;
    }
}


#pragma mark - //历史记录
- (void)lotteryRecordForFromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, NSDate*, BOOL))complete
{
    [self.store lotteryByFromDate:date count:20 complete:^(NSArray *data, BOOL hasMore) {
        complete(data,date, hasMore);
    }];
}

- (ZLotteryModel *)saveLotteryWithNum1:(NSString *)num1 num2:(NSString *)num2 num3:(NSString *)num3 {
    ZLotteryModel *model = [[ZLotteryModel alloc] init];
    NSMutableArray *tempArr = @[].mutableCopy;
    [tempArr addObject:num1];
    [tempArr addObject:num2];
    [tempArr addObject:num3];
    
    [self bubbleDescendingOrderSortWithArray:tempArr];
    model.lottery_num1 = tempArr[0];
    model.lottery_num2 = tempArr[1];
    model.lottery_num3 = tempArr[2];
    
    model.lottery_day = [NSDate new];
    
    ZLotteryModel *last = [self.store lastLottery];
    if (last) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSString *lastDate = [NSString stringWithFormat:@"%@000000",[formatter stringFromDate:last.lottery_day]];
        NSString *nowDate = [NSString stringWithFormat:@"%@000000",[formatter stringFromDate:[NSDate new]]];
        if ([lastDate isEqualToString:nowDate]) {
            model.lottert_serial_number = [NSString stringWithFormat:@"%ld", [last.lottert_serial_number integerValue] + 1];
        }else{
            model.lottert_serial_number = @"1";
        }
    }else{
        model.lottert_serial_number = @"1";
    }
    
    [self.store addLottery:model];
    
    return model;
}


- (void)clearHistoryData {
    [self.store deleteAllLottery];
}

#pragma mark - tools
// - 冒泡降序排序
- (void)bubbleDescendingOrderSortWithArray:(NSMutableArray *)descendingArr
{
    for (int i = 0; i < descendingArr.count; i++) {
        for (int j = 0; j < descendingArr.count - 1 - i; j++) {
            if ([descendingArr[j] intValue] > [descendingArr[j + 1] intValue]) {
                int tmp = [descendingArr[j] intValue];
                descendingArr[j] = descendingArr[j + 1];
                descendingArr[j + 1] = [NSString stringWithFormat:@"%d",tmp];
            }
        }
    }
    NSLog(@"冒泡降序排序后结果：%@", descendingArr);
}
@end
