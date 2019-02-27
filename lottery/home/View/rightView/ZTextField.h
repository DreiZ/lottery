//
//  ZTextField.h
//  lottery
//
//  Created by zzz on 2018/7/6.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZTextFieldDelegate <NSObject>
@optional
- (void)zEditChanage:(id)sender;
@end
@interface ZTextField : UITextField
@property (nonatomic, strong) id<ZTextFieldDelegate> zDelegate;
@end
