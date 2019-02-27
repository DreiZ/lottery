//
//  ZHomeTopTitleView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeTopTitleView.h"
@interface ZHomeTopTitleView ()
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *widthArr;
@property (nonatomic,strong) NSArray *sTitleColorArr;

@property (nonatomic,strong) NSMutableArray *titleLabelArr;
@property (nonatomic,strong) NSMutableArray *sTitleLabelArr;
@end
@implementation ZHomeTopTitleView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithHexString:@"999999"];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    _titleArr = @[@"0", @"名称", @"投入", @"签", @"本筒",@"上筒",@"总账"];
    _subTitleArr = @[@"0", @"#", @"", @"", @"0",@"0",@"0"];
    
    _sTitleColorArr = @[@[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"222222"],[UIColor whiteColor]],
                        @[[UIColor colorWithHexString:@"cccccc"],[UIColor blackColor]],
                        @[[UIColor colorWithHexString:@"d00000"],[UIColor whiteColor]]];
    
    _widthArr = @[@(80.0f/1024),
                  @(137.0f/1024),
                  @(205.0f/1024),
                  @(80.0f/1024),
                  @(210.0f/1024),
                  @(145.0f/1024),
                  @(168.0f/1024)];
    

    _titleLabelArr = @[].mutableCopy;
    _sTitleLabelArr = @[].mutableCopy;
    
    UIView *tempView = nil;
    for (int i = 0; i < _titleArr.count; i++) {
        UILabel *tempLabel = [self getLabel:_titleArr[i] titleColor:[UIColor whiteColor] backGroundColor:kBack6Color];
        [_titleLabelArr addObject:tempLabel];
        if (tempView) {
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.bottom.equalTo(self.mas_centerY);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }else{
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self);
                make.bottom.equalTo(self.mas_centerY);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }
        tempView = tempLabel;
    }
    
    tempView = nil;
    for (int i = 0; i < _subTitleArr.count; i++) {
        UILabel *tempLabel = [self getLabel:_subTitleArr[i] titleColor:_sTitleColorArr[i][1]  backGroundColor:_sTitleColorArr[i][0]];
        [_sTitleLabelArr addObject:tempLabel];
        if (tempView) {
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.top.equalTo(self.mas_centerY).offset(0.5);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }else{
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.top.equalTo(self.mas_centerY).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }
        tempView = tempLabel;
    }
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectZero];
    topLineView.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}


- (UILabel *)getLabel:(NSString *)title titleColor:(UIColor*)titleColor backGroundColor:(UIColor *)backColor{
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = titleColor;
    tempLabel.backgroundColor = backColor;
    tempLabel.text = title;
    tempLabel.numberOfLines = 0;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:18]];
    [self addSubview:tempLabel];
    return tempLabel;
}

-(void)setMultiplying:(NSString *)multiplying{
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *label = self.titleLabelArr[0];
        label.text = multiplying;
    });
    
}

- (void)setSubTitleArr:(NSArray *)subTitleArr {
    _subTitleArr = subTitleArr;
    for (int i = 0; i < _sTitleLabelArr.count; i++) {
        UILabel *tempLabel = _sTitleLabelArr[i];
        if (i > 3 && [subTitleArr[i] length] == 0) {
            tempLabel.text = @"0.00";
        }else{
            tempLabel.text = subTitleArr[i];
            if (i == 2) {
                tempLabel.text = [[ZPublicManager shareInstance] changeFloat:tempLabel.text];
            }
            if (i > 3) {
                if ([tempLabel.text doubleValue] > -0.00001) {
                    tempLabel.text = [NSString stringWithFormat:@"%@",[[ZPublicManager shareInstance] changeFloat:tempLabel.text]];
                }else{
                    tempLabel.text = [NSString stringWithFormat:@"%@",[[ZPublicManager shareInstance] changeFloat:tempLabel.text]];
                }
            }
        }
        if (i == 4) {
            tempLabel.adjustsFontSizeToFitWidth = YES;
        }
    }
    
}
@end
