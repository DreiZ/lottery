//
//  ZHomeListCell.m
//  lottery
//
//  Created by zzz on 2018/6/28.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeListCell.h"
#import "ZHomeTextFieldView.h"
#import "ZHomeListAddTFView.h"
#import "ZHomeListResultTFView.h"

@interface ZHomeListCell ()
@property (nonatomic,strong) UIView *backView;
//名称view
@property (nonatomic,strong) ZHomeTextFieldView *nameInputTF;
//加注view
@property (nonatomic,strong) ZHomeListAddTFView *addTFView;
//加注view
@property (nonatomic,strong) ZHomeListResultTFView *resultTFView;

@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *widthArr;
@property (nonatomic,strong) NSMutableArray *labelArr;
@property (nonatomic,strong) UIColor *lineColor;

@end

@implementation ZHomeListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZHomeListCell";
    ZHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHomeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _lineColor = kBack6Color;

        _titleArr = @[@"0", @"", @"", @"", @"",@"",@""];
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
    
    [self addSubview:self.backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView  *tempView = nil;
    for (int i = 0; i < _titleArr.count; i++) {
        UIView *aView = nil;
        if (i == 1) {
            aView = self.nameInputTF;
        }else if(i == 2){
            aView = self.addTFView;
        }else if(i == 3){
            aView = self.resultTFView;
        }else{
            aView = [self getLabel:_titleArr[i]];
        }
        
        [_labelArr addObject:aView];
        if (tempView) {
            [aView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(tempView.mas_right).offset(0.5);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }else{
            [aView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(self);
                make.width.equalTo(self.mas_width).multipliedBy([self.widthArr[i] doubleValue]);
            }];
        }
        tempView = aView;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTF:) name:@"tgchange" object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)refreshTF:(NSNotification *)notification
{
    [self setIsFirst:NO];
}

- (UILabel *)getLabel:(NSString *)title {
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = [UIColor colorWithHexString:@"222222"];
    tempLabel.backgroundColor = [UIColor whiteColor];
    tempLabel.text = title;
    tempLabel.numberOfLines = 1;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [self.backView addSubview:tempLabel];
    return tempLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.layer.masksToBounds = YES;
        _backView.backgroundColor = _lineColor;
        _backView.layer.masksToBounds = YES;
        _backView.layer.borderWidth = 0.5;
        _backView.layer.borderColor = _lineColor.CGColor;
    }
    return _backView;
}

- (ZHomeTextFieldView *)nameInputTF {
    if (!_nameInputTF) {
        __weak typeof(self) weakSelf = self;
        _nameInputTF = [[ZHomeTextFieldView alloc] init];
        _nameInputTF.max = 10;
        _nameInputTF.isCustomKeyboard = NO;
        [_nameInputTF setIsCustomKeyboardType:NO];
        _nameInputTF.formatterType = HNFormatterTypeAny;
        _nameInputTF.valueChange = ^(NSString *value) {
            NSLog(@"weakSelf.listModel %@ list name %@",weakSelf.listModel,value);
            weakSelf.listModel.listName = value;
            if (weakSelf.nameValueChange) {
                weakSelf.nameValueChange(value);
            }
        };
        _nameInputTF.beginChange = ^(UITextField *textField) {
            NSNotification *notification = [NSNotification notificationWithName:@"tgchange" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [weakSelf setIsFirst:YES];
            if (weakSelf.nameBeginChange) {
                weakSelf.nameBeginChange(textField.text);
            }
        };
        
        _nameInputTF.endChange = ^(UITextField *textField) {
            NSNotification *notification = [NSNotification notificationWithName:@"tgchange" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [weakSelf setIsFirst:NO];
        };
        
        [_backView addSubview:_nameInputTF];
    }
    return _nameInputTF;
}

- (ZHomeListAddTFView *)addTFView {
    if (!_addTFView) {
        __weak typeof(self) weakSelf = self;
        _addTFView = [[ZHomeListAddTFView alloc] init];
        _addTFView.isCustomKeyboard = YES;
        _addTFView.valueChange = ^(NSString *value) {
//            NSLog(@"zzz value %@",value);
            if (weakSelf.valueChange) {
                weakSelf.valueChange(value);
            }
        };
        
        _addTFView.beginChange = ^(UITextField *textField) {
            NSNotification *notification = [NSNotification notificationWithName:@"tgchange" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [weakSelf setIsFirst:YES];
            if (weakSelf.beginChange) {
                weakSelf.beginChange(textField);
            }
        };
        
        _addTFView.endChange = ^(UITextField *textField) {
            NSNotification *notification = [NSNotification notificationWithName:@"tgchange" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [weakSelf setIsFirst:NO];
            if (weakSelf.endChange) {
                weakSelf.endChange(textField);
            }
        };
        [_backView addSubview:_addTFView];
    }
    
    return _addTFView;
}

- (ZHomeListResultTFView *)resultTFView {
    if (!_resultTFView) {
        _resultTFView = [[ZHomeListResultTFView alloc] init];
        [_backView addSubview:_resultTFView];
    }
    return _resultTFView;
}

- (void)setListModel:(ZInningListModel *)listModel {
    _listModel = listModel;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setIsFirst:NO];
        
        for (int i = 0; i < self.labelArr.count; i++) {
            if (i == 1) {
                self.nameInputTF.inputTF.text = [NSString stringWithFormat:@"%@",[self debarNullStr:listModel.listName]];
            }else if (i == 2){
                self.addTFView.listModel = listModel;
            }else if (i == 3){
                self.resultTFView.listModel = listModel;
            }else{
                if ([self.labelArr[i] isKindOfClass:[UILabel class]]) {
                    UILabel *tempLabel = self.labelArr[i];
                    switch (i) {
                        case 0:
                            tempLabel.text = [NSString stringWithFormat:@"%@",[self debarNullStr:listModel.listSort]];
                            break;
                        case 3:
                            tempLabel.text = [NSString stringWithFormat:@"%@",[self debarNullStr:listModel.listOpenResult]];
                            break;
                        case 4:
                        {
                            if ([self debarNullStr:listModel.listThisResult].length > 0) {
                                if ([[self debarNullStr:listModel.listThisResult] doubleValue] > -0.00001) {
                                    tempLabel.text = [NSString stringWithFormat:@"+%@",[self debarNullStr:listModel.listThisResult]];
                                    [tempLabel setTextColor:[UIColor colorWithHexString:@"1699fe"]];
                                }else{
                                    tempLabel.text = [NSString stringWithFormat:@"%@",[self debarNullStr:listModel.listThisResult]];
                                    [tempLabel setTextColor:[UIColor colorWithHexString:@"d00000"]];
                                }
                            }else{
                                tempLabel.text = @"";
                            }
                            tempLabel.text = [[ZPublicManager shareInstance] changeFloat:tempLabel.text];
                        }
                            
                            break;
                        case 5:
                        {
                            if ([self debarNullStr:listModel.listLastResult].length > 0) {
                                if ([[self debarNullStr:listModel.listLastResult] doubleValue] > -0.00001) {
                                    tempLabel.text = [NSString stringWithFormat:@"+%@",[self debarNullStr:listModel.listLastResult]];
                                }else{
                                    tempLabel.text = [NSString stringWithFormat:@"%@",[self debarNullStr:listModel.listLastResult]];
                                }
                                [tempLabel setTextColor:[UIColor colorWithHexString:@"666666"]];
                            }else{
                                tempLabel.text = @"";
                            }
                            tempLabel.text = [[ZPublicManager shareInstance] changeFloat:tempLabel.text];
                        }
                            break;
                        case 6:
                        {
                            if ([self debarNullStr:listModel.listAllResult].length > 0) {
                                if ([[self debarNullStr:listModel.listAllResult] doubleValue] > -0.00001) {
                                    tempLabel.text = [NSString stringWithFormat:@"+%@",[self debarNullStr:listModel.listAllResult]];
                                    [tempLabel setTextColor:[UIColor colorWithHexString:@"1699fe"]];
                                }else{
                                    tempLabel.text = [NSString stringWithFormat:@"%@",[self debarNullStr:listModel.listAllResult]];
                                    [tempLabel setTextColor:[UIColor colorWithHexString:@"d00000"]];
                                }
                            }else{
                                tempLabel.text = @"";
                            }
                            tempLabel.text = [[ZPublicManager shareInstance] changeFloat:tempLabel.text];
                        }
                            
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    });

    
}

- (void)setIsFirst:(BOOL)isFirst {
    _lineColor = isFirst ? [UIColor colorWithHexString:@"d00000"]:kBack6Color;
    
    _backView.backgroundColor = _lineColor;
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderWidth = isFirst ?1:0.5;
    _backView.layer.borderColor = _lineColor.CGColor;
}

- (void)setIsTFEnable:(BOOL)isTFEnable {
    _nameInputTF.inputTF.enabled = isTFEnable;
    _addTFView.isTFEnable = isTFEnable;
}

- (NSString *)debarNullStr:(NSString *)str{
    if (!str || [str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return str;
}

+ (CGFloat)getCellHeight:(id)sender {
    NSArray *tempArr = sender;
    if (tempArr && tempArr.count > 1) {
        return 40 * tempArr.count;
    }
    return 40;
}
@end

