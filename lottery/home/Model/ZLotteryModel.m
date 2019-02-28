//
//  ZLotteryModel.m
//  lottery
//
//  Created by 承希-开发 on 2019/2/27.
//  Copyright © 2019 zzz. All rights reserved.
//

#import "ZLotteryModel.h"

@implementation ZLotteryModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _lottery_id = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
        _lottert_serial_number = @"";
        _lottery_num1 = @"";
        _lottery_num2 = @"";
        _lottery_num3 = @"";
        
        _lottery_day = [[NSDate alloc] init];
    }
    return self;
}
@end
