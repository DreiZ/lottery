//
//  ZHomeLeftView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeLeftView.h"
#import "ZHomeTopTitleView.h"
#import "ZHomeTitleCell.h"
#import "ZHomeListCell.h"

@interface ZHomeLeftView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZHomeTopTitleView *topView;

@end
@implementation ZHomeLeftView

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
    
    UIView *statusBar = [[UIView alloc] initWithFrame:CGRectZero];
    statusBar.backgroundColor = kBack6Color;
    [self addSubview:statusBar];
    [statusBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(80.5);
        make.top.equalTo(statusBar.mas_bottom);
    }];

    [self addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.topView.mas_bottom);
    }];
}

#pragma mark lazy loading...
-(ZHomeTopTitleView *)topView {
    if (!_topView) {
        _topView = [[ZHomeTopTitleView alloc] init];
    }
    
    return _topView;
}

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
            if (@available(iOS 11.0, *)) {
//                self.automaticallyAdjustsScrollViewInsets = NO;
            } else {
                // Fallback on earlier versions
            }
        }
        _iTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 70)];
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _inningModel.inninglist.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ZHomeListCell *cell = [ZHomeListCell cellWithTableView:tableView];
    cell.nameValueChange = ^(NSString *value) {
        if (weakSelf.nameValueChange) {
            weakSelf.nameValueChange(value, weakSelf.inningModel.inninglist[indexPath.row]);
        }
    };
    cell.nameBeginChange = ^(NSString *value) {
        if (weakSelf.nameBeginChange) {
            weakSelf.nameBeginChange(value, weakSelf.inningModel.inninglist[indexPath.row]);
        }
    };
    
    cell.valueChange = ^(NSString *value) {
        if (weakSelf.valueChange) {
            weakSelf.valueChange(value, weakSelf.inningModel.inninglist[indexPath.row]);
        }
    };
    
    cell.beginChange = ^(UITextField *textField) {
        if (weakSelf.beginChange) {
            weakSelf.beginChange(textField, weakSelf.inningModel.inninglist[indexPath.row]);
        }
    };
    
    cell.endChange = ^(UITextField *textField) {
        if (weakSelf.endChange) {
            weakSelf.endChange(textField, weakSelf.inningModel.inninglist[indexPath.row]);
        }
    };
    cell.isTFEnable = _inningModel.isEnable;
    cell.listModel = _inningModel.inninglist[indexPath.row];
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZInningListModel *model = (ZInningListModel *)_inningModel.inninglist[indexPath.row];
    return [ZHomeListCell getCellHeight:model.listInput];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark refresh data

- (void)refreshData {
    [_iTableView reloadData];
}

- (void)refreshHeadData {
    _topView.multiplying = _inningModel.multiplying;
}

-(void)setTopSubTitleArr:(NSArray *)topSubTitleArr {
    _topSubTitleArr = topSubTitleArr;
    _topView.subTitleArr = topSubTitleArr;
}
@end
