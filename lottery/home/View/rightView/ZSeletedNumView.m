//
//  ZSeletedNumView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZSeletedNumView.h"

@interface ZSeletedNumView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;
@end

@implementation ZSeletedNumView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn addTarget:self action:@selector(backBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);

    }];
    
    
    [self addSubview:self.contView];
    [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(20);
        make.width.mas_equalTo(256);
        make.height.mas_equalTo(180);
    }];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = [UIColor blackColor];
    hintLabel.text = @"请选择本场0.5的特殊倍率";
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [_contView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView.mas_top).offset(50 + 14);
        make.left.right.equalTo(self.contView);
    }];
    
    [self.contView addSubview:self.leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLabel.mas_bottom).offset(26);
        make.right.equalTo(self.contView.mas_centerX).offset(-12);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(45);
    }];
    
    [self.contView addSubview:self.rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLabel.mas_bottom).offset(26);
        make.left.equalTo(self.contView.mas_centerX).offset(12);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(45);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = [UIColor whiteColor];
        
        UIView *topTitleView = [[UIView alloc] initWithFrame:CGRectZero];
        topTitleView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [_contView addSubview:topTitleView];
        [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(topTitleView.superview);
            make.height.mas_equalTo(50);
        }];

        
        UILabel *topTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        topTitleLabel.textColor = [UIColor blackColor];
        topTitleLabel.text = @"开筒";
        topTitleLabel.textAlignment = NSTextAlignmentCenter;
        [topTitleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [topTitleView addSubview:topTitleLabel];
        [topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(topTitleView);
        }];
//
//        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
//        [backBtn addTarget:self action:@selector(backBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
//        [backBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
//        [topTitleView addSubview:backBtn];
//        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.right.bottom.equalTo(topTitleView);
//            make.width.mas_equalTo(50);
//        }];
        
    }
    return _contView;
}



- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBtn setTitle:@"0.7" forState:UIControlStateNormal];
        _leftBtn.layer.masksToBounds = YES;
        _leftBtn.layer.borderColor = [UIColor colorWithHexString:@"ededed"].CGColor;
        _leftBtn.layer.borderWidth = 2;
        _leftBtn.tag = 0;
        [_leftBtn addTarget:self action:@selector(seletBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
    }
    return _leftBtn;
}


- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"0.8" forState:UIControlStateNormal];
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.layer.borderColor = [UIColor colorWithHexString:@"ededed"].CGColor;
        _rightBtn.layer.borderWidth = 2;
        _rightBtn.tag = 1;
        [_rightBtn addTarget:self action:@selector(seletBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
    }
    return _rightBtn;
}

- (void)seletBtnClick:(UIButton *)sender {
    if (_numSeletBlock) {
        _numSeletBlock(sender.tag);
    }
    [self removeFromSuperview];
}

- (void)backBtnOnclick:(id)sender {
//    [self removeFromSuperview];
}
@end
