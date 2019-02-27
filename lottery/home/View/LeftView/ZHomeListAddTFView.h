//
//  ZHomeListAddTFView.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZInningModel.h"

@interface ZHomeListAddTFView : UIView
@property (assign, nonatomic) BOOL isTFEnable;

@property (nonatomic,strong) ZInningListModel *listModel;
@property (assign, nonatomic) BOOL isCustomKeyboard;
@property (strong, nonatomic) void (^valueChange)(NSString *value);
@property (strong, nonatomic) void (^beginChange)(UITextField *textField);
@property (strong, nonatomic) void (^endChange)(UITextField *textField);
@end
