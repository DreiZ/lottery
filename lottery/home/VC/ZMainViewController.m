//
//  ZMainViewController.m
//  lottery
//
//  Created by 承希-开发 on 2019/2/26.
//  Copyright © 2019 zzz. All rights reserved.
//

#import "ZMainViewController.h"
#import "ZBottomRntryView.h"
#import "ZResultTrendView.h"
#import "ZRightToolsView.h"

#import "ZLotteryModel.h"

@interface ZMainViewController ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView* iScrollView;
@property (nonatomic,strong) ZBottomRntryView *entryView;
@property (nonatomic,strong) ZResultTrendView *trendView;
@property (nonatomic,strong) ZRightToolsView *toolsView;

@property (nonatomic,strong) ZLotteryModel *lotteryModel;

@end

@implementation ZMainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMainView];
}

- (void)setData {
    _lotteryModel = [[ZLotteryModel alloc] init];
}

#pragma mark - 初始化数据和view
- (void)setMainView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.entryView];
    [self.entryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(50 + kTabBarMoreHeight);
    }];
    
    [self.view addSubview:self.trendView];
    [self.trendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kTabBarMoreHeight);
        make.bottom.equalTo(self.entryView.mas_top);
    }];
    
//    [self.view addSubview:self.iScrollView];
//    [self.iScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view.mas_top).offset(kStatusBarHeight);
//        make.bottom.equalTo(self.entryView.mas_top);
//    }];
//
//    [self.iScrollView addSubview:self.trendView];
//    [self.trendView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(4);
//        make.height.mas_equalTo(kScreenHeight);
//        make.top.mas_equalTo(4);
//        make.width.mas_equalTo(kScreenWidth*1.4+2);
//    }];
}


#pragma mark - 懒加载
- (UIScrollView *)iScrollView {
    if (!_iScrollView) {
        _iScrollView = [[UIScrollView alloc] init];
        _iScrollView.delegate = self;
        _iScrollView.backgroundColor = [UIColor whiteColor];
        _iScrollView.showsVerticalScrollIndicator = NO;
        _iScrollView.showsHorizontalScrollIndicator = NO;
        _iScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _iScrollView.contentSize = CGSizeMake(0, 0);
    }
    return _iScrollView;
}

- (ZBottomRntryView *)entryView {
    if (!_entryView) {
        __weak typeof(self) weakSelf = self;
        _entryView = [[ZBottomRntryView alloc] init];
        _entryView.addLotteryBlock = ^(ZLotteryModel * model) {
            [weakSelf.trendView addLottery:model];
        };
        
        _entryView.cuteBlock = ^{
            [weakSelf savePictureToPhotoAlbum];
        };
        
        _entryView.hiddenBlock = ^{
            [weakSelf.entryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(weakSelf.view);
                make.height.mas_equalTo(0.01);
            }];
        };
    }
    return _entryView;
}

- (ZResultTrendView *)trendView {
    if (!_trendView) {
        __weak typeof(self) weakSelf = self;
        _trendView = [[ZResultTrendView alloc] init];
        _trendView.scrollBlock = ^{
            [weakSelf.entryView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.bottom.right.equalTo(weakSelf.view);
                make.height.mas_equalTo(50 + kTabBarMoreHeight);
            }];
        };
    }
    return _trendView;
}

- (ZRightToolsView *)toolsView {
    if (!_toolsView) {
        _toolsView = [[ZRightToolsView alloc] init];
        
    }
    return _toolsView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
#pragma mark - 屏幕旋转处理
//获取设备方向 更新 UI
-(void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    if (isHorizontal) {
        
    }else {
        
    }
}



#pragma mark 截图处理
- (UIImage *)nomalSnapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.trendView.size, NO, [UIScreen mainScreen].scale);
    [self.trendView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}

- (void)savePictureToPhotoAlbum {
    UIImage * img = [self nomalSnapshotImage];
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        [self showSuccessWithMsg:@"截图已保存到系统相册"];
    } else {
        [self showErrorWithMsg:@"截图失败"];
    }
}
@end
