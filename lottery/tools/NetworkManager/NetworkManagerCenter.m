//
//  NetworkManagerCenter.m
//  hntx
//
//  Created by zzz on 16/2/14.
//  Copyright © 2016年 zoomwoo. All rights reserved.
//

#import "NetworkManagerCenter.h"
#import "AFNetworking.h"
#import "ZPublicManager.h"
#import "ZUserModel.h"
#import "AppDelegate.h"
//#import "HNOrderStateEnum.h"
//#import "UMMobClick/MobClick.h"
//#import "SGNCatch.h"
#define InvalidLoginCode 1001
#define HNNetWorkErrorDomain @"com.hntx.twwww"



static NetworkManagerCenter *manager_N;

@interface NetworkManagerCenter ()
//@property (nonatomic, strong) NSMutableArray *parameters;
//@property (nonatomic, strong) NSMutableDictionary *parameterDic;
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation NetworkManagerCenter


+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager_N = [[NetworkManagerCenter alloc] init];
    });
    return manager_N;
}

- (instancetype)init{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return self;
}


-(void)cancelAllOperations
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

#pragma mark get请求
-(void)getDic:(NSDictionary *)getDic
       urlStr:(NSString *)urlStr
      success:(void(^)(NSDictionary *info))success
      failure:(void(^)(NSError *error))failure
{
//     NSMutableDictionary *parameterDic = [self signTheParameters:urlStr postDic:getDic];

    NSString *newUrl = [self getMUrl:urlStr];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                          @"text/json",
                                                          @"text/javascript",
                                                          @"text/html",
                                                          @"text/css",
                                                          @"text/plain",
                                                          @"charset/UTF-8", nil];
    [_manager GET:newUrl parameters:getDic progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark 没有sign的请求
-(NSURLSessionDataTask *)postDicWithNosign:(NSDictionary *)postDic
                      fullUrlStr:(NSString *)fullUrlStr
                         success:(void (^)(NSDictionary *))success
                         failure:(void (^)(NSError *))failure
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if(mgr.networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable)
    {
        //        [[HNPublicTool shareInstance] showHudMessage:@"没有网络，请检查手机网络连接"];
    }
    
    return [self postParam:postDic urlStr:fullUrlStr success:success failure:failure];
}

#pragma mark 传图片
-(NSURLSessionDataTask *)postImageDic:(NSDictionary *)postDic
                               urlStr:(NSString *)urlStr
                              success:(void(^)(NSDictionary *info))success
                              failure:(void(^)(NSError *error))failure
{
    
    NSString *newUrl = [self getMUrl:urlStr];
    //
    //    NSMutableDictionary *parameterDic = [self signTheParameters:urlStr postDic:postDic];
    NSArray *tempImageArr = postDic[@"imageArr"];
    NSArray *tempImageNameArr = postDic[@"imageNameArr"];
    NSDictionary *otherDic = postDic[@"otherDic"];
    return [self postImageWithFullUrlStr:newUrl ImageNameArr:tempImageNameArr imageArr:tempImageArr otherDict:otherDic success:success failure:failure];
    
}

//上传图片
- (NSURLSessionDataTask *)postImageWithFullUrlStr:(NSString *)fullUrlStr
                     ImageNameArr:(NSArray *)imageNameArr
                         imageArr:(NSArray *)imageArr
                        otherDict:(NSDictionary *)otherDic
                          success:(void(^)(NSDictionary *info))success
                          failure:(void(^)(NSError *error))failure{
    
    NSString *newUrl = fullUrlStr;
    NSDictionary *imageDcit = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < imageArr.count; i++) {
        [imageDcit setValue:imageArr[i] forKey:imageNameArr[i]];
    }
    
    NSMutableDictionary *postdic = [[NSMutableDictionary alloc] initWithDictionary:otherDic];
    if ([ZPublicManager shareInstance].user && [ZPublicManager shareInstance].user.userId) {
        [postdic setObject:[ZPublicManager shareInstance].user.userId forKey:@"user_id"];
    }
    [postdic setObject:@"ios" forKey:@"client"];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                          @"text/json",
                                                          @"text/javascript",
                                                          @"text/html",
                                                          @"text/css",
                                                          @"text/plain",
                                                          @"charset/UTF-8", nil];
    NSURLSessionDataTask *task = [_manager POST:newUrl parameters:postdic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (id key in imageDcit) {
            UIImage *image = [imageDcit objectForKey:key];
            if (image == nil) {
                return ;
            }
            NSData* tempData = UIImagePNGRepresentation(image);
            if (tempData == nil) {
                return;
            }
            [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:[NSString stringWithFormat:@"%@",key] fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/png"];
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
    return task;
}

#pragma mark 正常post请求
//1
-(NSURLSessionDataTask *)postDic:(NSDictionary *)postDic
        urlStr:(NSString *)urlStr
       success:(void(^)(NSDictionary *info))success
       failure:(void(^)(NSError *error))failure
{
    
     NSString *newUrl = [self getMUrl:urlStr];
//
//    NSMutableDictionary *parameterDic = [self signTheParameters:urlStr postDic:postDic];
    NSMutableDictionary *parameterDic = [[NSMutableDictionary alloc] initWithDictionary:postDic];
    if ([ZPublicManager shareInstance].user.userId) {
         [parameterDic setObject:[ZPublicManager shareInstance].user.userId forKey:@"userId"];
    }
   
    return [self postDic:parameterDic fullUrlStr:newUrl success:success failure:failure];
    
}

//2
-(NSURLSessionDataTask *)postDic:(NSDictionary *)postDic
                      fullUrlStr:(NSString *)fullUrlStr
                         success:(void (^)(NSDictionary *))success
                         failure:(void (^)(NSError *))failure
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    if(mgr.networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable)
    {
        //        [[HNPublicTool shareInstance] showHudMessage:@"没有网络，请检查手机网络连接"];
    }
    //    NSMutableDictionary *parameterDic = [self signTheParameters:fullUrlStr postDic:postDic];
    NSMutableDictionary *parameterDic = [[NSMutableDictionary alloc] initWithDictionary:postDic];
    if ([ZPublicManager shareInstance].user && [ZPublicManager shareInstance].user.userId) {
        [parameterDic setObject:[ZPublicManager shareInstance].user.userId forKey:@"userId"];
        
    }
    [parameterDic setObject:@"ios" forKey:@"client"];
    return [self postParam:parameterDic urlStr:fullUrlStr success:success failure:failure];
}

//3
-(NSURLSessionDataTask *)postParam:(NSDictionary *)parDic
        urlStr:(NSString *)urlStr
       success:(void(^)(NSDictionary *info))success
       failure:(void(^)(NSError *error))failure
{
    
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"text/json",@"text/javascript", nil];
    NSURLSessionDataTask *task =  [_manager POST:urlStr parameters:parDic progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    return task;
}

#pragma mark 签名
-(NSMutableDictionary*)signTheParameters:(NSString *)urlStr postDic:(NSDictionary *)postDic {
//    [self.parameters removeAllObjects];
//    [self.parameterDic removeAllObjects];
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    NSMutableDictionary *parameterDic = [[NSMutableDictionary alloc] init];
    
    // sign 验证 添加service字段
    NSRange valueRange = [urlStr rangeOfString:@"?service="];
    if (valueRange.length > 0) {
        NSString *urlValue = [urlStr substringFromIndex:valueRange.location+valueRange.length];
        [parameterDic setObject:urlValue forKey:@"service"];
    }
    
    [parameterDic addEntriesFromDictionary:postDic];
    [parameterDic setObject:@"ios" forKey:@"fromTag"];
    [parameterDic setObject:[ZPublicManager shareInstance].versionNum forKey:@"v"];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    [parameterDic setObject:timeSp forKey:@"requestTime"];
    
    for (NSString *key  in [parameterDic allKeys]) {
        [parameters addObject:[NSString stringWithFormat:@"%@=%@",key,parameterDic[key]]];
    }
    
    // 根据key排序值
    NSArray *sortedArray = [parameters sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    for (NSString *key in sortedArray) {
        
        NSRange range = [key rangeOfString:@"="];
        
        NSString *newKey = [key substringToIndex:range.location];
        
        NSString *valueStr;
        if([parameterDic[newKey] isKindOfClass:[NSArray class]] || [parameterDic[newKey] isKindOfClass:[NSDictionary class]]){
            valueStr = [self toJSONString:parameterDic[newKey]];
            //valueStr = ToJSONString(nil, self.parameterDic[newKey]);
            [parameterDic setObject:valueStr forKey:newKey];

            //NSLog(@"valueSTr = %@",valueStr);
        }else
        {
            valueStr = parameterDic[newKey];
            
            //NSLog(@"newKey = %@",newKey);
        }
        // 拼接值 字符串
        if (valueStr) {
            if ([valueStr isKindOfClass:[NSNumber class]]) {
                valueStr = [NSString stringWithFormat:@"%ld",(long)[valueStr integerValue]];
            }
    
            [resultStr appendString:valueStr];
        }
        
    }
    // 拼接 私钥
    [resultStr insertString:@"hntx_murmur_of_the_heart" atIndex:0];
    //NSLog(@"siyue = %@",resultStr);

    // MD5加密
    NSString *MD5Str = [resultStr md5String];

    // 生成sign值
    [parameterDic setObject:MD5Str forKey:@"sign"];
    
    // 去掉service
    [parameterDic removeObjectForKey:@"service"];

    return parameterDic;
}


- (NSString *) toJSONString:(id)object{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
    if (jsonData.length > 0 && error == nil ) {
        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonStr;
    }
    return nil;
    
}

-(NSString*)getMUrl:(NSString*)url
{
    return [NSString  stringWithFormat:@"%@/%@",MAPI,url];
}
@end
