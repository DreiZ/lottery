//
//  ZBaseViewController.h
//  lottery
//
//  Created by zzz on 2018/6/26.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "NSObject+Hint.h"



@interface ZBaseViewController : UIViewController
//是否是横屏
@property (nonatomic,assign) BOOL isHorizontal;
- (void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal;
@end
