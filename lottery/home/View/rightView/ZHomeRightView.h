//
//  ZHomeRightView.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZInningModel.h"

@interface ZHomeRightView : UIView
@property (nonatomic,strong) ZInningModel *inningModel;
@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) ZInningListModel *inningListModel;
//最顶部按钮
@property (nonatomic,strong) void (^topBlock)(NSInteger);
//最底部按钮
@property (nonatomic,strong) void (^bottomBlock)(NSInteger);
//开筒
@property (nonatomic,strong) void (^openBlock)(void);
//加注
@property (nonatomic,strong) void (^addBlock)(void);

@property (nonatomic,strong) void (^cleanHistoryBlock)(void);

- (void)setTopTitle:(NSString *)title value:(NSString *)value;
- (void)setOpenNum:(NSString *)num;
- (void)setSortNum:(NSString *)num;
@end
