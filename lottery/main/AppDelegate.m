//
//  AppDelegate.m
//  zcfBase
//
//  Created by zzz on 2018/5/8.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import "AppDelegate.h"
#import "ZMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self startApplication];
    return YES;
}


#pragma mark ------------ custom fun ------------
- (void)startApplication {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self setupViewControllers];
}

- (void)setupViewControllers {
    self.tb = [[UINavigationController alloc] initWithRootViewController: [[ZMainViewController alloc] init]];
    self.window.rootViewController =  _tb;
    [self.window makeKeyAndVisible];
}

+ (AppDelegate *)App {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
