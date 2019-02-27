//
//  ZHomeListAddTFCell.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHomeTextFieldView.h"

@interface ZHomeListAddTFCell : UITableViewCell
@property (nonatomic,strong) ZHomeTextFieldView *inputView;

@property (assign, nonatomic) BOOL isCustomKeyboard;
@property (strong, nonatomic) void (^valueChange)(NSString *value);
@property (strong, nonatomic) void (^beginChange)(UITextField *textField);
@property (strong, nonatomic) void (^endChange)(UITextField *textField);
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight:(id)sender;
@end
