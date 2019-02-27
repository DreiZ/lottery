//
//  ZResultTopTitleView.m
//  lottery
//
//  Created by 承希-开发 on 2019/2/26.
//  Copyright © 2019 zzz. All rights reserved.
//

#import "ZResultTopTitleView.h"


@interface ZResultTopTitleView ()
@property (nonatomic,strong) NSArray *titleOneArr;
@property (nonatomic,strong) NSArray *widthArr;
@property (nonatomic,strong) NSArray *titleTwoArr;
@end

@implementation ZResultTopTitleView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    _titleOneArr = @[@"奖号",
                     @"组选分布图",
                     @"和值",
                     @"大小",
                     @"单双",
                     @"跨度"];
    
    _titleTwoArr = @[@[@"1",@"2",@"3"],
                     @[@"1",@"2",@"3",@"4",@"5",@"6"],
                     @[@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18"],
                     @[@"大",@"小"],
                     @[@"单",@"双"],
                     @[@"0",@"1",@"2",@"3",@"4",@"5"]];
    
    
    _widthArr = @[@(UnitWidth * 3),
                  @(UnitWidth * 6),
                  @(UnitWidth * 16),
                  @(UnitWidth * 2),
                  @(UnitWidth * 2),
                  @(UnitWidth * 6)];
    
    
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"期号";
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(UnitWidth);
        make.left.equalTo(self.mas_left).offset(0.5);
        make.top.equalTo(self.mas_top).offset(0.5);
        make.bottom.equalTo(self.mas_bottom).offset(-0.5);
    }];
    
    
    UIView *tempView = nil;
    for (int i = 0; i < _titleOneArr.count; i++) {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = KContentBackColor;
        [self addSubview:contentView];
        if (tempView) {
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
                make.bottom.equalTo(self.mas_bottom).offset(-0.5);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.top.equalTo(self.mas_top).offset(0.5);
            }];
        }else{
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
                make.bottom.equalTo(self.mas_bottom).offset(-0.5);
                make.left.equalTo(titleLabel.mas_right).offset(0.5);
                make.top.equalTo(self.mas_top).offset(0.5);
            }];
        }
        
        
        UILabel *tempLabel = [self getLabel:_titleOneArr[i] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
        [contentView addSubview:tempLabel];
        
        [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView);
            make.bottom.equalTo(contentView.mas_centerY);
            make.left.equalTo(contentView.mas_left);
            make.right.equalTo(contentView.mas_right);
        }];
        
        
        tempView = tempLabel;
        
        NSArray *subArr = _titleTwoArr[i];
        UIView *subTempView = nil;
        for (int j = 0; j < subArr.count; j++) {
            UILabel *subTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
            [contentView addSubview:subTempLabel];
            if (subTempView) {
                [subTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self);
                    make.top.equalTo(self.mas_centerY).offset(0.5);
                    make.left.equalTo(subTempView.mas_right).offset(0.5);
                    make.width.equalTo(contentView.mas_width).multipliedBy(1.0f/subArr.count).offset(-0.5);
                }];
            }else{
                [subTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self);
                    make.left.equalTo(contentView.mas_left);
                    make.top.equalTo(self.mas_centerY).offset(0.5);
                    make.width.equalTo(contentView.mas_width).multipliedBy(1.0f/subArr.count);
                }];
            }

            subTempView = subTempLabel;
        }
    }
    
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectZero];
    topLineView.backgroundColor = [UIColor blackColor];
    [self addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = [UIColor blackColor];
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectZero];
    leftLineView.backgroundColor = [UIColor blackColor];
    [self addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self);
        make.width.mas_equalTo(0.5);
    }];
    
    
    UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectZero];
    rightLineView.backgroundColor = [UIColor blackColor];
    [self addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.top.equalTo(self);
        make.width.mas_equalTo(0.5);
    }];
}


- (UILabel *)getLabel:(NSString *)title titleColor:(UIColor*)titleColor backGroundColor:(UIColor *)backColor{
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = titleColor;
    tempLabel.backgroundColor = [UIColor whiteColor];
    tempLabel.text = title;
    tempLabel.numberOfLines = 0;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:13]];
//    [self addSubview:tempLabel];
    return tempLabel;
}
@end
