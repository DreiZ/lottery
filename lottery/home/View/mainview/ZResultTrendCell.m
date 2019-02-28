//
//  ZResultTrendCell.m
//  lottery
//
//  Created by 承希-开发 on 2019/2/27.
//  Copyright © 2019 zzz. All rights reserved.
//

#import "ZResultTrendCell.h"
@interface ZResultTrendCell ()
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *widthArr;
@property (nonatomic,strong) NSMutableArray *labelArr;

@property (nonatomic,strong) NSMutableArray *label3UpArr;
@property (nonatomic,strong) NSMutableArray *label6UpArr;
@property (nonatomic,strong) NSMutableArray *label3DownArr;
@property (nonatomic,strong) NSMutableArray *label6DownArr;

@property (nonatomic,strong) UIView *bottomLineView;

@end


@implementation ZResultTrendCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZResultTrendCell";
    ZResultTrendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZResultTrendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setMainView];
    }
    return self;
    
}


- (void)setMainView {
    self.contentView.backgroundColor = [UIColor blackColor];
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    
    _labelArr = @[].mutableCopy;
    _label3UpArr = @[].mutableCopy;
    _label6UpArr = @[].mutableCopy;
    _label3DownArr = @[].mutableCopy;
    _label6DownArr = @[].mutableCopy;
    
    _titleArr = @[@[@""],
                  @[@"",@"",@""],
                  @[@"",@"",@"",@"",@"",@""],
                  @[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""],
                  @[@"",@""],
                  @[@"",@""],
                  @[@"",@"",@"",@"",@"",@""]];
    
    
    _widthArr = @[@(UnitWidth * 1),
                  @(UnitWidth * 3),
                  @(UnitWidth * 6),
                  @(UnitWidth * 16),
                  @(UnitWidth * 2),
                  @(UnitWidth * 2),
                  @(UnitWidth * 6)];
    
    UIView *tempView = nil;
    for (int i = 0; i < _widthArr.count; i++) {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = KContentBackColor;
        [self.contentView addSubview:contentView];
        
        if (tempView) {
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.contentView.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
                make.bottom.equalTo(self.contentView.mas_bottom);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.top.equalTo(self.contentView.mas_top);
            }];
        }else{
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(self.contentView.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
                make.bottom.equalTo(self.contentView.mas_bottom);
                make.left.equalTo(self.contentView.mas_left).offset(0.5);
                make.top.equalTo(self.contentView.mas_top);
            }];
        }
        tempView = contentView;
        
        NSArray *subArr = _titleArr[i];
        UIView *subTempView = nil;
        for (int j = 0; j < subArr.count; j++) {
            UILabel *subTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
            [contentView addSubview:subTempLabel];
            if (subTempView) {
                [subTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(contentView);
                    make.top.equalTo(contentView.mas_top).offset(0.5);
                    make.left.equalTo(subTempView.mas_right).offset(0.5);
                    make.width.equalTo(contentView.mas_width).multipliedBy(1.0f/subArr.count).offset(-0.5);
                }];
            }else{
                [subTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(contentView);
                    make.left.equalTo(contentView.mas_left);
                    make.top.equalTo(contentView.mas_top).offset(0.5);
                    make.width.equalTo(contentView.mas_width).multipliedBy(1.0f/subArr.count);
                }];
            }
            [_labelArr addObject:subTempLabel];
            subTempView = subTempLabel;
            if (i == 3) {
                UILabel *upTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
                [contentView addSubview:upTempLabel];
                [upTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.mas_top).offset(-0.5);
                    make.height.equalTo(subTempLabel.mas_height);
                    make.left.equalTo(subTempView.mas_right).offset(0.5);
                    make.width.equalTo(subTempView.mas_height);
                }];

                UILabel *downTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
                [contentView addSubview:downTempLabel];
                [downTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_bottom);
                    make.height.equalTo(subTempLabel.mas_height);
                    make.left.equalTo(subTempView.mas_right).offset(0.5);
                    make.width.equalTo(subTempView.mas_height);
                }];

                [_label3UpArr addObject:upTempLabel];
                [_label3DownArr addObject:downTempLabel];
            }

            if (i == 6) {
                UILabel *upTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
                [contentView addSubview:upTempLabel];
                [upTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.mas_top).offset(-0.5);
                    make.height.equalTo(subTempLabel.mas_height);
                    make.left.equalTo(subTempView.mas_right).offset(0.5);
                    make.width.equalTo(subTempView.mas_height);
                }];

                UILabel *downTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
                [contentView addSubview:downTempLabel];
                [downTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_bottom);
                    make.height.equalTo(subTempLabel.mas_height);
                    make.left.equalTo(subTempView.mas_right).offset(0.5);
                    make.width.equalTo(subTempView.mas_height);
                }];

                [_label6UpArr addObject:upTempLabel];
                [_label6DownArr addObject:downTempLabel];
            }
        }
    }
}



- (UILabel *)getLabel:(NSString *)title titleColor:(UIColor*)titleColor backGroundColor:(UIColor *)backColor{
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = titleColor;
    tempLabel.backgroundColor = [UIColor whiteColor];
    tempLabel.text = title;
    tempLabel.numberOfLines = 0;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:13 * [ZLotteryManager sharedManager].fontMultiple]];
    return tempLabel;
}

-(void)setModel:(ZLotteryModel *)model before:(ZLotteryModel *)before after:(ZLotteryModel *)after {
    _model = model;
    _beforeModel = before;
    _afterModel = after;
    
    for (NSArray *tempArr in _labelArr) {
        for (UILabel *label in tempArr) {
            label.text = @"";
        }
    }
    
    for (UILabel *label in _label3UpArr) {
        label.text = @"";
    }
    
    for (UILabel *label in _label3DownArr) {
        label.text = @"";
    }
    
    for (UILabel *label in _label6UpArr) {
        label.text = @"";
    }
    
    for (UILabel *label in _label6DownArr) {
        label.text = @"";
    }
    
    UILabel *idLabel = _labelArr[0][0];
    idLabel.text = model.lottert_serial_number;
    
    UILabel *num1Label = _labelArr[1][0];
    UILabel *num2Label = _labelArr[1][1];
    UILabel *num3Label = _labelArr[1][2];
    
    num1Label.text = model.lottery_num1;
    num2Label.text = model.lottery_num2;
    num3Label.text = model.lottery_num3;
    
    
    NSArray *spanArr = [[ZLotteryManager sharedManager] span:model];
    for (NSString *num in spanArr) {
        UILabel *spanLabel = _labelArr[2][[num integerValue]-1];
        spanLabel.text = num;
    }
    
    NSInteger numAnd = [[ZLotteryManager sharedManager] numAnd:model];
    UILabel *andLabel = _labelArr[3][numAnd-3];
    andLabel.text = [NSString stringWithFormat:@"%ld", numAnd];
    
    if ([[ZLotteryManager sharedManager] isBig:model]) {
        UILabel *bigLabel = _labelArr[4][0];
        bigLabel.text = @"大";
    }else{
        UILabel *smallLabel = _labelArr[4][1];
        smallLabel.text = @"小";
    }
    
    if ([[ZLotteryManager sharedManager] isDouble:model]) {
        UILabel *bigLabel = _labelArr[5][1];
        bigLabel.text = @"双";
    }else{
        UILabel *smallLabel = _labelArr[5][0];
        smallLabel.text = @"单";
    }
    
    NSInteger diffNum = [[ZLotteryManager sharedManager] diff:model];
     UILabel *diffNumLabel = _labelArr[6][diffNum];
    diffNumLabel.text = [NSString stringWithFormat:@"%ld", numAnd];
    
    if (before) {
        NSInteger numAnd = [[ZLotteryManager sharedManager] numAnd:before];
        UILabel *andLabel = _label3UpArr[numAnd-3];
        andLabel.text = [NSString stringWithFormat:@"%ld", numAnd];
        
        NSInteger diffNum = [[ZLotteryManager sharedManager] diff:before];
        UILabel *diffNumLabel = _label6UpArr[diffNum];
        diffNumLabel.text = [NSString stringWithFormat:@"%ld", numAnd];
    }
    
    if (after) {
        NSInteger numAnd = [[ZLotteryManager sharedManager] numAnd:after];
        UILabel *andLabel = _label3DownArr[numAnd-3];
        andLabel.text = [NSString stringWithFormat:@"%ld", numAnd];
        
        NSInteger diffNum = [[ZLotteryManager sharedManager] diff:after];
        UILabel *diffNumLabel = _label6DownArr[diffNum];
        diffNumLabel.text = [NSString stringWithFormat:@"%ld", numAnd];
    }
}

+ (CGFloat)getCellHeight:(id)sender {
    return cellHeight;
}
@end
