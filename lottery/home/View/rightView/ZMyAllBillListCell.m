//
//  ZMyAllBillListCell.m
//  lottery
//
//  Created by zzz on 2018/6/30.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMyAllBillListCell.h"


@interface ZMyAllBillListCell ()
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,strong) UIView *bottomLineView;

@end

@implementation ZMyAllBillListCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZMyAllBillListCell";
    ZMyAllBillListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZMyAllBillListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.backgroundColor = [UIColor whiteColor];
    
    
    [self addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_centerX);
    }];
    
    [self addSubview:self.rightLabel];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_centerX).offset(0.5);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    _bottomLineView = bottomLineView;
}



- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftLabel.textColor = [UIColor redColor];
        _leftLabel.text = @"";
        _leftLabel.numberOfLines = 1;
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        [_leftLabel setFont:[UIFont systemFontOfSize:18]];
    }
    return _leftLabel;
}


- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightLabel.textColor = [UIColor blackColor];
        _rightLabel.text = @"";
        _rightLabel.numberOfLines = 1;
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        [_rightLabel setFont:[UIFont systemFontOfSize:18]];
    }
    return _rightLabel;
}

-(void)setStyle:(NSInteger)style {
    _style = style;
    switch (style) {
        case 0:
            {
                self.backgroundColor = [UIColor colorWithHexString:@"ededed"];
                self.leftLabel.backgroundColor = [UIColor whiteColor];
                self.leftLabel.textColor = [UIColor blackColor];
                self.rightLabel.backgroundColor = [UIColor whiteColor];
                self.rightLabel.textColor = [UIColor colorWithHexString:@"1699fe"];
            }
            break;
        case 1:
            {
                self.backgroundColor = [UIColor whiteColor];
                self.leftLabel.backgroundColor = [UIColor blackColor];
                self.leftLabel.textColor = [UIColor whiteColor];
                self.rightLabel.backgroundColor = [UIColor blackColor];
                self.rightLabel.textColor = [UIColor whiteColor];
            }
            break;
        case 2:
            {
                self.backgroundColor = [UIColor colorWithHexString:@"ededed"];
                self.leftLabel.backgroundColor = [UIColor whiteColor];
                self.leftLabel.textColor = [UIColor blackColor];
                self.rightLabel.backgroundColor = [UIColor whiteColor];
                self.rightLabel.textColor = [UIColor colorWithHexString:@"d00000"];
            }
            break;
        case 3:
            {
                self.backgroundColor = [UIColor whiteColor];
                self.leftLabel.backgroundColor = [UIColor colorWithHexString:@"d00000"];
                self.leftLabel.textColor = [UIColor whiteColor];
                self.rightLabel.backgroundColor = [UIColor colorWithHexString:@"d00000"];
                self.rightLabel.textColor = [UIColor whiteColor];
            }
            break;
            
        default:
            break;
    }
}

- (void)setLeftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle {
    _leftLabel.text = leftTitle;
    _rightLabel.text = rightTitle;
}

+ (CGFloat)getCellHeight:(id)sender {
    return 45;
}
@end

