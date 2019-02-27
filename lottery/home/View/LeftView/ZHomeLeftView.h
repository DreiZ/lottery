//
//  ZHomeLeftView.h
//  lottery
//
//  Created by zzz on 2018/6/29.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZInningModel.h"

@interface ZHomeLeftView : UIView
@property (nonatomic,strong) ZInningModel *inningModel;
@property (strong, nonatomic) void (^nameBeginChange)(NSString *value ,ZInningListModel *listModel);
@property (strong, nonatomic) void (^nameValueChange)(NSString *value ,ZInningListModel *listModel);

@property (strong, nonatomic) void (^valueChange)(NSString *value ,ZInningListModel *listModel);
@property (strong, nonatomic) void (^beginChange)(UITextField *textField ,ZInningListModel *listModel);
@property (strong, nonatomic) void (^endChange)(UITextField *textField ,ZInningListModel *listModel);

- (UITableView *)iTableView;
- (void)refreshData;
- (void)refreshHeadData;
@property (nonatomic,strong) NSArray *topSubTitleArr;
@end
