//
//  ZDBManager.h
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/16.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>


@interface ZDBManager : NSObject

/**
 *  DB队列（除IM相关）
 */
@property (nonatomic, strong) FMDatabaseQueue *commonQueue;


+ (ZDBManager *)sharedInstance;
@end

