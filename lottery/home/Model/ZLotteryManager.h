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

- (void)lotteryRecordForFromDate:(NSDate *)date
                           count:(NSUInteger)count
                        complete:(void (^)(NSArray *, NSDate*, BOOL))complete;
@end

