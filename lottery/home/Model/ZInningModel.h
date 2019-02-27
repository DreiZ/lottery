//
//  ZInningModel.h
//  lottery
//
//  Created by zzz on 2018/7/1.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseModel.h"

@interface ZInningListModel : ZBaseModel
@property (nonatomic,strong) NSString *listSort;
@property (nonatomic,strong) NSString *listName;
@property (nonatomic,strong) NSMutableArray <NSString *>*listInput;
@property (nonatomic,strong) NSMutableArray <NSString *>*listInputResult;
@property (nonatomic,strong) NSArray <NSString *>*listInputH;
@property (nonatomic,strong) NSArray <NSString *>*listInputResultH;
//开奖数字
@property (nonatomic,strong) NSString *listOpenResult;
//本次结果
@property (nonatomic,strong) NSString *listThisResult;
//上次结果
@property (nonatomic,strong) NSString *listLastResult;
//总结果
@property (nonatomic,strong) NSString *listAllResult;
@end

@interface ZInningModel : ZBaseModel
//是否为b
@property (nonatomic, assign) BOOL isEnable;
//序列
@property (nonatomic, strong) NSString *sort;
//初始倍率
@property (nonatomic, strong) NSString *multiplying;
//初始倍率
@property (nonatomic, strong) NSString *multiplyingTure;
//开通数字
@property (nonatomic, strong) NSString *winNum;
//投入总数
@property (nonatomic, strong) NSString *inputAmout;
//本次总额
@property (nonatomic, strong) NSString *amount;
//上次总额
@property (nonatomic, strong) NSString *lastAmount;
//所有总额
@property (nonatomic, strong) NSString *allAmount;
@property (nonatomic, strong) NSString *addAmount;
@property (nonatomic, strong) NSString *subAmount;

@property (nonatomic,strong) NSMutableArray <ZInningListModel *> *inninglist;
//清空所有
- (void)clearAll;
@end


@interface ZInningItem : ZBaseModel
//筒次
@property(nonatomic, strong) NSString *sceneSort;
@property(nonatomic, strong) NSString *inningSort;
@property(nonatomic, strong) NSString *winNum;
@property(nonatomic, strong) ZInningModel *itemModel;
@end

@interface ZSceneItem : ZBaseModel
//场次
@property(nonatomic, strong) NSString *sceneSort;
@property(nonatomic, strong) NSString *multiplying;
@property(nonatomic, strong) NSArray <ZInningItem *> *sceneLists;
@end

@interface ZHistoryAllList : ZBaseModel
@property(nonatomic, strong) NSArray <ZSceneItem *> *allHisoryLists;
@end
