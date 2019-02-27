//
//  ZRightBottomBtnView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZRightBottomBtnView.h"

@interface ZRightBottomBtnView ()
@property (nonatomic,strong) NSMutableArray *topBtnArr;
@property (nonatomic,strong) NSMutableArray *bottomBtnArr;
@end

@implementation ZRightBottomBtnView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = kBack6Color;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    _topBtnArr = @[].mutableCopy;
    _bottomBtnArr = @[].mutableCopy;
    
    
    NSArray *topTitleArr = @[@"上移一行",@"修改本筒",@"下移一行"];
  
    for (int i = 0; i < topTitleArr.count; i++) {
        UIButton *btn = [self getBtn:i title:topTitleArr[i]];
        [self addSubview:btn];
        [_bottomBtnArr addObject:btn];
    }
    
    [_bottomBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.5 leadSpacing:0 tailSpacing:0];
    
    [_bottomBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_bottomBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = kBack6Color;
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIButton *)getBtn:(NSInteger)index title:(NSString *)title{
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [tempBtn addTarget:self action:@selector(tempBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.tag = index;
    [tempBtn setTitle:title forState:UIControlStateNormal];
 
    [tempBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tempBtn.backgroundColor = [UIColor whiteColor];
    
    return tempBtn;
}

- (void)tempBtnClick:(UIButton *)sender {
        if (_bottomBlock) {
            _bottomBlock(sender.tag);
        }
}
@end


