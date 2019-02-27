//
//  ZRightHistorySelectView.h
//  lottery
//
//  Created by zzz on 2018/7/1.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZInningModel.h"

@interface ZRightHistorySelectView : UIView
@property (nonatomic,strong) void (^numSeletBlock)(ZInningItem *);
@property (nonatomic,strong) ZHistoryAllList *historyAllList;
@end
