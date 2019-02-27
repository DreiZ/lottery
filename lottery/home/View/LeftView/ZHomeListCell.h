//
//  ZHomeListCell.h
//  lottery
//
//  Created by zzz on 2018/6/28.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZInningModel.h"

@interface ZHomeListCell : UITableViewCell
@property (assign, nonatomic) BOOL isTFEnable;
@property (nonatomic,strong) ZInningListModel *listModel;

@property (strong, nonatomic) void (^nameBeginChange)(NSString *value);
@property (strong, nonatomic) void (^nameValueChange)(NSString *value);

@property (strong, nonatomic) void (^valueChange)(NSString *value);
@property (strong, nonatomic) void (^beginChange)(UITextField *textField);
@property (strong, nonatomic) void (^endChange)(UITextField *textField);

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight:(id)sender;
@end
