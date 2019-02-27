//
//  ZHomeListAddTFView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeListAddTFView.h"
#import "ZHomeListAddTFCell.h"
#import "AppDelegate.h"

@interface ZHomeListAddTFView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *iTableView;

@end
@implementation ZHomeListAddTFView


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
    
    
    [self addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
//            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.scrollEnabled = NO;
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModel.listInput.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ZHomeListAddTFCell *cell = [ZHomeListAddTFCell cellWithTableView:tableView];
    cell.inputView.inputTF.enabled = YES;
    cell.inputView.inputTF.text = [self debarNullStr:_listModel.listInput[indexPath.row]];
    cell.valueChange = ^(NSString *value) {
        weakSelf.listModel.listInput[indexPath.row] = value;
        NSLog(@"zzz value %@",value);
        if (weakSelf.valueChange) {
            weakSelf.valueChange(value);
        }
    };
    
    cell.beginChange = ^(UITextField *textField) {
        [AppDelegate App].listIndex = [self.listModel.listSort integerValue];
        [AppDelegate App].firstIndex = indexPath.row;
        if (weakSelf.beginChange) {
            weakSelf.beginChange(textField);
        }
//        NSLog(@"zzz .begin %@",textField);
    };
    
    cell.endChange = ^(UITextField *textField) {
        if (weakSelf.endChange) {
            weakSelf.endChange(textField);
        }
//        NSLog(@"zzz .end %@",textField);
    };
    
    if ([AppDelegate App].isAddRefresh ) {
//        NSLog(@"zzz %ld %ld",[AppDelegate App].listIndex, [_listModel.listSort integerValue]);
        if ([AppDelegate App].listIndex == [_listModel.listSort integerValue] && indexPath.row == _listModel.listInput.count-1) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSLog(@"zzz .inputView.inputTF %@",cell.inputView.inputTF);
                [cell.inputView.inputTF becomeFirstResponder];
                [AppDelegate App].isAddRefresh = NO;
            });
            
        }
        
    }

    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZHomeListAddTFCell getCellHeight:nil];;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark set
- (void)setListModel:(ZInningListModel *)listModel {
    _listModel = listModel;
    [_iTableView reloadData];
}

- (NSString *)debarNullStr:(NSString *)str{
    if (!str || [str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return str;
}
@end
