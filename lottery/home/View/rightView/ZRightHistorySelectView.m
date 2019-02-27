//
//  ZRightHistorySelectView.m
//  lottery
//
//  Created by zzz on 2018/7/1.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZRightHistorySelectView.h"

@interface ZRightHistorySelectView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) UIView *contView;
@end

@implementation ZRightHistorySelectView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn addTarget:self action:@selector(backBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        
    }];
    
    
    [self addSubview:self.contView];
    [_contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(20);
        make.width.mas_equalTo(356);
        make.height.mas_equalTo(screenHeight - 150);
    }];
    
    
    
    [self.contView addSubview:self.iTableView];
    [_iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contView.mas_left).offset(20);
        make.right.equalTo(self.contView.mas_right).offset(-20);
        make.top.equalTo(self.contView.mas_top).offset(51);
        make.bottom.equalTo(self.contView.mas_bottom).offset(-20);
    }];
}

- (UIView *)contView {
    if (!_contView) {
        _contView = [[UIView alloc] init];
        _contView.backgroundColor = [UIColor whiteColor];
        
        UIView *topTitleView = [[UIView alloc] initWithFrame:CGRectZero];
        topTitleView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        [_contView addSubview:topTitleView];
        [topTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(topTitleView.superview);
            make.height.mas_equalTo(50);
        }];
        
        
        UILabel *topTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        topTitleLabel.textColor = [UIColor blackColor];
        topTitleLabel.text = @"选择历史场次";
        topTitleLabel.textAlignment = NSTextAlignmentCenter;
        [topTitleLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [topTitleView addSubview:topTitleLabel];
        [topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(topTitleView);
        }];
        
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [backBtn addTarget:self action:@selector(backBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        [topTitleView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(topTitleView);
            make.width.mas_equalTo(50);
        }];
        
    }
    return _contView;
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.contView
                       .bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
        _iTableView.tableFooterView = [self footerView];
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _historyAllList.allHisoryLists.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZSceneItem *sceneItem = _historyAllList.allHisoryLists[section];
    return sceneItem.sceneLists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZSceneItem *sceneItem = _historyAllList.allHisoryLists[indexPath.section];
    ZInningItem *inningItem = sceneItem.sceneLists[indexPath.row];
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    
    if (!inningItem.winNum || inningItem.winNum.length == 0 || [inningItem.winNum isKindOfClass:[NSNull class]]) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"第＃%@-%@筒　未开",sceneItem.sceneSort,
                               inningItem.inningSort];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"第＃%@-%@筒　开%@",sceneItem.sceneSort,
                               inningItem.inningSort,
                               inningItem.winNum];
    }
    
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZSceneItem *sceneItem = _historyAllList.allHisoryLists[indexPath.section];
    ZInningItem *inningItem = sceneItem.sceneLists[indexPath.row];
    if (_numSeletBlock) {
        if (!inningItem.sceneSort) {
            inningItem.sceneSort = sceneItem.sceneSort;
        }
        _numSeletBlock(inningItem);
    }
    [self removeFromSuperview];
}

- (UIView *)footerView {
    UIButton *backNowBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 45)];
    [backNowBtn addTarget:self action:@selector(backNowBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backNowBtn setTitle:@"本  场" forState:UIControlStateNormal];
    [backNowBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backNowBtn.titleLabel  setFont:[UIFont systemFontOfSize:14]];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [backNowBtn addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(backNowBtn);
        make.height.mas_equalTo(0.5);
    }];
    return backNowBtn;
}

- (void)backNowBtn:(UIButton *)sender {
    if (_numSeletBlock) {
        _numSeletBlock(nil);
    }
    [self removeFromSuperview];
}

- (void)seletBtnClick:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)backBtnOnclick:(id)sender {
    [self removeFromSuperview];
}

- (void)setHistoryAllList:(ZHistoryAllList *)historyAllList {
    _historyAllList = historyAllList;
    if (_historyAllList.allHisoryLists) {
        [_iTableView reloadData];
    }
}
@end
