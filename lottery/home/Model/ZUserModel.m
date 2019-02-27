//
//  ZUserModel.m
//  zcfBase
//
//  Created by zzz on 2018/5/8.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import "ZUserModel.h"

@implementation ZUserModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userId = @"";
        self.userNickname = @"";
        self.userPassword = @"";
        self.userPhone = @"";
        self.userPoint = @"";
        self.userVip = @"";
        self.userBalance = @"";
        self.userSservetype = @"";
        self.userState = @"";
        self.userType = @"";
        self.userAddress = @"";
        self.userSecretPhone = @"";
        self.userBirthday = @"";
        self.userHeadpic = @"";
        self.userIdcardback = @"";
        self.userIdcardinfo = @"";
        self.userPhonetype = @"";
        self.userYear = @"";
        self.userQRcode = @"";
    }
    return self;
}

-(void)updateUser:(NSDictionary *)info  {

    if ([self isEnableWith:@"userId" dic:info]) {
        self.userId = info[@"userId"];
    }
    if ([self isEnableWith:@"userQRcode" dic:info]) {
        self.userQRcode = info[@"userQRcode"];
    }
    
    if ([self isEnableWith:@"userNickname" dic:info]) {
        self.userNickname = info[@"userNickname"];
    }
    if ([self isEnableWith:@"userPassword" dic:info]) {
        self.userPassword = info[@"userPassword"];
    }
    if ([self isEnableWith:@"userPhone" dic:info]) {
        self.userPhone = info[@"userPhone"];
    }
    if ([self isEnableWith:@"userPoint" dic:info]) {
        self.userPoint = info[@"userPoint"];
    }
    if ([self isEnableWith:@"userVip" dic:info]) {
        self.userVip = info[@"userVip"];
    }
    
    if ([self isEnableWith:@"userBalance" dic:info]) {
        self.userBalance = info[@"userBalance"];
    }
    if ([self isEnableWith:@"userSservetype" dic:info]) {
        self.userSservetype = info[@"userSservetype"];
    }
    if ([self isEnableWith:@"userState" dic:info]) {
        self.userState = info[@"userState"];
    }
    if ([self isEnableWith:@"userType" dic:info]) {
        self.userType = info[@"userType"];
    }
    if ([self isEnableWith:@"userAddress" dic:info]) {
        self.userAddress = info[@"userAddress"];
    }
    if ([self isEnableWith:@"userBirthday" dic:info]) {
        self.userBirthday = info[@"userBirthday"];
    }

    if ([self isEnableWith:@"userHeadpic" dic:info]) {
        self.userHeadpic = info[@"userHeadpic"];
    }
    
    if ([self isEnableWith:@"userIdcardback" dic:info]) {
        self.userIdcardback = info[@"userIdcardback"];
    }
  
    if ([self isEnableWith:@"userIdcardinfo" dic:info]) {
        self.userIdcardinfo = info[@"userIdcardinfo"];
    }
    
    if ([self isEnableWith:@"userPhonetype" dic:info]) {
        self.userPhonetype = info[@"userPhonetype"];
    }
    if ([self isEnableWith:@"userYear" dic:info]) {
        self.userYear = info[@"userYear"];
    }
}

- (void)setUserPhone:(NSString *)userPhone {
    _userPhone = userPhone;
    if (_userPhone && _userPhone.length == 11) {
        _userSecretPhone = [NSString stringWithFormat:@"%@****%@",[_userPhone substringWithRange:NSMakeRange(0, 3)] ,[_userPhone substringWithRange:NSMakeRange(_userPhone.length - 3, 3)]];
    }
}

- (BOOL)isEnableWith:(NSString *)key dic:(NSDictionary *)info {
    if ([info objectForKey:key] && ![info[key] isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    
    return NO;
}
@end
