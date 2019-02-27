//
//  ZInningModel.m
//  lottery
//
//  Created by zzz on 2018/7/1.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZInningModel.h"

@implementation ZInningListModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _listSort = @"";
        _listName = @"";
        _listInput = @[@""].mutableCopy;
        _listInputResult = @[@""].mutableCopy;
        _listOpenResult = @"";
        _listThisResult = @"";
        _listLastResult = @"";
        _listAllResult = @"";
    }
    return self;
}
@end


@implementation ZInningModel
- (instancetype)init {
    self = [super init];
    if (self) {
        _sort = @"";
        _multiplying = @"";
        _multiplyingTure = @"";
        _inputAmout = @"";
        _amount = @"";
        _lastAmount = @"";
        _allAmount = @"";
        _addAmount = @"";
        _subAmount = @"";
        _winNum = @"";
        
        _inninglist = @[].mutableCopy;
    }
    return self;
}

- (void)clearAll {
    _addAmount = @"";
    _winNum = @"";
    _inputAmout = @"";
    _amount = @"";
    

    _allAmount = _lastAmount;
//    _lastAmount = @"";
    _subAmount = @"";

    
    for (ZInningListModel *listModel in _inninglist) {
//        listModel.listName = @"";
        listModel.listInput = @[@""].mutableCopy;
        listModel.listOpenResult = @"";
        listModel.listThisResult = @"";
//        listModel.listLastResult = @"";
        listModel.listAllResult = @"";
        listModel.listInputResult = @[@""].mutableCopy;
//        listModel.listOpenResult = @"";
//        listModel.listThisResult = @"";
        listModel.listAllResult = listModel.listLastResult;
//        listModel.listLastResult = @"";
    }
}
@end



@implementation ZInningItem
- (instancetype)init {
    self = [super init];
    if (self) {
        _inningSort = @"";
        _itemModel = [[ZInningModel alloc] init];
    }
    return self;
}
@end

@implementation ZSceneItem
- (instancetype)init {
    self = [super init];
    if (self) {
        _sceneSort = @"";
        _multiplying = @"";
        _sceneLists = @[];
    }
    return self;
}
@end

@implementation ZHistoryAllList

@end
