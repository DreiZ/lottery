//
//  ZMainPublicNetworkManager.h
//  fixture365
//
//  Created by zzz on 2018/5/19.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMainPublicNetworkManager : NSObject

/**
 获取验证码

 @param dic
    userPhone   用户手机号
 @param success "result"为ture时发送成功;
 @param failure "result"为false时发送失败;
 */
+ (void)getCode:(NSDictionary *)dic
        success:(void (^)(NSDictionary *info))success
          faile:(void (^)(NSError *error))failure;


/**
 注册

 @param dic
    userPhone      手机号
    userPassword   密码
    usercode      验证码
 @param success ;
 @param failure ;
 */
+ (void)userRegister:(NSDictionary *)dic
             success:(void (^)(NSDictionary *info))success
               faile:(void (^)(NSError *error))failure;

/**
 注册工人
 
 @param dic
 userPhone      手机号
 userPassword   密码
 usercode      验证码
 @param success ;
 @param failure ;
 */
+ (void)registerWorker:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure;


/**
第三方登录
 
 @param dic
 loginType     登陆类型
 qqId    第三方QQID
 winxinId  第三方微信ID
 @param success ;
 @param failure ;
 */
+ (void)thirdUserLogin:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure;
/**
 绑定老用户
 
 @param dic
 userPhone   要绑定的手机号
 qqId        第三方QQID
 winxinId    第三方微信ID
 usercode    验证码
 @param success ;
 @param failure ;
 */
+ (void)bindthirdOldUser:(NSDictionary *)dic
                 success:(void (^)(NSDictionary *info))success
                   faile:(void (^)(NSError *error))failure;


/**
 第三方登陆新用户注册
 @param dic
 qqId     第三方QQ提供ID
 weixinId    第三方微信提供ID
 userPhone  手机号
 userPassword   密码
 userCode    验证码
 userDcode    邀请码
 headpic   头像路径
 nickname    昵称
 usercode    验证码
 @param success ;
 @param failure ;
 */
+ (void)thirdUserRegister:(NSDictionary *)dic
                  success:(void (^)(NSDictionary *info))success
                    faile:(void (^)(NSError *error))failure;


/**
 第三方登陆新工人注册

 @param dic
 qqId     第三方QQID
 weixinId    第三方微信ID
 userPhone    手机号
 userPassword      密码
 usercode    验证码
 userDcode     邀请码
 name    真实姓名
 year    年龄
 servetype     服务类型
 idCardInfo     身份证照片
 idCardBack     身份证照片背面
 idCard   身份证号
 brithday     生日
 nickname     昵称
 headpic     图片路径
 @param success success description
 @param failure failure description
 */
+ (void)thirdWorkerRegister:(NSDictionary *)dic
                    success:(void (^)(NSDictionary *info))success
                      faile:(void (^)(NSError *error))failure;
/**
合作加盟
 
 @param dic
 userId    用户ID
 name   真实名
 idCard   身份证号码
 idCardInfo  身份证照片路径
 idCardBack    身份证背面照片路径
 servetype   服务类型
 brithday    生日
 @param success ;
 @param failure ;
 */
+ (void)userLeague:(NSDictionary *)dic
           success:(void (^)(NSDictionary *info))success
             faile:(void (^)(NSError *error))failure;
/**
 登录
 
 @param dic
 userPhone      手机号
 userPassword   密码
 @param success ;
 @param failure ;
 */
+ (void)userLogin:(NSDictionary *)dic
          success:(void (^)(NSDictionary *info))success
            faile:(void (^)(NSError *error))failure;

/**
 更改用户密码

 @param dic
     userId    用户ID
     userPhone    用户手机号
     userPassword    用户密码
 @param success
    "result": false 修改失败
 @param failure
    error
 */
+ (void)updatePassword:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure;


/**
 个人中心完善用户信息

 @param dic d
     userId   用户ID
     userNickname   用户昵称
     userAddress    用户地址
     userBirthday   用户生日
 @param success
    "result": false时失败
 @param failure
    error;
 */
+ (void)updateShuidianUser:(NSDictionary *)dic
                   success:(void (^)(NSDictionary *info))success
                     faile:(void (^)(NSError *error))failure;

/**
 上传工人身份证照片

 @param dic
     IdCard    身份证照片l
     userId    用户ID
    imageArr
    imageNameArr
    otherDic
 @param success ;
 @param failure ;
 */
+ (void)uploadIdCard:(NSDictionary *)dic
             success:(void (^)(NSDictionary *info))success
               faile:(void (^)(NSError *error))failure;

/**
 头像上传
 
 @param dic
 HeadPic   头像图片
 imageArr
 imageNameArr
 otherDic
 @param success ;
 @param failure ;
 */
+ (void)uploadHeadPic:(NSDictionary *)dic
              success:(void (^)(NSDictionary *info))success
                faile:(void (^)(NSError *error))failure;

/**
 服务列表

 @param dic
 list;
 @param success ;
 @param failure ;
 */
+ (void)getServiceList:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure;

/**
 服务详情
 
 @param dic
 list;
 @param success ;
 @param failure ;
 */
+ (void)getSerivceInfo:(NSDictionary *)dic
               success:(void (^)(NSDictionary *info))success
                 faile:(void (^)(NSError *error))failure;


/**
 首页服务展示接口
 
 @param dic
 list;
 @param success ;
 @param failure ;
 */
+ (void)getTopMainService:(NSDictionary *)dic
                  success:(void (^)(NSDictionary *info))success
                    faile:(void (^)(NSError *error))failure;

/**
 预约服务
 
 @param dic
 list;
 @param success ;
 @param failure ;
 */
+ (void)addOrderService:(NSDictionary *)dic
                success:(void (^)(NSDictionary *info))success
                  faile:(void (^)(NSError *error))failure;


/**
 查询全部服务
 
 @param dic
 servicename    服务名模糊匹配
 @param success ;
 @param failure ;
 */
+ (void)getServiceWithName:(NSDictionary *)dic
                   success:(void (^)(NSDictionary *info))success
                     faile:(void (^)(NSError *error))failure;
@end
