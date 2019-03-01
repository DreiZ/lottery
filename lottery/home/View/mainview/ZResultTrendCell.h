//
//  ZResultTrendCell.h
//  lottery
//
//  Created by 承希-开发 on 2019/2/27.
//  Copyright © 2019 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLotteryModel.h"


@interface ZResultTrendCell : UITableViewCell
@property (nonatomic,strong) ZLotteryModel *model;
@property (nonatomic,strong) ZLotteryModel *beforeModel;
@property (nonatomic,strong) ZLotteryModel *afterModel;

- (void)setModel:(ZLotteryModel *)model before:(ZLotteryModel *)before after:(ZLotteryModel *)after;
- (void)setFirstLine;
+ (instancetype)cellWithTableView:(UITableView *)tableView ;
+ (CGFloat)getCellHeight:(id)sender ;
@end

