//
//  ZBottomRntryView.h
//  lottery
//
//  Created by 承希-开发 on 2019/2/26.
//  Copyright © 2019 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLotteryModel.h"

@interface ZBottomRntryView : UIView
@property (nonatomic,strong) void (^addLotteryBlock)(ZLotteryModel *);
@property (nonatomic,strong) void (^cuteBlock)(void);
@property (nonatomic,strong) void (^hiddenBlock)(void);
@end

