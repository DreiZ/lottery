//
//  ZRightBottomBtnView.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRightBottomBtnView : UIView
@property (nonatomic,strong) void (^bottomBlock)(NSInteger);
@end
