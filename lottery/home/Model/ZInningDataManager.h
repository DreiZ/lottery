//
//  ZInningDataManager.h
//  lottery
//
//  Created by zzz on 2018/7/2.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZInningModel.h"
@interface ZInningDataManager : NSObject

/**
 计算开通数据 num 输入的公式 Qnum开的数字 Bl为/后面的数字 tsbl为刚开始选择的0.8或0.7

 @param num 输入的公式
 @param Qnum 开的数字
 @param Bl /后面的数字
 @param tsbl 为刚开始选择的0.8或0.7
 @return 一条的结果
 */
+ (NSString *)computeWithNum:(NSString *)num Qnum:(NSString *)Qnum Bl:(NSString *)Bl tsbl:(NSString *)tsbl;

+(void)computeWithInningModel:(ZInningModel *)model;
@end
