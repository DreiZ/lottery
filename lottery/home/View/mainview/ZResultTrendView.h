//
//  ZResultTrendView.h
//  lottery
//
//  Created by 承希-开发 on 2019/2/26.
//  Copyright © 2019 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLotteryModel.h"

@interface ZResultTrendView : UIView
@property (nonatomic,strong) void (^scrollBlock)(void);

- (void)addLottery:(ZLotteryModel *)model;

@end

