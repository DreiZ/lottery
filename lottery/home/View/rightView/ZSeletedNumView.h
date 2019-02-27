//
//  ZSeletedNumView.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSeletedNumView : UIView
@property (nonatomic,strong) void (^numSeletBlock)(NSInteger);
@end
