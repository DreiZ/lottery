//
//  ZHomeRightView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeRightView.h"
#import "ZRightTopBtnView.h"
#import "ZRightOpenView.h"
#import "ZRightBottomBtnView.h"
#import "ZRightCustomKeyBoardView.h"

@interface ZHomeRightView ()<UIAlertViewDelegate>
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) ZRightTopBtnView *topBtnView;
@property (nonatomic,strong) ZRightOpenView *openView;
@property (nonatomic,strong) ZRightBottomBtnView *bottomBtnView;
@property (nonatomic,strong) ZRightCustomKeyBoardView *keyboardView;

@end

@implementation ZHomeRightView


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
    
    CGFloat maxScreenWidth = screenWidth < screenHeight ?  screenWidth:screenHeight;
    _inputTextField = [UITextField new];
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.right.equalTo(self);
        make.left.equalTo(self.mas_left).offset(5);
        make.height.mas_equalTo(1368.0f/1536 * maxScreenWidth);
    }];
    
    [self.backView addSubview:self.topBtnView];
    [_topBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.backView);
        make.height.mas_equalTo(166.0f/1536 * maxScreenWidth);
    }];
    
    [self.backView addSubview:self.openView];
    [_openView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.topBtnView.mas_bottom);
        make.height.mas_equalTo(198.0f/1536 * maxScreenWidth);
    }];
    
    [self.backView addSubview:self.bottomBtnView];
    [_bottomBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.bottom.equalTo(self.backView.mas_bottom);
        make.height.mas_equalTo(78.0f/1536 * maxScreenWidth);
    }];
    
    [self.backView addSubview:self.keyboardView];
    [_keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.bottom.equalTo(self.bottomBtnView.mas_top);
        make.top.equalTo(self.openView.mas_bottom);
    }];
    
    
    UIButton *cleanBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [cleanBtn addTarget:self action:@selector(cleanBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    cleanBtn.layer.masksToBounds = YES;
    cleanBtn.layer.cornerRadius = 3;
    cleanBtn.layer.borderColor = [UIColor colorWithHexString:@"1699fe"].CGColor;
    cleanBtn.layer.borderWidth = 1;
    [cleanBtn setTitle:@"清空所有历史数据" forState:UIControlStateNormal];
    [cleanBtn setTitleColor:[UIColor colorWithHexString:@"1699fe"] forState:UIControlStateNormal];
    [cleanBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:cleanBtn];
    [cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(40);
        make.right.equalTo(self.mas_right).offset(-40);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.backView.mas_bottom).offset(10);
    }];
}

- (void)cleanBtnOnclick:(id)sender {
    UIAlertView *WXinstall=[[UIAlertView alloc]initWithTitle:@"提示" message:@"你确定删除所有历史数据吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];//一般在if判断中加入
    [WXinstall show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"取消"]) {
        NSLog(@"你点击了取消");
    }else if ([btnTitle isEqualToString:@"确定"] ) {
      NSLog(@"你点击了确定");
        if (self.cleanHistoryBlock) {
            self.cleanHistoryBlock();
        }
    }
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderColor = kBack6Color.CGColor;
        _backView.layer.borderWidth = 0.5;
        _backView.layer.shadowColor = [UIColor colorWithHexString:@"bfbfbf"].CGColor;
        _backView.layer.shadowOffset = CGSizeMake(0, -3);
    }
    
    return _backView;
}

-(ZRightTopBtnView *)topBtnView {
    if (!_topBtnView) {
        __weak typeof(self)weakSelf = self;
        _topBtnView = [[ZRightTopBtnView alloc] init];
        _topBtnView.topBlock = ^(NSInteger index) {
            if (!weakSelf.inningModel.isEnable) {
                if (index == 101 || index == 102 || index == 203 || index == 201) {
                    if (weakSelf.topBlock) {
                        weakSelf.topBlock(index);
                    }
                    return ;
                }else{
                    return ;
                }
            }
            if (weakSelf.topBlock) {
                weakSelf.topBlock(index);
            }
        };
    }
    
    return _topBtnView;
}

- (ZRightOpenView *)openView {
    if (!_openView) {
        __weak typeof(self)weakSelf = self;
        _openView = [[ZRightOpenView alloc] init];
        _openView.openBlock = ^{
            if (weakSelf.openBlock || weakSelf.inningModel.isEnable) {
                weakSelf.openBlock();
            }
        };
    }
    
    return _openView;
}

- (ZRightBottomBtnView *)bottomBtnView {
    if (!_bottomBtnView) {
        __weak typeof(self)weakSelf = self;
        _bottomBtnView = [[ZRightBottomBtnView alloc] init];
        _bottomBtnView.bottomBlock = ^(NSInteger index) {
            if ((weakSelf.bottomBlock && weakSelf.inningModel.isEnable) || (weakSelf.bottomBlock && index == 1)) {
                weakSelf.bottomBlock(index);
            }
        };
    }
    
    return _bottomBtnView;
}

- (ZRightCustomKeyBoardView *)keyboardView {
    if (!_keyboardView) {
        __weak typeof(self) weakSelf = self;
        _keyboardView = [[ZRightCustomKeyBoardView alloc] initWithTextField:self.inputTextField];
        _keyboardView.addBlock = ^{
            if (weakSelf.inningListModel) {
                [weakSelf.inningListModel.listInput addObject:@""];
                [weakSelf.inningListModel.listInputResult addObject:@""];
            }
            if (weakSelf.addBlock) {
                weakSelf.addBlock();
            }
        };
        
        _keyboardView.changeBlock = ^{
            if (weakSelf.inningListModel && weakSelf.inputTextField) {
                [weakSelf.keyboardView setTopTitle:weakSelf.inningListModel.listName value:weakSelf.inputTextField.text];
            }
            
        };
    }
    return _keyboardView;
}


- (void)setInputTextField:(UITextField *)inputTextField {
    _inputTextField = inputTextField;
    _keyboardView.textField = inputTextField;
}

- (void)setTopTitle:(NSString *)title value:(NSString *)value {
    [_keyboardView setTopTitle:title value:value];
}

- (void)setOpenNum:(NSString *)num {
    [_openView setOpenNum:num];
}

- (void)setSortNum:(NSString *)num {
    [_topBtnView setSenceAndInning:num];
}
@end

