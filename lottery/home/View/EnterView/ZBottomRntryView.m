//
//  ZBottomRntryView.m
//  lottery
//
//  Created by 承希-开发 on 2019/2/26.
//  Copyright © 2019 zzz. All rights reserved.
//

#import "ZBottomRntryView.h"

@interface ZBottomRntryView ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *firstTF;
@property (nonatomic,strong) UITextField *secondTF;
@property (nonatomic,strong) UITextField *thridTF;
@end

@implementation ZBottomRntryView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectZero];
    contView.backgroundColor = [UIColor clearColor];
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = [UIColor blackColor];
    [contView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor redColor];
    titleLabel.text = @"开奖：";
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [titleLabel setFont:[UIFont systemFontOfSize:13.0f * [ZLotteryManager sharedManager].fontMultiple]];
    [contView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(8);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    [contView addSubview:self.firstTF];
    [contView addSubview:self.secondTF];
    [contView addSubview:self.thridTF];
    
    [self.firstTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(0);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    [self.secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstTF.mas_right).offset(2);
        make.width.height.equalTo(self.firstTF);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    [self.thridTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondTF.mas_right).offset(2);
        make.width.height.equalTo(self.firstTF);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [sureBtn addTarget:self action:@selector(sureBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 15;
    sureBtn.layer.borderColor = [UIColor redColor].CGColor;
    sureBtn.layer.borderWidth = 1;
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:14 * [ZLotteryManager sharedManager].fontMultiple]];
    [contView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.thridTF.mas_right).offset(8);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    UIButton *cutBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [cutBtn addTarget:self action:@selector(cutBtnBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    cutBtn.layer.masksToBounds = YES;
    cutBtn.layer.cornerRadius = 15;
    cutBtn.layer.borderColor = [UIColor redColor].CGColor;
    cutBtn.layer.borderWidth = 1;
    [cutBtn setTitle:@"截屏" forState:UIControlStateNormal];
    [cutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [cutBtn.titleLabel setFont:[UIFont systemFontOfSize:14 * [ZLotteryManager sharedManager].fontMultiple]];
    [contView addSubview:cutBtn];
    [cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
        make.left.equalTo(sureBtn.mas_right).offset(8);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    UIButton *hiddenBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [hiddenBtn addTarget:self action:@selector(hiddenBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    hiddenBtn.layer.masksToBounds = YES;
    hiddenBtn.layer.cornerRadius = 15;
    hiddenBtn.layer.borderColor = kLineColor.CGColor;
    hiddenBtn.layer.borderWidth = 1;
    [hiddenBtn setTitle:@"隐藏" forState:UIControlStateNormal];
    [hiddenBtn setTitleColor:kLineColor forState:UIControlStateNormal];
    [hiddenBtn.titleLabel setFont:[UIFont systemFontOfSize:14 * [ZLotteryManager sharedManager].fontMultiple]];
    [contView addSubview:hiddenBtn];
    [hiddenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
        make.left.equalTo(cutBtn.mas_right).offset(10);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [clearBtn addTarget:self action:@selector(clearBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    clearBtn.layer.masksToBounds = YES;
    clearBtn.layer.cornerRadius = 15;
    clearBtn.layer.borderColor = kLineColor.CGColor;
    clearBtn.layer.borderWidth = 1;
    [clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    [clearBtn setTitleColor:kLineColor forState:UIControlStateNormal];
    [clearBtn.titleLabel setFont:[UIFont systemFontOfSize:14 * [ZLotteryManager sharedManager].fontMultiple]];
    [contView addSubview:clearBtn];
    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(30);
        make.left.equalTo(hiddenBtn.mas_right).offset(10);
        make.centerY.equalTo(contView.mas_centerY);
    }];
}


- (UITextField *)firstTF {
    if (!_firstTF ) {
        _firstTF = [[UITextField alloc] init];
        [_firstTF setFont:[UIFont systemFontOfSize:14 * [ZLotteryManager sharedManager].fontMultiple]];
        [_firstTF setBorderStyle:UITextBorderStyleNone];
        [_firstTF setBackgroundColor:[UIColor clearColor]];
        [_firstTF setPlaceholder:@""];
        _firstTF.keyboardType = UIKeyboardTypeNumberPad;
        _firstTF.tag = 1;
        _firstTF.textAlignment = NSTextAlignmentCenter;
        //        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _firstTF.delegate = self;
        [_firstTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _firstTF.layer.masksToBounds = YES;
        _firstTF.layer.cornerRadius = 18;
        _firstTF.layer.borderColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5].CGColor;
        _firstTF.layer.borderWidth = 0.5;
    }
    return _firstTF;
}


- (UITextField *)secondTF {
    if (!_secondTF ) {
        _secondTF = [[UITextField alloc] init];
        [_secondTF setFont:[UIFont systemFontOfSize:14 * [ZLotteryManager sharedManager].fontMultiple]];
        [_secondTF setBorderStyle:UITextBorderStyleNone];
        [_secondTF setBackgroundColor:[UIColor clearColor]];
        [_secondTF setPlaceholder:@""];
        _secondTF.keyboardType = UIKeyboardTypeNumberPad;
        _secondTF.tag = 2;
        _secondTF.textAlignment = NSTextAlignmentCenter;
        //        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _secondTF.delegate = self;
        [_secondTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _secondTF.layer.masksToBounds = YES;
        _secondTF.layer.cornerRadius = 18;
        _secondTF.layer.borderColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5].CGColor;
        _secondTF.layer.borderWidth = 0.5;
    }
    return _secondTF;
}

- (UITextField *)thridTF {
    if (!_thridTF ) {
        _thridTF = [[UITextField alloc] init];
        [_thridTF setFont:[UIFont systemFontOfSize:14 * [ZLotteryManager sharedManager].fontMultiple]];
        [_thridTF setBorderStyle:UITextBorderStyleNone];
        [_thridTF setBackgroundColor:[UIColor clearColor]];
        [_thridTF setPlaceholder:@""];
        _thridTF.keyboardType = UIKeyboardTypeNumberPad;
        _thridTF.tag = 3;
        _thridTF.textAlignment = NSTextAlignmentCenter;
        //        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _thridTF.delegate = self;
        [_thridTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _thridTF.layer.masksToBounds = YES;
        _thridTF.layer.cornerRadius = 18;
        _thridTF.layer.borderColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5].CGColor;
        _thridTF.layer.borderWidth = 0.5;
    }
    return _thridTF;
}


- (void)textFieldDidChange:(UITextField*)textField {
   
    if (textField.text.length > 1) {
        [self showErrorWithMsg:@"输入内容超出限制"];
        
        NSString *str = textField.text;
        NSInteger length = 1;
        if (str.length <= length) {
            length = str.length - 1;
        }
        str = [str substringToIndex:length];
        textField.text = str;
    }
    
    if (textField == _firstTF && textField.text.length > 0) {
        [_secondTF becomeFirstResponder];
    }
    
    if (textField == _secondTF && textField.text.length > 0) {
        [_thridTF becomeFirstResponder];
    }
    
    if (textField == _thridTF && textField.text.length > 0) {
        [_thridTF resignFirstResponder];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *regexString = @"^\\d*$";;
    
    NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    
    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
}


- (void)sureBtnOnclick:(id)sender {
    if (_firstTF.text && _firstTF.text.length > 0 && _secondTF.text && _secondTF.text.length > 0 && _thridTF.text && _thridTF.text.length > 0) {
        if ([_firstTF.text integerValue] <=0 || [_firstTF.text integerValue] > 6 || [_secondTF.text integerValue] <=0 || [_secondTF.text integerValue] > 6 || [_thridTF.text integerValue] <=0 || [_thridTF.text integerValue] > 6) {
            
            return;
        }
        
        
        ZLotteryModel *model = [[ZLotteryManager sharedManager] saveLotteryWithNum1:_firstTF.text num2:_secondTF.text num3:_thridTF.text];
        if (_addLotteryBlock) {
            _addLotteryBlock(model);
        }
        
        _firstTF.text = nil;
        _secondTF.text = nil;
        _thridTF.text = nil;
    }else{
        
    }
}


- (void)cutBtnBtnOnclick:(id)sender {
    if (_cuteBlock) {
        _cuteBlock();
    }
}

- (void)clearBtnOnclick:(id)sender {
    if (_clearBlock) {
        _clearBlock();
    }
}


- (void)hiddenBtnOnclick:(id)sender {
    if (_hiddenBlock) {
        _hiddenBlock();
    }
}
@end
