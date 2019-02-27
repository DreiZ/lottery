//
//  ZMyAllBillListCell.h
//  lottery
//
//  Created by zzz on 2018/6/30.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMyAllBillListCell : UITableViewCell
//０：赢列表　１：赢总额　２：输列表　３：输总额
@property (nonatomic,assign) NSInteger style;
- (void)setLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight:(id)sender;
@end
