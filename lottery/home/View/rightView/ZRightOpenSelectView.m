//
//  ZRightOpenSelectView.m
//  lottery
//
//  Created by zzz on 2018/7/1.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZRightOpenSelectView.h"

@interface ZRightOpenSelectView ()
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) NSMutableArray *numBtnArr;
@end

@implementation ZRightOpenSelectView


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
    
    _numBtnArr = @[].mutableCopy;
    
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
        make.width.mas_equalTo(356);
        make.height.mas_equalTo(180);
    }];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = [UIColor blackColor];
    hintLabel.text = @"请选择开筒数字";
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_contView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView.mas_top).offset(50 + 14);
        make.left.right.equalTo(self.contView);
    }];
    
    
    NSArray *titleArr = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    UIButton *numBtn = nil;
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [self getBtnWith:i title:titleArr[i]];
        [_contView addSubview:btn];
        [_numBtnArr addObject:btn];
        numBtn = btn;
    }
    
    [_numBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:8 leadSpacing:20 tailSpacing:20];
    
    [_numBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contView.mas_bottom).offset(-30);
    }];
    
//    [_numBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo((356 - 30 - (titleArr.count - 1)*8)/titleArr.count);
//    }];
    [_numBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(numBtn);
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
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [backBtn addTarget:self action:@selector(backBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        [topTitleView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(topTitleView);
            make.width.mas_equalTo(50);
        }];
        
    }
    return _contView;
}



- (UIButton *)getBtnWith:(NSInteger)tag title:(NSString *)title{
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tempBtn setTitle:title forState:UIControlStateNormal];
    tempBtn.layer.masksToBounds = YES;
    tempBtn.layer.borderColor = [UIColor colorWithHexString:@"ededed"].CGColor;
    tempBtn.layer.borderWidth = 2;
    tempBtn.tag = tag;
    [tempBtn addTarget:self action:@selector(seletBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:24]];
    return tempBtn;
}


- (void)seletBtnClick:(UIButton *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
    if (_numSeletBlock) {
        _numSeletBlock(sender.tag);
    }
    
}

- (void)backBtnOnclick:(id)sender {
    [self removeFromSuperview];
}
@end

