//
//  ZHomeListResultCell.h
//  lottery
//
//  Created by zzz on 2018/7/2.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHomeListResultCell : UITableViewCell
@property (nonatomic,copy) NSString *result;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight:(id)sender;
@end
