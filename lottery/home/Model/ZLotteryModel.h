//
//  ZLotteryModel.h
//  lottery
//
//  Created by 承希-开发 on 2019/2/27.
//  Copyright © 2019 zzz. All rights reserved.
//

#import "ZBaseModel.h"


@interface ZLotteryModel : ZBaseModel
@property(nonatomic, strong) NSString *lottery_id;
@property (nonatomic,strong) NSString *lottert_serial_number;

@property(nonatomic, strong) NSString *lottery_num1;
@property(nonatomic, strong) NSString *lottery_num2;
@property(nonatomic, strong) NSString *lottery_num3;
@property(nonatomic, strong) NSDate *lottery_day;
@end

