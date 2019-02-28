//
//  ZResultTrendView.m
//  lottery
//
//  Created by 承希-开发 on 2019/2/26.
//  Copyright © 2019 zzz. All rights reserved.
//

#import "ZResultTrendView.h"
#import "ZResultTopTitleView.h"
#import "ZResultTrendCell.h"
#import <MJRefresh/MJRefresh.h>

@interface ZResultTrendView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) ZResultTopTitleView *titleView;
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic, strong) MJRefreshNormalHeader *refresHeader;



@property (nonatomic, strong) NSDate *curDate;

@property (nonatomic,strong) NSMutableArray *lotteryArr;

@end

@implementation ZResultTrendView


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
    
    _curDate = [NSDate new];
    _lotteryArr = [[NSMutableArray alloc] init];
    
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(100);
    }];
    
    [self addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.titleView.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    
    [self.iTableView setMj_header:self.refresHeader];
    
    [self p_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
        if (!hasMore) {
            weakSelf.iTableView.mj_header = nil;
        }
        if (count > 0) {
            [weakSelf.iTableView reloadData];
        }
    }];
}



#pragma mark - 懒加载
- (ZResultTopTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[ZResultTopTitleView alloc] init];
    }
    return _titleView;
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
//        _iTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth*1.4, 70)];
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}


- (MJRefreshNormalHeader *)refresHeader
{
    if (_refresHeader == nil) {
        __weak typeof(self) weakself = self;
        _refresHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself p_tryToRefreshMoreRecord:^(NSInteger count, BOOL hasMore) {
                [weakself.iTableView.mj_header endRefreshing];
                if (!hasMore) {
                    weakself.iTableView.mj_header = nil;
                }
                if (count > 0) {
                    [weakself.iTableView reloadData];
                    [weakself.iTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }];
        }];
        _refresHeader.lastUpdatedTimeLabel.hidden = YES;
        _refresHeader.stateLabel.hidden = YES;
    }
    return _refresHeader;
}

#pragma mark - tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ZResultTrendCell *cell = [ZResultTrendCell cellWithTableView:tableView];
   
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ZInningListModel *model = (ZInningListModel *)_inningModel.inninglist[indexPath.row];
    return [ZResultTrendCell getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


//刷新数据
- (void)p_tryToRefreshMoreRecord:(void (^)(NSInteger count, BOOL hasMore))complete
{
    __weak typeof(self) weakSelf = self;
    [[ZLotteryManager sharedManager] lotteryRecordForFromDate:_curDate count:20 complete:^(NSArray *array, NSDate* date, BOOL hasMore) {
        if (array.count > 0 && [date isEqualToDate:weakSelf.curDate]) {
            weakSelf.curDate = [array[0] date];
            [weakSelf.lotteryArr insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, array.count)]];
//            complete(array. count, hasMore);
        }
        else {
//            complete(0, hasMore);
        }
    }];
}
@end
