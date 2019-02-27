//
//  ZMyAllBillView.m
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMyAllBillView.h"
#import "ZMyAlllBillFootView.h"
#import "ZMyAllBillListCell.h"

@interface ZMyAllBillView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UIView *contView;
@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,strong) UITableView *rightTableView;
@property (nonatomic,strong) ZMyAlllBillFootView *billFootView;
@property (nonatomic,strong) ZMyAllBillListCell *leftAmountView;
@property (nonatomic,strong) ZMyAllBillListCell *rightAmountView;

@property (nonatomic,strong) NSMutableArray *addArr;
@property (nonatomic,strong) NSMutableArray *subArr;

@property (nonatomic,strong) NSString *addStr;
@property (nonatomic,strong) NSString *subStr;

@property (nonatomic,strong) UILabel *hintLabel;
@property (nonatomic,strong) UITextField *mouthTF;

@end

@implementation ZMyAllBillView


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
    
    _subArr = @[].mutableCopy;
    _addArr = @[].mutableCopy;
    
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
        make.width.mas_equalTo(CGFloatIn2048(1200));
        make.height.mas_equalTo(CGFloatIn1536(1000));
    }];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = [UIColor blackColor];
    hintLabel.text = @"查看总账";
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel setFont:[UIFont systemFontOfSize:24.0f]];
    [_contView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contView.mas_top).offset(50 );
        make.left.right.equalTo(self.contView);
        make.height.mas_equalTo(50);
    }];
    _hintLabel = hintLabel;
    
    UIView *hintLabelLineView = [[UIView alloc] initWithFrame:CGRectZero];
    hintLabelLineView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [hintLabel addSubview:hintLabelLineView];
    [hintLabelLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(hintLabel);
        make.height.mas_equalTo(0.5);
    }];
    
    self.leftTableView = [self iTableView];
    [self.contView addSubview:self.leftTableView];
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLabelLineView.mas_bottom);
        make.right.equalTo(self.contView.mas_centerX).offset(-50);
        make.left.equalTo(self.contView.mas_left);
        make.height.mas_equalTo(245);
    }];
    
    [self.contView addSubview:self.leftAmountView];
    [self.leftAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftTableView.mas_bottom);
        make.left.equalTo(self.leftTableView.mas_left);
        make.right.equalTo(self.leftTableView.mas_right);
        make.height.mas_equalTo([ZMyAllBillListCell getCellHeight:nil]);
    }];
    
    self.rightTableView = [self iTableView];
    [self.contView addSubview:self.rightTableView];
    [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hintLabelLineView.mas_bottom);
        make.left.equalTo(self.contView.mas_centerX).offset(50);
        make.right.equalTo(self.contView.mas_right);
        make.height.mas_equalTo(245);
    }];
    
    [self.contView addSubview:self.rightAmountView];
    [self.rightAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightTableView.mas_bottom);
        make.left.equalTo(self.rightTableView.mas_left);
        make.right.equalTo(self.rightTableView.mas_right);
        make.height.mas_equalTo([ZMyAllBillListCell getCellHeight:nil]);
    }];
 
    [self.contView addSubview:self.billFootView];
    [_billFootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rightAmountView.mas_bottom);
        make.left.equalTo(self.contView.mas_left);
        make.right.equalTo(self.contView.mas_right);
        make.height.mas_equalTo(50);
    }];
    
    _mouthTF  = [[UITextField alloc] init];
    [_mouthTF setFont:[UIFont systemFontOfSize:24]];
    [_mouthTF setTextColor:[UIColor redColor]];
    _mouthTF.leftViewMode = UITextFieldViewModeAlways;
    [_mouthTF setTextAlignment:NSTextAlignmentCenter];
    [_mouthTF setBorderStyle:UITextBorderStyleNone];
    [_mouthTF setBackgroundColor:[UIColor clearColor]];
    [_mouthTF setReturnKeyType:UIReturnKeySearch];
    [_mouthTF setPlaceholder:@"备注"];
    [self.contView addSubview:self.mouthTF];
    [_mouthTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.billFootView.mas_bottom);
        make.left.equalTo(self.contView.mas_left);
        make.right.equalTo(self.contView.mas_right);
        make.height.mas_equalTo(50);
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
        topTitleLabel.text = @"总账单";
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
-(ZMyAlllBillFootView *)billFootView {
    if (!_billFootView) {
        _billFootView = [[ZMyAlllBillFootView alloc] init];
        [_billFootView setAdd:@"0" sub:@"0" amount:@""];
    }
    return _billFootView;
}


- (void)backBtnOnclick:(id)sender {
    [self removeFromSuperview];
}

-(ZMyAllBillListCell *)leftAmountView {
    if (!_leftAmountView) {
        _leftAmountView = [ZMyAllBillListCell cellWithTableView:self.leftTableView];
        _leftAmountView.style = 1;
        [_leftAmountView setLeftTitle:@"赢总额" rightTitle:@"０.9"];
    }
    return _leftAmountView;
}

-(ZMyAllBillListCell *)rightAmountView {
    if (!_rightAmountView) {
        _rightAmountView = [ZMyAllBillListCell cellWithTableView:self.rightTableView];
        _rightAmountView.style = 3;
        [_rightAmountView setLeftTitle:@"输总额" rightTitle:@"０.３"];
    }
    return _rightAmountView;
}

-(UITableView *)iTableView {
    UITableView *iTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    if ([iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
        iTableView.estimatedRowHeight = 0;
        iTableView.estimatedSectionHeaderHeight = 0;
        iTableView.estimatedSectionFooterHeight = 0;
        if (@available(iOS 11.0, *)) {
            iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    } else {
       
    }
    iTableView.delegate = self;
    iTableView.dataSource = self;
    return iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return _addArr.count;
    }else if (tableView == _rightTableView){
        return _subArr.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMyAllBillListCell *cell = [ZMyAllBillListCell cellWithTableView:tableView];
    if (tableView == _leftTableView) {
        NSDictionary *tempDict = _addArr[indexPath.row];
//        if (indexPath.row == 4) {
//            cell.style = 1;
//            [cell setLeftTitle:@"赢总额" rightTitle:@"０.9"];
//        }else{
            cell.style = 0;
            [cell setLeftTitle:tempDict[@"name"] rightTitle:[NSString stringWithFormat:@"+%@", [[ZPublicManager shareInstance] changeFloat:tempDict[@"value"]]]];
//        }
    }else{
//        if (indexPath.row == 4) {
//            cell.style = 3;
//            [cell setLeftTitle:@"输总额" rightTitle:@"０.9"];
//        }else{
            cell.style = 2;
            NSDictionary *tempDict = _subArr[indexPath.row];
            [cell setLeftTitle:tempDict[@"name"] rightTitle:[NSString stringWithFormat:@"%@",[[ZPublicManager shareInstance] changeFloat:tempDict[@"value"]]]];
//            [cell setLeftTitle:@"张三" rightTitle:@"０.3"];
//        }
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMyAllBillListCell getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)setSceneItem:(ZSceneItem *)SceneItem {
    double add = 0.0;
    double sub = 0.0;
    [_addArr removeAllObjects];
    [_subArr removeAllObjects];
    for (int i = 0; i < SceneItem.sceneLists.count; i++) {
        if (i == SceneItem.sceneLists.count-1) {
            ZInningItem *item = SceneItem.sceneLists[i];
            for (int j = 0; j < item.itemModel.inninglist.count; j++) {
                ZInningListModel *listModel =  item.itemModel.inninglist[j];
                if (listModel.listName && listModel.listName.length > 0 ) {
                    if ([listModel.listAllResult doubleValue] > -0.00001) {
                        [_addArr addObject:@{@"name":listModel.listName,@"value":listModel.listAllResult}];
                        add+=[listModel.listAllResult doubleValue];
                    }else{
                        [_subArr addObject:@{@"name":listModel.listName,@"value":listModel.listAllResult}];
                        sub+=[listModel.listAllResult doubleValue];
                    }
                }
            }
        }
    }
    
    _addStr = [NSString stringWithFormat:@"%.3f",add];
    _subStr = [NSString stringWithFormat:@"%.3f",sub];
    _addStr = [[ZPublicManager shareInstance] changeFloat:_addStr];
    _subStr = [[ZPublicManager shareInstance] changeFloat:_subStr];
    [_leftTableView reloadData];
    [_rightTableView reloadData];
    [_leftAmountView setLeftTitle:@"赢总额" rightTitle:_addStr];
    [_rightAmountView setLeftTitle:@"输总额" rightTitle:_subStr];
    [_billFootView setAdd:_addStr sub:_subStr amount:[NSString stringWithFormat:@"%.3f",sub+add]];
    _hintLabel.text = [NSString stringWithFormat:@"第%@场总账",[[ZPublicManager shareInstance] changeFloat:SceneItem.sceneSort]];
    _mouthTF.text = @"";
}
@end

