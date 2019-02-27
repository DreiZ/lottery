//
//  ZRightCustomKeyBoardView.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTextField.h"
@protocol PGNumberKeyboardDelegate <NSObject>
@optional
- (void)editChanage:(id)sender;
@end


@interface ZRightCustomKeyBoardView : UIView
@property (nonatomic, strong) id<PGNumberKeyboardDelegate> delegate;
@property (nonatomic, weak) ZTextField *textField;
@property (nonatomic, weak) UITextView *textView;

/**
 此属性默认为true
 如果不需要规范小数或负数的正确性，可以将此属性设置为false
 如果此属性设置为false，则可以输入任何类型的数字，比如：23-45.4545 这种不规范的数字，如果设置为ture则不会输入这种不规范的数字
 */
@property (nonatomic, assign) BOOL verify;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *keyboardView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *inputLabel;

@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *dotButton;
@property (nonatomic, strong) UIButton *minusButton;

@property (nonatomic, strong) UIButton *zeroButton;
@property (nonatomic, strong) UIButton *oneButton;
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, strong) UIButton *threeButton;
@property (nonatomic, strong) UIButton *fourButton;
@property (nonatomic, strong) UIButton *fiveButton;
@property (nonatomic, strong) UIButton *sixButton;
@property (nonatomic, strong) UIButton *sevenButton;
@property (nonatomic, strong) UIButton *eightButton;
@property (nonatomic, strong) UIButton *nineButton;

@property (nonatomic,strong) void (^addBlock)(void);
@property (nonatomic,strong) void (^changeBlock)(void);

- (instancetype)initWithTextField:(UITextField *)textField;
- (instancetype)initWithTextView:(UITextView *)textView;

- (void)setTopTitle:(NSString *)title value:(NSString *)value;
/**
 切换系统输入法
 */
- (void)reloadInputViews;
@end
