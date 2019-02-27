//
//  ZHomeTextFieldView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeTextFieldView.h"
#import "IQKeyboardManager.h"

@interface ZHomeTextFieldView ()<UITextFieldDelegate,ZTextFieldDelegate>

@end

@implementation ZHomeTextFieldView


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
    [self addSubview:self.inputTF];
    [_inputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(4);
        make.right.equalTo(self.mas_right).offset(-4);
    }];
    
}

- (ZTextField *)inputTF {
    if (!_inputTF ) {
        _inputTF = [[ZTextField alloc] init];
        [_inputTF setFont:[UIFont systemFontOfSize:14]];
        [_inputTF setBorderStyle:UITextBorderStyleNone];
        [_inputTF setBackgroundColor:[UIColor clearColor]];
        [_inputTF setPlaceholder:@""];
        _inputTF.textAlignment = NSTextAlignmentCenter;
//        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputTF.delegate = self;
        _inputTF.zDelegate = self;
        [_inputTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTF;
}

- (void)zEditChanage:(UITextField*)textField {
    if (_formatterType == HNFormatterTypeDecimal) {
        if ([textField.text  doubleValue] - pow(10, _max) - 0.01  > 0.000001) {
            [self showErrorWithMsg:@"输入内容超出限制"];
            NSString *str = [textField.text substringToIndex:textField.text.length - 1];
            textField.text = str;
        }
        //        NSLog(@"zzz value %@",textField.text);
        if (_valueChange) {
            _valueChange(textField.text);
        }
        return;
        
    }
    if (textField.text.length > _max) {
        [self showErrorWithMsg:@"输入内容超出限制"];
        
        NSString *str = textField.text;
        NSInteger length = _max;
        if (str.length <= length) {
            length = str.length - 1;
        }
        str = [str substringToIndex:length];
        textField.text = str;
    }
    NSLog(@"zzz value %@",textField.text);
    if (_valueChange) {
        _valueChange(textField.text);
    }
    
}

- (void)textFieldDidChange:(UITextField*)textField {
    if (_formatterType == HNFormatterTypeDecimal) {
        if ([textField.text  doubleValue] - pow(10, _max) - 0.01  > 0.000001) {
            [self showErrorWithMsg:@"输入内容超出限制"];
            NSString *str = [textField.text substringToIndex:textField.text.length - 1];
            textField.text = str;
        }
//        NSLog(@"zzz value %@",textField.text);
        if (_valueChange) {
            _valueChange(textField.text);
        }
        return;
        
    }
    if (textField.text.length > _max) {
        [self showErrorWithMsg:@"输入内容超出限制"];
        
        NSString *str = textField.text;
        NSInteger length = _max;
        if (str.length <= length) {
            length = str.length - 1;
        }
        str = [str substringToIndex:length];
        textField.text = str;
    }
    NSLog(@"zzz value %@",textField.text);
    if (_valueChange) {
        _valueChange(textField.text);
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *regexString;
    switch (_formatterType) {
        case HNFormatterTypeAny:
        {
            return YES;
        }
        case HNFormatterTypePhoneNumber:
        {
            regexString = @"^\\d{0,11}$";
            break;
        }
        case HNFormatterTypeNumber:
        {
            regexString = @"^\\d*$";
            break;
        }
        case HNFormatterTypeDecimal:
        {
            regexString = [NSString stringWithFormat:@"^(\\d+)\\.?(\\d{0,%lu})$", (unsigned long)2];
            break;
        }
        case HNFormatterTypeAlphabet:
        {
            regexString = @"^[a-zA-Z]*$";
            break;
        }
        case HNFormatterTypeNumberAndAlphabet:
        {
            regexString = @"^[a-zA-Z0-9]*$";
            break;
        }
        case HNFormatterTypeIDCard:
        {
            regexString = @"^\\d{1,17}[0-9Xx]?$";
            break;
        }
        case HNFormatterTypeCustom:
        {
            regexString = [NSString stringWithFormat:@"^[%@]{0,%lu}$", _inputTypeStr, (long)_max];
            break;
        }
        default:
            break;
    }
    NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    
    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
}

- (void)setFormatterType:(HNFormatterType)formatterType {
    _formatterType = formatterType;
    if (_formatterType == HNFormatterTypePhoneNumber) {
        _inputTF.keyboardType = UIKeyboardTypeNumberPad;
    }else if (_formatterType == HNFormatterTypeNumber){
        _inputTF.keyboardType = UIKeyboardTypeNumberPad;
    }else if (_formatterType == HNFormatterTypeDecimal){
        _inputTF.keyboardType = UIKeyboardTypeDecimalPad;
    }else {
        _inputTF.keyboardType = UIKeyboardTypeDefault ;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"zzz begin -02");
    if (_isCustomKeyboard) {
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    }else{
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    }
    if (_beginChange) {
        _beginChange(textField);
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"zzz end -04");
    if (_endChange) {
        _endChange(textField);
    }
}

- (void)setIsCustomKeyboardType:(BOOL)isCustomKeyboard {
    _isCustomKeyboard = isCustomKeyboard;
    if (isCustomKeyboard) {
        _inputTF.inputView = [UIView new];
    }else {
        _inputTF.inputView = nil;
    }
}
@end
