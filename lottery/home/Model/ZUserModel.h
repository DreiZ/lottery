//
//  ZUserModel.h
//  zcfBase
//
//  Created by zzz on 2018/5/8.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZUserModel : NSObject
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userQRcode;
@property (nonatomic,strong) NSString *userNickname;
@property (nonatomic,strong) NSString *userPassword;
@property (nonatomic,strong) NSString *userPhone;
@property (nonatomic,strong) NSString *userPoint;
@property (nonatomic,strong) NSString *userVip;
@property (nonatomic,strong) NSString *userBalance;
@property (nonatomic,strong) NSString *userSservetype;
@property (nonatomic,strong) NSString *userState;
@property (nonatomic,strong) NSString *userType;
@property (nonatomic,strong) NSString *userAddress;
@property (nonatomic,strong) NSString *userSecretPhone;
@property (nonatomic,strong) NSString *userBirthday;
@property (nonatomic,strong) NSString *userHeadpic;
@property (nonatomic,strong) NSString *userIdcardback;
@property (nonatomic,strong) NSString *userIdcardinfo;
@property (nonatomic,strong) NSString *userPhonetype;
@property (nonatomic,strong) NSString *userYear;

-(void)updateUser:(NSDictionary *)info;
@end
