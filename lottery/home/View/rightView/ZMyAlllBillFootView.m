//
//  ZMyAlllBillFootView.m
//  lottery
//
//  Created by zzz on 2018/6/30.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMyAlllBillFootView.h"

@interface ZMyAlllBillFootView ()
@property (nonatomic,strong) YYLabel *amountLabel;

@end

@implementation ZMyAlllBillFootView


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
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self addSubview:self.amountLabel];
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


- (YYLabel *)amountLabel {
    if (!_amountLabel) {
        _amountLabel = [[YYLabel alloc] init];
        _amountLabel.numberOfLines = 1;
        NSString *openStr =  @"总账";
        NSMutableAttributedString *introText = [[NSMutableAttributedString alloc] initWithString:openStr];
        introText.font = [UIFont systemFontOfSize:24];
        introText.color = [UIColor blackColor];
        
        _amountLabel.attributedText = introText;
        _amountLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _amountLabel;
}


-(void)setAdd:(NSString *)add sub:(NSString *)sub amount:(NSString *)amount {
    amount = [[ZPublicManager shareInstance] changeFloat:amount];
    NSString *result =  [NSString stringWithFormat:@"总账+%@%@%@=%@",add,[sub doubleValue] == 0 ? @"-":@"",sub,amount];

    NSMutableAttributedString *introText = [[NSMutableAttributedString alloc] initWithString:result];
    introText.font = [UIFont systemFontOfSize:24];
    
    NSRange range1 = NSMakeRange(@"总账".length, add.length+1);
    NSRange range2 = NSMakeRange(@"总账".length + add.length+1, sub.length+1);
    NSRange range3 = NSMakeRange(result.length-amount.length, amount.length);
    //文字颜色
    [introText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"1699fe"] range:range1];
    [introText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"d00000"] range:range2];
    if ([add doubleValue] > [sub doubleValue]) {
        [introText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"1699fe"] range:range3];
    }else{
        [introText addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"d00000"] range:range3];
    }
    _amountLabel.attributedText = introText;
    _amountLabel.textAlignment = NSTextAlignmentCenter;
}
@end
