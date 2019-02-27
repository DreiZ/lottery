//
//  DataWorkManager.h
//  matsa
//
//  Created by  netimp on 15/2/26.
//  Copyright (c) 2015年 zhongwu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZBaseModel;
@interface DataWorkManager : NSObject

+(DataWorkManager *) shareInstance;
-(BOOL)insertOrUpdateModel:(NSObject *)modelData;
-(BOOL)addOrUpdateModel:(ZBaseModel *)modelData;
-(void)addOrUpdateModelBlcok:(ZBaseModel *)modelData
                    callback:(void (^)(BOOL))block;
-(BOOL)insertModel:(ZBaseModel *)modelData;
-(BOOL)deleteModel:(ZBaseModel *)modelData;


-(NSArray*)searchModel:(Class)baseModelClass
                 where:(NSString *)sqlStr;

-(id)getDBModelData:(Class)modelClass;
-(NSArray *)getDBModelArr:(Class)modelClass;
-(NSArray *)getDBModelArr:(Class)modelClass offset:(NSInteger)offset count:(NSInteger)count;
-(NSArray *)getDBModelArr:(Class)modelClass
                   offset:(NSInteger)offset
                    count:(NSInteger)count
                  orderBy:(NSString *)orderByStr;
-(void)clearModel:(Class)modelClass;
-(void)clearAllData;
@end
