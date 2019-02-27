//
//  ZPublicManager.h
//  zcfBase
//
//  Created by zzz on 2018/5/8.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZUserModel.h"
typedef NS_ENUM(NSUInteger, HNFormatterType) {
    HNFormatterTypeAny,                 //不过滤
    HNFormatterTypePhoneNumber,         //11位电话号码
    HNFormatterTypeNumber,              //数字
    HNFormatterTypeDecimal,             //小数
    HNFormatterTypeAlphabet,            //英文字母
    HNFormatterTypeNumberAndAlphabet,   //数字+英文字母
    HNFormatterTypeIDCard,              //18位身份证
    HNFormatterTypeCustom               //自定义
};

@interface ZPublicManager : NSObject
+(ZPublicManager *) shareInstance;

@property(nonatomic, strong) NSString *deviceUuid;//设备uuid 设备唯一值
@property(nonatomic, strong) NSData *deviceTokenData;//设备推送标识
@property(nonatomic, strong) NSString *versionNum;
@property(nonatomic, assign) NSInteger cartNum;
@property(nonatomic, strong) ZUserModel *user;
@property(nonatomic, strong) NSDictionary *verInfoDic;//版本和升级信息




-(void)checkNetwork;
-(BOOL)isNetworkEnableNew;
-(BOOL)isReachableViaWiFi;


-(NSInteger)getDevice;

/**
 *  初始化网络
 */
-(void)monitoringNetwork;


/**
 判断是否可以打开网络
 */
- (BOOL)isNetworkEnable;

- (NSString *)changeFloat:(NSString *)stringFloat;
@end
