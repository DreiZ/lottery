//
//  ZRightOpenView.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRightOpenView : UIView
//开筒
@property (nonatomic,strong) void (^openBlock)(void);
@property (nonatomic,strong) NSString *num;

- (void)setOpenNum:(NSString *)num;
@end
