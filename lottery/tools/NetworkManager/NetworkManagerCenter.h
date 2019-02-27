//
//  NetworkManagerCenter.h
//  hntx
//
//  Created by zzz on 16/2/14.
//  Copyright © 2016年 zoomwoo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAPI @"http://47.106.39.94:8080"


typedef  void(^successBlock)(NSDictionary *info);
typedef void(^failureBlock) (NSError *error);


@interface NetworkManagerCenter : NSObject


+ (instancetype) sharedManager;

-(void)cancelAllOperations;

-(void)getDic:(NSDictionary *)getDic
       urlStr:(NSString *)urlStr
      success:(void(^)(NSDictionary *info))success
      failure:(void(^)(NSError *error))failure;

-(NSURLSessionDataTask *)postDic:(NSDictionary *)postDic
        urlStr:(NSString *)urlStr
       success:(void(^)(NSDictionary *info))success
       failure:(void(^)(NSError *error))failure;

-(NSURLSessionDataTask *)postDic:(NSDictionary *)postDic
                      fullUrlStr:(NSString *)fullUrlStr
                         success:(void (^)(NSDictionary *))success
                         failure:(void (^)(NSError *))failure;
-(NSURLSessionDataTask *)postDicWithNosign:(NSDictionary *)postDic
                                fullUrlStr:(NSString *)fullUrlStr
                                   success:(void (^)(NSDictionary *))success
                                   failure:(void (^)(NSError *))failure;

-(NSURLSessionDataTask *)postImageDic:(NSDictionary *)postDic
                               urlStr:(NSString *)urlStr
                              success:(void(^)(NSDictionary *info))success
                              failure:(void(^)(NSError *error))failure;

-(NSURLSessionDataTask *)postParam:(NSDictionary *)parDic
          urlStr:(NSString *)urlStr
         success:(void(^)(NSDictionary *info))success
         failure:(void(^)(NSError *error))failure;


- (NSString *) toJSONString:(id)object;
@end
