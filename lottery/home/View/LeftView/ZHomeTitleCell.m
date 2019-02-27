//
//  ZHomeTitleCell.m
//  lottery
//
//  Created by zzz on 2018/6/28.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeTitleCell.h"
@interface ZHomeTitleCell ()
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *widthArr;
@property (nonatomic,strong) NSMutableArray *labelArr;
@end

@implementation ZHomeTitleCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZHomeTitleCell";
    ZHomeTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHomeTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _titleArr = @[@"0.7", @"名称", @"投入", @"签", @"本筒",@"上筒",@"总账"];
        _widthArr = @[@(80.0f/1024),
                      @(137.0f/1024),
                      @(205.0f/1024),
                      @(80.0f/1024),
                      @(210.0f/1024),
                      @(145.0f/1024),
                      @(168.0f/1024)];
        
        [self setMainView];
    }
    return self;
}

- (void)setMainView {
    _labelArr = @[].mutableCopy;
    self.backgroundColor = [UIColor colorWithHexString:@"999999"];
    UIView  *tempView = nil;
    for (int i = 0; i < _titleArr.count; i++) {
        UILabel *tempLabel = [self getLabel:_titleArr[i]];
        [_labelArr addObject:tempLabel];
        if (tempView) {
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }else{
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }
        tempView = tempLabel;
    }
}


- (UILabel *)getLabel:(NSString *)title {
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.backgroundColor = kBack6Color;
    tempLabel.text = title;
    tempLabel.numberOfLines = 1;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [self.contentView addSubview:tempLabel];
    return tempLabel;
}

+ (CGFloat)getCellHeight:(id)sender {
    return 40;
}
@end
