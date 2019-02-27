//
//  ZMainPublicNetworkManager.m
//  fixture365
//
//  Created by zzz on 2018/5/19.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMainPublicNetworkManager.h"
#import "NetworkManagerCenter.h"

#define kShuidianUrl @"shensuanqi/pad"

@implementation ZMainPublicNetworkManager
+ (void)getCode:(NSDictionary *)dic
        success:(void (^)(NSDictionary *info))success
        faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/getCode"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)userRegister:(NSDictionary *)dic
             success:(void (^)(NSDictionary *info))success
               faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/register"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)registerWorker:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/registerWorker"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)thirdUserLogin:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/thirdUserLogin"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}


+ (void)bindthirdOldUser:(NSDictionary *)dic
                 success:(void (^)(NSDictionary *info))success
                   faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/BindthirdOldUser"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)thirdUserRegister:(NSDictionary *)dic
                  success:(void (^)(NSDictionary *info))success
                    faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/thirdUserRegister"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)thirdWorkerRegister:(NSDictionary *)dic
                    success:(void (^)(NSDictionary *info))success
                      faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/thirdWorkerRegister"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}


+ (void)userLeague:(NSDictionary *)dic
           success:(void (^)(NSDictionary *info))success
             faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/UserLeague"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)userLogin:(NSDictionary *)dic
          success:(void (^)(NSDictionary *info))success
            faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"pad_login.do"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)updatePassword:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/updatePassword"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)updateShuidianUser:(NSDictionary *)dic
                   success:(void (^)(NSDictionary *info))success
                     faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/updateShuidianUser"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)uploadIdCard:(NSDictionary *)dic
             success:(void (^)(NSDictionary *info))success
               faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/uploadIdCard"];
    [[NetworkManagerCenter sharedManager] postImageDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)uploadHeadPic:(NSDictionary *)dic
              success:(void (^)(NSDictionary *info))success
                faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianUser/uploadHeadPic"];
    [[NetworkManagerCenter sharedManager] postImageDic:dic urlStr:urlStr success:success failure:failure];
}


+ (void)getServiceList:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianService/getDataPage"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)getSerivceInfo:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianService/SerivceInfo"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)getTopMainService:(NSDictionary *)dic
                  success:(void (^)(NSDictionary *info))success
                    faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianService/getTopService"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}


+ (void)addOrderService:(NSDictionary *)dic
                success:(void (^)(NSDictionary *info))success
                  faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"order/addOrderService"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

+ (void)getServiceWithName:(NSDictionary *)dic
                   success:(void (^)(NSDictionary *info))success
                     faile:(void (^)(NSError *error))failure
{
    NSString *urlStr = [self getSDUrl:@"shuidianService/listData"];
    [[NetworkManagerCenter sharedManager] postDic:dic urlStr:urlStr success:success failure:failure];
}

#pragma mark 拼接url
+ (NSString *)getSDUrl:(NSString*)url{
    return [NSString stringWithFormat:@"%@/%@",kShuidianUrl,url];
}
@end
