//
//  ZBaseViewController.m
//  lottery
//
//  Created by zzz on 2018/6/26.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseViewController.h"

@interface ZBaseViewController ()


@end

@implementation ZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDeviceScape];
    // 添加方向监听
    [self addApplicationOrientationObserver];
}


//屏幕装
- (void)getDeviceScape {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationLandscapeRight:
        {
            NSLog(@"右");
            self.isHorizontal = YES;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            NSLog(@"左");
            self.isHorizontal = YES;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            NSLog(@"上");
            self.isHorizontal = NO;
        }
            break;
        case UIInterfaceOrientationPortrait:
        {
            NSLog(@"下");
            self.isHorizontal = NO;
            
        }
            break;
        case UIInterfaceOrientationUnknown:
        {
            NSLog(@"不知道");
        }
            break;
            
        default:
            break;
    }
    
}


- (void)addApplicationOrientationObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWillRotate:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidRotate:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)handleDeviceOrientationChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    UIInterfaceOrientation appOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    
    NSLog(@"\nOrientation:%@\n User Info :%@", @(appOrientation), userInfo);
}

- (void)handleWillRotate:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSLog(@"\nWill Rotate %@", userInfo);
}

- (void)handleDidRotate:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSLog(@"\nDid Rotate %@", userInfo);
    if ([userInfo objectForKey:@"UIApplicationStatusBarOrientationUserInfoKey"] && ([userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 1  ||[userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 2)) {
        NSLog(@"横屏");
    }else if ([userInfo objectForKey:@"UIApplicationStatusBarOrientationUserInfoKey"] && ([userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 3  ||[userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 4)) {
        NSLog(@"竖屏");
    }
    [self getDeviceScape];
}

- (void)setIsHorizontal:(BOOL)isHorizontal {
    _isHorizontal = isHorizontal;
    [self reLayoutSubViewsWithIsHorizontal:_isHorizontal];
}

- (void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {

}
@end
