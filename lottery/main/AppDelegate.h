//
//  AppDelegate.h
//  zcfBase
//
//  Created by zzz on 2018/5/8.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *tb;
@property (assign, nonatomic) BOOL isAddRefresh;
@property (assign, nonatomic) NSInteger firstIndex;//addtf第几行
@property (assign, nonatomic) NSInteger listIndex;//第几行
+ (AppDelegate *)App;
@end

