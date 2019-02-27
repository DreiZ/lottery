//
//  ZHomeListAddTFCell.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeListAddTFCell.h"

@interface ZHomeListAddTFCell ()


@end

@implementation ZHomeListAddTFCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZHomeListAddTFCell";
    ZHomeListAddTFCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHomeListAddTFCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [self.contentView addSubview:self.inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
}


- (ZHomeTextFieldView *)inputView {
    if (!_inputView) {
        __weak typeof(self) weakSelf = self;
        _inputView = [[ZHomeTextFieldView alloc] init];
        _inputView.max = 30;
        [_inputView setIsCustomKeyboardType:YES];
        _inputView.formatterType = HNFormatterTypeAny;
        _inputView.valueChange = ^(NSString *value) {
            NSLog(@"zzz value %@",value);
            if (weakSelf.valueChange) {
                weakSelf.valueChange(value);
            }
        };
        
        _inputView.beginChange = ^(UITextField *textField) {
            if (weakSelf.beginChange) {
                weakSelf.beginChange(textField);
            }
        };
        
        _inputView.endChange = ^(UITextField *textField) {
            if (weakSelf.endChange) {
                weakSelf.endChange(textField);
            }
        };
    }
    return _inputView;
}

+ (CGFloat)getCellHeight:(id)sender {
    return 40;
}
@end
