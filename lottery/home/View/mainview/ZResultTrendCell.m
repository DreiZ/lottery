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

@property (nonatomic,strong) UIView *topLineView;

@end

#define kLineSpace 4

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
                make.width.mas_equalTo(unitScreenWidth * [self.widthArr[i] doubleValue]);
                make.bottom.equalTo(self.contentView.mas_bottom);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.top.equalTo(self.contentView.mas_top);
            }];
        }else{
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(unitScreenWidth * [self.widthArr[i] doubleValue]);
                make.bottom.equalTo(self.contentView.mas_bottom);
                make.left.equalTo(self.contentView.mas_left).offset(0.5);
                make.top.equalTo(self.contentView.mas_top);
            }];
        }
        tempView = contentView;
        
        
       
        NSArray *subArr = _titleArr[i];
        UIView *subTempView = nil;
        
        NSMutableArray *tempLabelArr = @[].mutableCopy;
        for (int j = 0; j < subArr.count; j++) {
            UIView *tempLabelContentView = [[UIView alloc] init];
            tempLabelContentView.backgroundColor = [UIColor whiteColor];
            [contentView addSubview:tempLabelContentView];
            
            UILabel *subTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
            [contentView addSubview:subTempLabel];
            
            
            if (subTempView) {
                [tempLabelContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(contentView);
                    make.top.equalTo(contentView.mas_top).offset(0.5);
                    make.left.equalTo(subTempView.mas_right).offset(0.5);
                    make.width.equalTo(contentView.mas_width).multipliedBy(1.0f/subArr.count).offset(-0.5);
                }];
            }else{
                [tempLabelContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(contentView);
                    make.left.equalTo(contentView.mas_left);
                    make.top.equalTo(contentView.mas_top).offset(0.5);
                    make.width.equalTo(contentView.mas_width).multipliedBy(1.0f/subArr.count);
                }];
            }
            
            if (i == 2) {
                [subTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(tempLabelContentView.mas_centerY);
                    make.centerX.equalTo(tempLabelContentView.mas_centerX);
                    make.width.height.mas_equalTo(CGFloatIn750(20));
                }];
            }else{
                [subTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(tempLabelContentView.mas_centerY);
                    make.centerX.equalTo(tempLabelContentView.mas_centerX);
                    make.width.height.mas_equalTo(CGFloatIn750(20));
                }];
            }
            
            
            
            [tempLabelArr addObject:subTempLabel];
            subTempView = tempLabelContentView;
            
    
            if (i == 3) {
                UIView *upTempLabelView = [[UIView alloc] init];
                upTempLabelView.backgroundColor = [UIColor whiteColor];
                [contentView addSubview:upTempLabelView];
                
                UIView *downTempLabelView = [[UIView alloc] init];
                downTempLabelView.backgroundColor = [UIColor whiteColor];
                [contentView addSubview:downTempLabelView];
                
                
                UILabel *upTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
                [contentView addSubview:upTempLabel];
                [upTempLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.mas_top).offset(-0.5);
                    make.height.equalTo(tempLabelContentView.mas_height);
                    make.left.equalTo(tempLabelContentView.mas_left).offset(0.5);
                    make.width.equalTo(tempLabelContentView.mas_height);
                }];
                
                [upTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(upTempLabelView.mas_centerY);
                    make.centerX.equalTo(upTempLabelView.mas_centerX);
                }];
                
                
                
                

                UILabel *downTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
                [contentView addSubview:downTempLabel];
                [downTempLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_bottom);
                    make.height.equalTo(upTempLabelView.mas_height);
                    make.left.equalTo(upTempLabelView.mas_left).offset(0.5);
                    make.width.equalTo(upTempLabelView.mas_height);
                }];

                
                [downTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(downTempLabelView.mas_centerY);
                    make.centerX.equalTo(downTempLabelView.mas_centerX);
                }];
                
                
                [_label3UpArr addObject:upTempLabel];
                [_label3DownArr addObject:downTempLabel];
            }

            if (i == 6) {
                UIView *upTempLabelView = [[UIView alloc] init];
                upTempLabelView.backgroundColor = [UIColor whiteColor];
                [contentView addSubview:upTempLabelView];
                
                UIView *downTempLabelView = [[UIView alloc] init];
                downTempLabelView.backgroundColor = [UIColor whiteColor];
                [contentView addSubview:downTempLabelView];
                
                
                UILabel *upTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
                [contentView addSubview:upTempLabel];
                [upTempLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.mas_top).offset(-0.5);
                    make.height.equalTo(tempLabelContentView.mas_height);
                    make.left.equalTo(tempLabelContentView.mas_left).offset(0.5);
                    make.width.equalTo(tempLabelContentView.mas_height);
                }];
                
                [upTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(upTempLabelView.mas_centerY);
                    make.centerX.equalTo(upTempLabelView.mas_centerX);
                }];
                

                UILabel *downTempLabel = [self getLabel:subArr[j] titleColor:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
                [contentView addSubview:downTempLabel];
                [downTempLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.mas_bottom);
                    make.height.equalTo(tempLabelContentView.mas_height);
                    make.left.equalTo(tempLabelContentView.mas_left).offset(0.5);
                    make.width.equalTo(tempLabelContentView.mas_height);
                }];
                
                [downTempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(downTempLabelView.mas_centerY);
                    make.centerX.equalTo(downTempLabelView.mas_centerX);
                }];

                [_label6UpArr addObject:upTempLabel];
                [_label6DownArr addObject:downTempLabel];
            }
            
            if (i == 0) {
                [subTempLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(13) * [ZLotteryManager sharedManager].fontMultiple]];
            }else{
                [subTempLabel setFont:[UIFont boldSystemFontOfSize:CGFloatIn750(16) * [ZLotteryManager sharedManager].fontMultiple]];
                
            }
            
            if (i == 1) {
                tempLabelContentView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
                subTempLabel.backgroundColor = [UIColor colorWithHexString:@"efefef"];
            }else if (i == 3){
                tempLabelContentView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
                subTempLabel.backgroundColor = [UIColor colorWithHexString:@"efefef"];
            }else{
                tempLabelContentView.backgroundColor = [UIColor whiteColor];
            }
        }
        
        [_labelArr addObject:tempLabelArr];
    }
    
    
    _topLineView = [[UIView alloc] initWithFrame:CGRectZero];
    _topLineView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectZero];
    rightLineView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
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
    [tempLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(16) * [ZLotteryManager sharedManager].fontMultiple]];
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
        spanLabel.backgroundColor = [UIColor whiteColor];
        spanLabel.layer.masksToBounds = NO;
    }
    
    NSInteger numAnd = [[ZLotteryManager sharedManager] numAnd:model];
    UILabel *andLabel = _labelArr[3][numAnd-3];
    andLabel.text = [NSString stringWithFormat:@"%ld", numAnd];
    
    if ([[ZLotteryManager sharedManager] isBig:model]) {
        UILabel *bigLabel = _labelArr[4][0];
        bigLabel.text = @"大";
        bigLabel.textColor = kPurpleColor;
    }else{
        UILabel *smallLabel = _labelArr[4][1];
        smallLabel.text = @"小";
        smallLabel.textColor = kPurpleColor;
    }
    
    if ([[ZLotteryManager sharedManager] isDouble:model]) {
        UILabel *bigLabel = _labelArr[5][1];
        bigLabel.text = @"双";
        bigLabel.textColor = kBlueColor;
    }else{
        UILabel *smallLabel = _labelArr[5][0];
        smallLabel.text = @"单";
        smallLabel.textColor = kBlueColor;
    }
    
    NSInteger diffNum = [[ZLotteryManager sharedManager] diff:model];
     UILabel *diffNumLabel = _labelArr[6][diffNum];
    diffNumLabel.text = [NSString stringWithFormat:@"%ld", diffNum];
    
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
    
    //颜色样式
    if ([model.lottert_serial_number integerValue] == 1) {
        _topLineView.hidden = NO;
    }else{
        _topLineView.hidden = YES;
    }
    

    
    andLabel.textColor = [UIColor blackColor];
    diffNumLabel.textColor = [UIColor blackColor];
    ///1:3数相等 2:2数相等 3:顺子 4:普通号
    if ([[ZLotteryManager sharedManager] type:model] == 1) {
        num1Label.textColor = kBlueColor;
        num2Label.textColor = kBlueColor;
        num3Label.textColor = kBlueColor;
        
        
        NSArray *spanArr = [[ZLotteryManager sharedManager] span:model];
        for (NSString *num in spanArr) {
            UILabel *spanLabel = _labelArr[2][[num integerValue]-1];
            spanLabel.textColor = kBlueColor;
        }
        
        diffNumLabel.textColor = kBlueColor;
    }else if ([[ZLotteryManager sharedManager] type:model] == 2){
        num1Label.textColor = [UIColor redColor];
        num2Label.textColor = [UIColor redColor];
        num3Label.textColor = [UIColor redColor];
        
        
        
        NSString *index = nil;
        if ([model.lottery_num1 isEqualToString:model.lottery_num2] ) {
            index = model.lottery_num1;
        }else if ([model.lottery_num3 isEqualToString:model.lottery_num2]){
            index = model.lottery_num2;
        }
        
        NSArray *spanArr = [[ZLotteryManager sharedManager] span:model];
        
        for (NSString *num in spanArr) {
            UILabel *spanLabel = _labelArr[2][[num integerValue]-1];
            if ([num isEqualToString:index]) {
                spanLabel.textColor = [UIColor redColor];
            }else{
                spanLabel.textColor = [UIColor blackColor];
            }
        }
        
        andLabel.textColor = [UIColor redColor];
        diffNumLabel.textColor = [UIColor redColor];
    }else if ([[ZLotteryManager sharedManager] type:model] == 3){
        num1Label.textColor = [UIColor blackColor];
        num2Label.textColor = [UIColor blackColor];
        num3Label.textColor = [UIColor blackColor];
        
        NSArray *spanArr = [[ZLotteryManager sharedManager] span:model];
        for (NSString *num in spanArr) {
            UILabel *spanLabel = _labelArr[2][[num integerValue]-1];
            spanLabel.backgroundColor = kBlueCColor;
            spanLabel.textColor = [UIColor whiteColor];
            spanLabel.layer.masksToBounds = YES;
            spanLabel.layer.cornerRadius = CGFloatIn750(10);
        }
    }else if ([[ZLotteryManager sharedManager] type:model] == 4){
        num1Label.textColor = [UIColor blackColor];
        num2Label.textColor = [UIColor blackColor];
        num3Label.textColor = [UIColor blackColor];
        
        NSArray *spanArr = [[ZLotteryManager sharedManager] span:model];
        for (NSString *num in spanArr) {
            UILabel *spanLabel = _labelArr[2][[num integerValue]-1];
            spanLabel.textColor = [UIColor blackColor];
        }
    }
    
//    [self.contentView.layer removeAllSublayers];
    
    
    NSInteger now_numAnd = [[ZLotteryManager sharedManager] numAnd:model];
    CGFloat now_and_x = ([ZLotteryManager sharedManager].contWidthMultiple * unitScreenWidth * UnitWidth * 10) + (now_numAnd - 2.5) * unitScreenWidth * UnitWidth;
    
    NSInteger now_diffNum = [[ZLotteryManager sharedManager] diff:model];
    CGFloat now_diff_x = ([ZLotteryManager sharedManager].contWidthMultiple * unitScreenWidth * UnitWidth * 30) + (now_diffNum + 0.5) * unitScreenWidth * UnitWidth + CGFloatIn750(6);
    
    if (before) {
        
        NSInteger before_numAnd = [[ZLotteryManager sharedManager] numAnd:before];
        CGFloat before_and_x = ([ZLotteryManager sharedManager].contWidthMultiple * unitScreenWidth * UnitWidth * 10) + (before_numAnd - 2.5) * unitScreenWidth * UnitWidth;
//
//        if (before_and_x > now_and_x) {
//            before_and_x -= CGFloatIn750(6);
//            now_and_x += CGFloatIn750(6);
//        }else if (before_and_x < now_and_x){
//            before_and_x += CGFloatIn750(6);
//            now_and_x -= CGFloatIn750(6);
//        }
        
        NSInteger before_diffNum = [[ZLotteryManager sharedManager] diff:before];
        CGFloat before_diff_x = ([ZLotteryManager sharedManager].contWidthMultiple * unitScreenWidth * UnitWidth * 30) + (before_diffNum + 0.5) * unitScreenWidth * UnitWidth+CGFloatIn750(6);
        
        
        CAShapeLayer *solidShapeLayer_3 = [CAShapeLayer layer];
        CGMutablePathRef solidShapePath_3 =  CGPathCreateMutable();
        [solidShapeLayer_3 setFillColor:[[UIColor clearColor] CGColor]];
        if ([[ZLotteryManager sharedManager] type:model] == 2) {
            [solidShapeLayer_3 setStrokeColor:[[UIColor redColor] CGColor]];
        }else{
            [solidShapeLayer_3 setStrokeColor:[[UIColor blackColor] CGColor]];
        }
        
        solidShapeLayer_3.lineWidth = 1.0f ;
        CGPathMoveToPoint(solidShapePath_3, NULL, before_and_x, -(cellHeight/2));
        CGPathAddLineToPoint(solidShapePath_3, NULL, now_and_x, (cellHeight/2));
        [solidShapeLayer_3 setPath:solidShapePath_3];
        CGPathRelease(solidShapePath_3);
        [self.contentView.layer addSublayer:solidShapeLayer_3];
//        [self.contentView.layer insertSublayer:solidShapeLayer_3 atIndex:4];
        
        CAShapeLayer *solidShapeLayer_6 = [CAShapeLayer layer];
        CGMutablePathRef solidShapePath_6 =  CGPathCreateMutable();
        [solidShapeLayer_6 setFillColor:[[UIColor clearColor] CGColor]];
        [solidShapeLayer_6 setStrokeColor:[[UIColor orangeColor] CGColor]];
        solidShapeLayer_6.lineWidth = 1.0f ;
        CGPathMoveToPoint(solidShapePath_6, NULL, before_diff_x, -(cellHeight/2));
        CGPathAddLineToPoint(solidShapePath_6, NULL, now_diff_x, (cellHeight/2));
        [solidShapeLayer_6 setPath:solidShapePath_6];
        CGPathRelease(solidShapePath_6);
        [self.contentView.layer addSublayer:solidShapeLayer_6];
//        [self.contentView.layer insertSublayer:solidShapeLayer_6 atIndex:4];
    }
    
    now_and_x = ([ZLotteryManager sharedManager].contWidthMultiple * unitScreenWidth * UnitWidth * 10) + (now_numAnd - 2.5) * unitScreenWidth * UnitWidth;
    
    now_diff_x = ([ZLotteryManager sharedManager].contWidthMultiple * unitScreenWidth * UnitWidth * 30) + (now_diffNum + 0.5) * unitScreenWidth * UnitWidth + CGFloatIn750(6);
    
    if (after) {
        NSInteger after_numAnd = [[ZLotteryManager sharedManager] numAnd:after];
        CGFloat after_and_x = ([ZLotteryManager sharedManager].contWidthMultiple * unitScreenWidth * UnitWidth * 10) + (after_numAnd - 2.5) * unitScreenWidth * UnitWidth;
        
//        if (after_and_x > now_and_x) {
//            after_and_x -= CGFloatIn750(6);
//            now_and_x += CGFloatIn750(6);
//        }else if (after_and_x < now_and_x){
//            after_and_x += CGFloatIn750(6);
//            now_and_x -= CGFloatIn750(6);
//        }

        NSInteger after_diffNum = [[ZLotteryManager sharedManager] diff:after];
        CGFloat after_diff_x = ([ZLotteryManager sharedManager].contWidthMultiple * unitScreenWidth * UnitWidth * 30) + (after_diffNum + 0.5) * unitScreenWidth * UnitWidth+CGFloatIn750(6);

        CAShapeLayer *solidShapeLayer_a3 = [CAShapeLayer layer];
        CGMutablePathRef solidShapePath_a3 =  CGPathCreateMutable();
        [solidShapeLayer_a3 setFillColor:[[UIColor clearColor] CGColor]];
        if ([[ZLotteryManager sharedManager] type:after] == 2) {
            [solidShapeLayer_a3 setStrokeColor:[[UIColor redColor] CGColor]];
        }else{
            [solidShapeLayer_a3 setStrokeColor:[[UIColor blackColor] CGColor]];
        }
        
        solidShapeLayer_a3.lineWidth = 1.0f ;

        CGPathMoveToPoint(solidShapePath_a3, NULL, now_and_x, (cellHeight/2) );
        CGPathAddLineToPoint(solidShapePath_a3, NULL, after_and_x,cellHeight + (cellHeight/2));


        [solidShapeLayer_a3 setPath:solidShapePath_a3];
        CGPathRelease(solidShapePath_a3);
        [self.contentView.layer addSublayer:solidShapeLayer_a3];
//        [self.contentView.layer insertSublayer:solidShapeLayer_a3 atIndex:5];


        CAShapeLayer *solidShapeLayer_a6 = [CAShapeLayer layer];
        CGMutablePathRef solidShapePath_a6 =  CGPathCreateMutable();
        [solidShapeLayer_a6 setFillColor:[[UIColor clearColor] CGColor]];
        [solidShapeLayer_a6 setStrokeColor:[[UIColor orangeColor] CGColor]];
        solidShapeLayer_a6.lineWidth = 1.0f ;

        CGPathMoveToPoint(solidShapePath_a6, NULL, now_diff_x, (cellHeight/2));
        CGPathAddLineToPoint(solidShapePath_a6, NULL, after_diff_x, cellHeight + (cellHeight/2));

        [solidShapeLayer_a6 setPath:solidShapePath_a6];
        CGPathRelease(solidShapePath_a6);
        [self.contentView.layer addSublayer:solidShapeLayer_a6];
//        [self.contentView.layer insertSublayer:solidShapeLayer_a6 atIndex:5];
    }
    
    
}

+ (CGFloat)getCellHeight:(id)sender {
    return cellHeight;
}
@end
