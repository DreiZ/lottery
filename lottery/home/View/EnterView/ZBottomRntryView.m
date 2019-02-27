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
    [titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [contView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(40);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    [contView addSubview:self.firstTF];
    [contView addSubview:self.secondTF];
    [contView addSubview:self.thridTF];
    
    [self.firstTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(36);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    [self.secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstTF.mas_right).offset(10);
        make.width.height.equalTo(self.firstTF);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    [self.thridTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondTF.mas_right).offset(10);
        make.width.height.equalTo(self.firstTF);
        make.centerY.equalTo(contView.mas_centerY);
    }];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [sureBtn addTarget:self action:@selector(sureBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 18;
    sureBtn.layer.borderColor = [UIColor redColor].CGColor;
    sureBtn.layer.borderWidth = 1;
    [sureBtn setTitle:@"开奖" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [contView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(36);
        make.left.equalTo(self.thridTF.mas_right).offset(30);
        make.centerY.equalTo(contView.mas_centerY);
    }];
}


- (UITextField *)firstTF {
    if (!_firstTF ) {
        _firstTF = [[UITextField alloc] init];
        [_firstTF setFont:[UIFont systemFontOfSize:14]];
        [_firstTF setBorderStyle:UITextBorderStyleNone];
        [_firstTF setBackgroundColor:[UIColor clearColor]];
        [_firstTF setPlaceholder:@""];
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
        [_secondTF setFont:[UIFont systemFontOfSize:14]];
        [_secondTF setBorderStyle:UITextBorderStyleNone];
        [_secondTF setBackgroundColor:[UIColor clearColor]];
        [_secondTF setPlaceholder:@""];
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
        [_thridTF setFont:[UIFont systemFontOfSize:14]];
        [_thridTF setBorderStyle:UITextBorderStyleNone];
        [_thridTF setBackgroundColor:[UIColor clearColor]];
        [_thridTF setPlaceholder:@""];
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
    
    if (_valueChange) {
        _valueChange(textField.text);
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
    
}

@end
