//
//  ZPublicManager.m
//  zcfBase
//
//  Created by zzz on 2018/5/8.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import "ZPublicManager.h"
#import "AppDelegate.h"
#import <sys/utsname.h>
#import "AFNetworkReachabilityManager.h"

NSString * const kKEY_LGUUID = @"LGUUID";

static ZPublicManager *sharePublicClassManager = NULL;
@interface ZPublicManager()
@property (nonatomic,assign) NSUInteger showVipCount;
@end
@implementation ZPublicManager
@synthesize versionNum;
@synthesize deviceUuid;

+(ZPublicManager*)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharePublicClassManager ==NULL)
        {
            sharePublicClassManager =[[ZPublicManager alloc] init];
        }
    });
    
    
    return sharePublicClassManager;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

-(void)initData
{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    self.versionNum = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    _showVipCount=0;
}

- (void)checkNetwork {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if(!mgr.reachable)
    {
        [MBProgressHUD showErrorWithMsg:@"无法连接到网络,请您在‘设置’中连接Wi_Fi或打开手机蜂窝网络" ];
    }
}

- (BOOL)isNetworkEnableNew {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if(!mgr.reachable)
    {
        return NO;
        
    }
    return YES;
}

- (BOOL)isReachableViaWiFi {
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if(!mgr.isReachableViaWiFi)
    {
        return NO;
        
    }
    return YES;
}

- (BOOL)isNetworkEnable {
    if (![self whetherConnectedNetwork]) return NO;
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    NSString *type = @"NONE";
    for (id subview in subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            int networkType = [[subview valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    type = @"NONE";
                    break;
                case 1:
                    type = @"2G";
                    break;
                case 2:
                    type = @"3G";
                    break;
                case 3:
                    type = @"4G";
                    break;
                case 5:
                    type = @"WIFI";
                    break;
            }
        }
    }
    
    if ([type isEqualToString:@"NONE"]) {
        return NO;
    }
    return YES;
}

- (BOOL)whetherConnectedNetwork
{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    
    struct sockaddr_storage zeroAddress;//IP地址
    
    bzero(&zeroAddress, sizeof(zeroAddress));//将地址转换为0.0.0.0
    zeroAddress.ss_len = sizeof(zeroAddress);//地址长度
    zeroAddress.ss_family = AF_INET;//地址类型为UDP, TCP, etc.
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
}



+(BOOL)isAlert{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if ([keyWindow isMemberOfClass:[UIWindow class]])
    {
        return  NO;
    }
    return YES;
}


-(NSInteger)getDevice
{
    NSInteger deviceHeight = screenHeight;
    if (deviceHeight>=736) {
        return  61;
    }
    if (deviceHeight>=667) {
        return 6;
    }
    if (deviceHeight>=568) {
        return 5;
    }
    if (deviceHeight>=480) {
        return 4;
    }
    return 5;
}

+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

#pragma mark 网络数据
-(void)monitoringNetwork{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                NSLog(@"未知网络");
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
                //                [[NSNotificationCenter defaultCenter]postNotificationName:NETWORK_STATE_CHANGE_NOTIFICATION object:nil];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"无线网络");
                break;
            }
            default:
                break;
        }
    }];
}


- (NSString *)deviceModel{
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    NSString *deviceCode = @"unknown";
    deviceCode = code;
    return deviceCode;
}


//去掉小数点后无效0
- (NSString *)changeFloat:(NSString *)stringFloat {
    if (stringFloat && [stringFloat rangeOfString:@"."].location != NSNotFound) {
        
    }else{
        return stringFloat;
    }
    
    const char *floatChars = [stringFloat UTF8String];
    NSUInteger length = [stringFloat length];
    NSUInteger zeroLength = 0;
    NSUInteger i = length-1;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wtautological-compare"
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/) {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
#pragma clang diagnostic pop
    NSString *returnString;
    if(i == -1) {
        returnString = @"0";
    } else {
        returnString = [stringFloat substringToIndex:i+1];
    }
    return returnString;
}

@end
