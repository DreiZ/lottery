//
//  ZRightCustomKeyBoardView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZRightCustomKeyBoardView.h"
#import <AVFoundation/AVFoundation.h>
#define keyboardColor(r,g,b) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f]

@interface ZRightCustomKeyBoardView ()<PGNumberKeyboardDelegate>

@end

@implementation ZRightCustomKeyBoardView

- (instancetype)initWithTextField:(UITextField *)textField {
    if (self = [super init]) {
        self.textField = textField;
        self.verify = NO;
        self.backgroundColor = [UIColor greenColor];
        CGFloat maxScreenWidth = screenWidth < screenHeight ?  screenWidth:screenHeight;

        self.frame = CGRectMake(0, screenHeight - CGFloatIn1536(922), screenHeight, 922.0f/1536 * maxScreenWidth);
        [self setupKeyBoard];
        [textField reloadInputViews];
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithTextView:(UITextView *)textView {
    if (self = [super init]) {
        self.textView = textView;
        self.verify = false;
        self.backgroundColor = [UIColor greenColor];
        CGFloat maxScreenWidth = screenWidth < screenHeight ?  screenWidth:screenHeight;

        self.frame = CGRectMake(0, screenHeight - CGFloatIn1536(922), screenHeight, 922.0f/1536 * maxScreenWidth);
        [self setupKeyBoard];
        [textView reloadInputViews];
        self.delegate = self;
    }
    return self;
}

- (void)setup {
    if (_changeBlock) {
        _changeBlock();
    }
    if ([_delegate respondsToSelector:@selector(editChanage:)]) {
        if (self.textField) {
//            NSLog(@"textField chang %@",self.textField.text);
            [_delegate editChanage:self.textField];
        }else if(self.textView) {
            [_delegate editChanage:self.textView];
        }
    }
}


-(UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor blackColor];
    }
    
    return _topView;
}

-(UIView *)keyboardView {
    if (!_keyboardView) {
        _keyboardView = [[UIView alloc] init];
        _keyboardView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }
    
    return _keyboardView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.text = @"";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _titleLabel;
}

- (UILabel *)inputLabel {
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _inputLabel.textColor = [UIColor blackColor];
        _inputLabel.backgroundColor = [UIColor whiteColor];
        _inputLabel.text = @"";
        _inputLabel.numberOfLines = 1;
        _inputLabel.textAlignment = NSTextAlignmentCenter;
        [_inputLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _inputLabel;
}

- (void)setupKeyBoard {
    
    CGFloat maxScreenWidth = screenWidth < screenHeight ?  screenWidth:screenHeight;
    self.frame = CGRectMake(0, screenHeight, screenHeight, 922.0f/1536 * maxScreenWidth);
    [self addSubview:self.topView];
    //顶部输入提示
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(130.0f/1536 * maxScreenWidth);
    }];
    
    [self.topView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(4);
        make.width.mas_equalTo(266.0f/1536 * maxScreenWidth);
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    
    [self.topView addSubview:self.inputLabel];
    [_inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-30);
        make.left.equalTo(self.titleLabel.mas_right).offset(4);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.height.mas_equalTo(80.0f/1536 * maxScreenWidth);
    }];
    
    
    //键盘
    [self addSubview:self.keyboardView];
    [_keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    
    NSInteger leftSpace = 24.0f/1536 * maxScreenWidth;
    NSInteger topSpace = 16.0f/1536 * maxScreenWidth;
    
    CGFloat numBtnHeiht = 113.0f/1536 * maxScreenWidth;
    CGFloat numBtnWidth = 174.0f/1536 * maxScreenWidth;
    
    CGFloat addBtnWidth = 570.0f/1536 * maxScreenWidth;
    CGFloat addBtnHeight = 110.0f/1536 * maxScreenWidth;
    
    CGFloat bottomBtnWidth = 274.0f/1536 * maxScreenWidth;
    CGFloat bottomBtnHeight = 110.0f/1536 * maxScreenWidth;
    
    CGFloat tempX = 28.0f/1536 * maxScreenWidth;
    CGFloat tempY = 14.0f/1536 * maxScreenWidth;
    
    NSArray *arr = @[@"7", @"8", @"9",
                     @"4", @"5", @"6",
                     @"1", @"2", @"3",
                     @"0", @".", @"/"];
    
    NSArray *arrTag = @[@7, @8, @9,
                        @4, @5, @6,
                        @1, @2, @3,
                        @0, @11, @12];
    for (int i=0; i < arr.count; i++) {
        if (i != 0) {
            if (i%3 == 0) {
                tempX = CGFloatIn1536(28);
                tempY += numBtnHeiht + topSpace;
            }else{
                tempX += numBtnWidth + leftSpace;
            }
        }
        NSString *str = [NSString stringWithFormat:@"%@",arr[i]];
        UIButton *button = [self getNumStyleBtnWithTitle:str tag:[arrTag[i] integerValue]];
        [self.keyboardView addSubview:button];
        button.frame = CGRectMake(tempX, tempY, numBtnWidth, numBtnHeiht);
        [self mapButton:[arrTag[i] integerValue] button:button];
       
    }
    
    tempX = CGFloatIn1536(28);
    tempY += numBtnHeiht + topSpace;
    
    UIButton *confirmbutton = [self getImageStyleBtnWithTitle:@"加注" tag:13 backImage:[UIImage imageNamed:@"jiazhu"]];
    [self.keyboardView addSubview:confirmbutton];
   confirmbutton.frame = CGRectMake(tempX, tempY, addBtnWidth, addBtnHeight);
   self.confirmButton = confirmbutton;

    tempX = CGFloatIn1536(28);
    tempY += addBtnHeight + topSpace;
    
    UIButton *deleteButton = [self getImageStyleBtnWithTitle:@"退格" tag:10 backImage:[UIImage imageNamed:@"tuige"]];
    [self.keyboardView addSubview:deleteButton];
    deleteButton.frame = CGRectMake(tempX, tempY, bottomBtnWidth, bottomBtnHeight);
    self.confirmButton = confirmbutton;
    
    tempX += bottomBtnWidth + leftSpace;
    UIButton *clearButton = [self getImageStyleBtnWithTitle:@"清除" tag:14 backImage:[UIImage imageNamed:@"qingchu"]];
    [self.keyboardView addSubview:clearButton];
    clearButton.frame = CGRectMake(tempX, tempY, bottomBtnWidth, bottomBtnHeight);
    self.clearButton = confirmbutton;
}

- (UIButton *)getNumStyleBtnWithTitle:(NSString *)title tag:(NSInteger)tag{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 10.0f;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor colorWithHexString:@"666666"].CGColor;
    button.layer.shadowColor = [UIColor colorWithHexString:@"999999"].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, -3);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor colorWithHexString:@"0077df"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:30];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(keyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)getImageStyleBtnWithTitle:(NSString *)title tag:(NSInteger)tag backImage:(UIImage *)image{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.layer.masksToBounds = YES;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:24];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(keyBoardAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)mapButton:(NSInteger)index button:(UIButton *)button {
    switch (index) {
        case 0:
            self.zeroButton = button;
            break;
        case 1:
            self.oneButton = button;
            break;
        case 2:
            self.twoButton = button;
            break;
        case 3:
            self.threeButton = button;
            break;
        case 4:
            self.fourButton = button;
            break;
        case 5:
            self.fiveButton = button;
            break;
        case 6:
            self.sixButton = button;
            break;
        case 7:
            self.sevenButton = button;
            break;
        case 8:
            self.eightButton = button;
            break;
        case 9:
            self.nineButton = button;
            break;
        case 10:
            self.nineButton = button;
            break;
        case 11:
            self.dotButton = button;
            break;
        case 12:
            self.minusButton = button;
            break;

        default:
            break;
    }
}

- (void)keyBoardAction:(UIButton *)sender {
    UIButton* btn = (UIButton*)sender;
    NSInteger number = btn.tag;
    if (number <= 9 && number >= 0) { // 0 - 9数字
        [self numberKeyBoard:number];
        return;
    }
    if (10 == number) { //删除　退格
        [self cancelKeyBoard];
        return;
    }
    if (11 == number) { //点
        [self periodKeyBoard];
        return;
    }
    if (12 == number) { //符号＂／＂
        [self minusKeyBoard];
        return;
    }
    
    if (13 == number) { //加注
        [self finishKeyBoard];
        return;
    }
    
    if (14 == number) { //清除
        [self cleanKeyBoard];
        return;
    }
}

#pragma mark - logic

- (void)numberKeyBoard:(NSInteger)number {
    [self playVideo:number];
    UITextPosition* beginning = self.textField.beginningOfDocument;
    UITextRange* selectedRange = self.textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    NSInteger location = [self.textField offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self.textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSString *string = [self.textField.text substringToIndex:location];
//    NSLog(@"num %ld",number);
    NSString *str = @"";
    if (self.textField) {
        str = self.textField.text;
        if (self.verify) {
            if (([string isEqualToString:@"-0"] || [string isEqualToString:@"0"])) {
                return;
            }
        }
    }else if (self.textView) {
        if (self.verify) {
            if (([string isEqualToString:@"-0"] || [string isEqualToString:@"0"])) {
                return;
            }
        }
        str = self.textView.text;
        beginning = self.textView.beginningOfDocument;
        selectedRange = self.textView.selectedTextRange;
        selectionStart = selectedRange.start;
        selectionEnd = selectedRange.end;
        location = [self.textView offsetFromPosition:beginning toPosition:selectionStart];
        length = [self.textView offsetFromPosition:selectionStart toPosition:selectionEnd];
    }
    
    NSMutableString *mutableString = [[NSMutableString alloc]initWithString:str];
    NSString *numberStr = [@(number) stringValue];
    [mutableString replaceCharactersInRange:NSMakeRange(location, length) withString:numberStr];
    UITextPosition *end = [self.textField positionFromPosition:selectionStart inDirection:UITextLayoutDirectionRight offset:numberStr.length];
    if (self.textView) {
        end = [self.textView positionFromPosition:selectionStart inDirection:UITextLayoutDirectionRight offset:numberStr.length];
    }
    
    if (self.textField) {
        self.textField.text = mutableString;
        if (location != str.length) {
            self.textField.selectedTextRange = [self.textField textRangeFromPosition:end toPosition:end];
        }
    }else if (self.textView) {
        NSString *string = [self.textView.text substringToIndex:location];
        if (([string isEqualToString:@"-0"] || [string isEqualToString:@"0"]) && self.verify) {
            return;
        }
        self.textView.text = mutableString;
        if (location != str.length) {
            self.textView.selectedTextRange = [self.textView textRangeFromPosition:end toPosition:end];
        }
    }
    [self setup];
}

- (void)cancelKeyBoard {
    [self playVideo:13];
    UITextPosition* beginning = self.textField.beginningOfDocument;
    UITextRange* selectedRange = self.textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    NSInteger location = [self.textField offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self.textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    NSString *str = @"";
    if (self.textField) {
        str = self.textField.text;
        if (location == 0 && length == 0) {
            return;
        }
    }else if (self.textView) {
        str = self.textView.text;
        beginning = self.textView.beginningOfDocument;
        selectedRange = self.textView.selectedTextRange;
        selectionStart = selectedRange.start;
        selectionEnd = selectedRange.end;
        location = [self.textView offsetFromPosition:beginning toPosition:selectionStart];
        length = [self.textView offsetFromPosition:selectionStart toPosition:selectionEnd];
        if (location == 0 && length == 0) {
            return;
        }
    }
    NSMutableString *muStr = [[NSMutableString alloc] initWithString:str];
    if (muStr.length <= 0) {
        return;
    }
    CGFloat offset = 0;
    if (length == 0) {
        offset = 1;
        [muStr deleteCharactersInRange:NSMakeRange(location - 1, 1)];
    }else {
        [muStr deleteCharactersInRange:NSMakeRange(location, length)];
    }
    UITextPosition *end = [self.textField positionFromPosition:selectionStart inDirection:UITextLayoutDirectionLeft offset:offset];
    if (self.textView) {
        end = [self.textView positionFromPosition:selectionStart inDirection:UITextLayoutDirectionLeft offset:offset];
    }
    if (self.textField) {
        self.textField.text = muStr;
        if (location != str.length) {
            self.textField.selectedTextRange = [self.textField textRangeFromPosition:end toPosition:end];
        }
    }else if (self.textView) {
        self.textView.text = muStr;
        if (location != str.length) {
            self.textView.selectedTextRange = [self.textView textRangeFromPosition:end toPosition:end];
        }
    }
    [self setup];
}

- (void)cleanKeyBoard {
    [self playVideo:12];
    if (self.textField) {
        self.textField.text = @"";
        self.inputLabel.text = @"";
    }else if (self.textView) {
        self.textView.text = @"";
        self.inputLabel.text = @"";
    }
    [self setup];
}

-(void)periodKeyBoard{
    [self playVideo:10];
    UITextPosition* beginning = self.textField.beginningOfDocument;
    UITextRange* selectedRange = self.textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    NSInteger location = [self.textField offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self.textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSString *str = [self.textField.text substringToIndex:location];
    if (!self.verify) {
        if (self.textField) {
            self.textField.text = [NSString stringWithFormat:@"%@.",self.textField.text];
        }else if (self.textView) {
            self.textView.text = [NSString stringWithFormat:@"%@.",self.textView.text];
        }
        [self setup];
        return;
    }
    if (self.textField) {
        if ([str isEqualToString:@""] || [str isEqualToString:@"-"]) {
            return;
        }
        //判断当前时候存在一个点
        if ([self.textField.text rangeOfString:@"."].location == NSNotFound) {
            //输入中没有点
            NSMutableString *mutableString = [[NSMutableString alloc]initWithString:self.textField.text];
            [mutableString replaceCharactersInRange:NSMakeRange(location, length) withString:@"."];
            self.textField.text = mutableString;
            
            UITextPosition *end = [self.textField positionFromPosition:selectionStart inDirection:UITextLayoutDirectionRight offset:1];
            if (location != self.textField.text.length) {
                self.textField.selectedTextRange = [self.textField textRangeFromPosition:end toPosition:end];
            }
            [self setup];
        }
    }else if (self.textView) {
        beginning = self.textView.beginningOfDocument;
        selectedRange = self.textView.selectedTextRange;
        selectionStart = selectedRange.start;
        selectionEnd = selectedRange.end;
        location = [self.textView offsetFromPosition:beginning toPosition:selectionStart];
        length = [self.textView offsetFromPosition:selectionStart toPosition:selectionEnd];
        str = [self.textView.text substringToIndex:location];
        if ([str isEqualToString:@""] || [str isEqualToString:@"-"]) {
            return;
        }
        //判断当前时候存在一个点
        if ([self.textView.text rangeOfString:@"."].location == NSNotFound) {
            //输入中没有点
            NSMutableString *mutableString = [[NSMutableString alloc]initWithString:self.textView.text];
            [mutableString replaceCharactersInRange:NSMakeRange(location, length) withString:@"."];
            self.textView.text = mutableString;
            
            UITextPosition *end = [self.textView positionFromPosition:selectionStart inDirection:UITextLayoutDirectionRight offset:1];
            if (location != self.textView.text.length) {
                self.textView.selectedTextRange = [self.textView textRangeFromPosition:end toPosition:end];
            }
            [self setup];
        }
    }
}

-(void)minusKeyBoard{
    [self playVideo:14];
    UITextPosition* beginning = self.textField.beginningOfDocument;
    UITextRange* selectedRange = self.textField.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    NSInteger location = [self.textField offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self.textField offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSString *str = [self.textField.text substringToIndex:location];
    if (!self.verify) {
        if (self.textField) {
            self.textField.text = [NSString stringWithFormat:@"%@%@",self.textField.text,@"/"];
        }else if (self.textView) {
            self.textView.text = [NSString stringWithFormat:@"%@%@",self.textView.text,@"/"];
        }
        [self setup];
        return;
    }
    if (self.textField) {
        if ([str isEqualToString:@""] || [str isEqualToString:@"/"]) {
            return;
        }
        //判断当前时候存在一个点
        if ([self.textField.text rangeOfString:@"/"].location == NSNotFound) {
            //输入中没有点
            NSMutableString *mutableString = [[NSMutableString alloc]initWithString:self.textField.text];
            [mutableString replaceCharactersInRange:NSMakeRange(location, length) withString:@"/"];
            self.textField.text = mutableString;
            
            UITextPosition *end = [self.textField positionFromPosition:selectionStart inDirection:UITextLayoutDirectionRight offset:1];
            if (location != self.textField.text.length) {
                self.textField.selectedTextRange = [self.textField textRangeFromPosition:end toPosition:end];
            }
            [self setup];
        }
    }else if (self.textView) {
        beginning = self.textView.beginningOfDocument;
        selectedRange = self.textView.selectedTextRange;
        selectionStart = selectedRange.start;
        selectionEnd = selectedRange.end;
        location = [self.textView offsetFromPosition:beginning toPosition:selectionStart];
        length = [self.textView offsetFromPosition:selectionStart toPosition:selectionEnd];
        str = [self.textView.text substringToIndex:location];
        if ([str isEqualToString:@""] || [str isEqualToString:@"/"]) {
            return;
        }
        //判断当前时候存在一个点
        if ([self.textView.text rangeOfString:@"/"].location == NSNotFound) {
            //输入中没有点
            NSMutableString *mutableString = [[NSMutableString alloc]initWithString:self.textView.text];
            [mutableString replaceCharactersInRange:NSMakeRange(location, length) withString:@"/"];
            self.textView.text = mutableString;
            
            UITextPosition *end = [self.textView positionFromPosition:selectionStart inDirection:UITextLayoutDirectionRight offset:1];
            if (location != self.textView.text.length) {
                self.textView.selectedTextRange = [self.textView textRangeFromPosition:end toPosition:end];
            }
            [self setup];
        }
    }
}

-(void)finishKeyBoard {
    [self playVideo:11];
    if (_addBlock) {
        _addBlock();
    }
//    if (self.textField) {
//        [self.textField resignFirstResponder];
//    }else if (self.textView) {
//        [self.textView resignFirstResponder];
//    }
}

- (void)reloadInputViews {
    if (self.textField) {
        self.textField.inputView = nil;
        [self.textField reloadInputViews];
    }else if (self.textView) {
        self.textView.inputView = nil;
        [self.textView reloadInputViews];
    }
}

- (void)setTopTitle:(NSString *)title value:(NSString *)value {
//    NSLog(@"xxx %@",value);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titleLabel.text = title;
        self.inputLabel.text = value;
    });
}

- (void)setTextField:(UITextField *)textField {
    _textField = textField;
}

void soundCompleteCallBack(SystemSoundID soundID, void *clientData)
{
//    NSLog(@"播放完成");
}

- (void)playVideo:(NSInteger)index {
    NSArray *videoArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"dian",@"jiazhu",@"qingchu",@"tuige",@"ya"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:videoArr[index] ofType:@"mp3"];
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID,NULL,NULL,soundCompleteCallBack,NULL);
    
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark - PGNumberKeyboardDelegate

- (void)editChanage:(id)sender {
    if ([sender isKindOfClass:[ZTextField class]]) {
        ZTextField *textField = sender;
        if (textField.zDelegate && [textField.zDelegate respondsToSelector:@selector(zEditChanage:)]) {
            [textField.zDelegate zEditChanage:textField];
        }
       
        
//        NSLog(@"text = %@\ttag = %ld", textField.text, textField.tag);
        return;
    }
    UITextView *textView = sender;
    NSLog(@"text = %@\ttag = %ld", textView.text, textView.tag);
    
}
@end
