//
//  ZHomeTextFieldView.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTextField.h"

@interface ZHomeTextFieldView : UIView
@property (nonatomic,strong) ZTextField *inputTF;
//输入类型
@property (assign, nonatomic) HNFormatterType formatterType;
//自定义类型
@property (strong, nonatomic) NSString *inputTypeStr;
//长度限制 默认8
@property (assign, nonatomic) NSInteger max;
@property (assign, nonatomic) BOOL isCustomKeyboard;
@property (strong, nonatomic) void (^valueChange)(NSString *value);
@property (strong, nonatomic) void (^beginChange)(UITextField *textField);
@property (strong, nonatomic) void (^endChange)(UITextField *textField);

- (void)setIsCustomKeyboardType:(BOOL)isCustomKeyboard;
@end
