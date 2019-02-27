//
//  DataWorkManager.m
//  matsa
//
//  Created by  netimp on 15/2/26.
//  Copyright (c) 2015年 zhongwu. All rights reserved.
//

#import "DataWorkManager.h"
#import "ZBaseModel.h"
#import "LKModels.h"
#import "LKDBHelper.h"
static DataWorkManager *shareDataWorkManager = NULL;


@interface DataWorkManager()
@property (nonatomic,strong) LKDBHelper *globalHelper;
@end;

@implementation DataWorkManager
@synthesize globalHelper;
+(DataWorkManager*)shareInstance
{
    @synchronized(self)
    {
        if (shareDataWorkManager ==NULL)
        {
            shareDataWorkManager =[[DataWorkManager alloc] init];
        }
    }
    
    return shareDataWorkManager;
}
-(instancetype)init
{
    self = [super init];
    if (self) {
        [self createDB];
    }
    return self;
}
-(void)createDB
{
    globalHelper = [self getUsingLKDBHelper];
}

-(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/shuidian365.db"];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
    });
    return db;
}

-(BOOL)insertOrUpdateModel:(NSObject *)modelData
{
    if (modelData.rowid) {
        return [globalHelper updateToDB:modelData where:nil];
    }
    else
    {
        return [globalHelper insertToDB:modelData];
        
    }
}

-(BOOL)addOrUpdateModel:(ZBaseModel *)modelData{
    ZBaseModel *dbModelData = [self getDBModelData:[modelData class]];
    if (dbModelData) {
        modelData.rowid = dbModelData.rowid;
       return [globalHelper updateToDB:modelData where:nil];
    }
    else
    {
        return [globalHelper insertToDB:modelData];
        
    }
}

-(void)addOrUpdateModelBlcok:(ZBaseModel *)modelData
                    callback:(void (^)(BOOL))block
{
    
    ZBaseModel *dbModelData = [self getDBModelData:[modelData class]];
    if (dbModelData) {
        modelData.rowid = dbModelData.rowid;
        [globalHelper updateToDB:modelData where:nil callback:block];
    }
    else
    {
        [globalHelper insertToDB:modelData
                        callback:block];
        
    }
}

-(BOOL)insertModel:(ZBaseModel *)modelData
{
    return [globalHelper insertToDB:modelData];
}

-(BOOL)deleteModel:(ZBaseModel *)modelData
{
    return [globalHelper deleteToDB:modelData];
}

-(id)getDBModelData:(Class)modelClass
{
    NSArray *userArr = [globalHelper search:modelClass where:nil orderBy:nil offset:0 count:1];
    if ([userArr count]>0) {
        ZBaseModel *dbmodelData = userArr[0];
        return dbmodelData;
    }
    return nil;
}


-(NSArray *)getDBModelArr:(Class)modelClass
{
    NSArray *userArr = [globalHelper search:modelClass where:nil orderBy:nil offset:0 count:10000];
    if ([userArr count]>0) {
        return userArr;
    }
    return nil;
}

-(NSArray *)getDBModelArr:(Class)modelClass offset:(NSInteger)offset count:(NSInteger)count

{
    NSArray *userArr = [globalHelper search:modelClass where:nil orderBy:[NSString stringWithFormat:@"rowid desc"] offset:offset count:count];
//    NSArray *userArr = [self getDBModelArr:modelClass offset:offset count:count orderBy:[NSString stringWithFormat:@"rowid desc"]];
//    NSArray *userArr = [self getDBModelArr:modelClass offset:offset count:count orderBy:[NSString stringWithFormat:@"rowid asc"]];
    if ([userArr count]>0) {
        return userArr;
    }
    return nil;
}

-(NSArray *)getDBModelArr:(Class)modelClass
                   offset:(NSInteger)offset
                    count:(NSInteger)count
                  orderBy:(NSString *)orderByStr

{
    NSArray *userArr = [globalHelper search:modelClass where:nil orderBy:orderByStr offset:offset count:count];
    if ([userArr count]>0) {
        return userArr;
    }
    return nil;
}


-(void)clearModel:(Class)modelClass
{
    [globalHelper dropTableWithClass:modelClass];
}

-(void)clearModel:(NSString *)modelClassName withWhere:(NSString *)where
{
    [globalHelper deleteWithTableName:modelClassName where:where];
}


-(void)clearAllData
{
    [globalHelper executeDB:^(FMDatabase* db) {
        FMResultSet* set = [db executeQuery:@"select name from sqlite_master where type='table'"];
        NSMutableArray* dropTables = [NSMutableArray arrayWithCapacity:0];
        
        while ([set next]) {
            [dropTables addObject:[set stringForColumnIndex:0]];
        }
        
        [set close];
        
        for (NSString* tableName in dropTables) {
            if ([tableName hasPrefix:@"sqlite_"] == NO && ![tableName isEqualToString:@"HNMainUserModel"]) {
                NSString* dropTable = [NSString stringWithFormat:@"drop table %@", tableName];
                [db executeUpdate:dropTable];
                [self->globalHelper dropTableWithTableName:tableName];
            }
        }
        
     }];
    //清除增票资质信息
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"vatModel.plist"];
    [fileManager removeItemAtPath:filePath error:nil];
//    [globalHelper dropAllTable];
}



-(NSArray*)searchModel:(Class)baseModelClass
                 where:(NSString *)sqlStr
{
    NSArray *searchArr = [globalHelper search:baseModelClass where:sqlStr orderBy:nil offset:0 count:1];
    return searchArr;
}
//
//#pragma mark 浏览历史
//-(BOOL)insertHistoryGood:(NSString *)goodId
//{
//    HNGoodHistoryModel *goodsHistory = [self getGoodsHistory:goodId];
//    if(goodsHistory)
//    {
////        [self clearModel:[HNGoodModel className] withWhere:[NSString stringWithFormat:@"goodId = %@",goodsHistory.goodId]];
////        [goodsHistory deleteToDB];
//        [globalHelper deleteToDB:goodsHistory];
//    }
//    
//    NSArray *maxGoodArr =  [self getDBModelArr:[HNGoodHistoryModel class] offset:50 count:10];
//    if(maxGoodArr && maxGoodArr.count>0)
//    {
//        [maxGoodArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj deleteToDB];
//        }];
//    }
//    
//    HNGoodHistoryModel *goodModel = [[HNGoodHistoryModel alloc] init];
//    goodModel.goodId = goodId;
//    return [globalHelper insertToDB:goodModel];
//
//}
//- (BOOL)insertHistoryGoodCat:(NSString *)catId{
//    HNGoodCatHistoryModel *goodsHistory = [self getGoodsCatHistory:catId];
//    if(goodsHistory)
//    {
//        //        [self clearModel:[HNGoodModel className] withWhere:[NSString stringWithFormat:@"goodId = %@",goodsHistory.goodId]];
//        //        [goodsHistory deleteToDB];
//        [globalHelper deleteToDB:goodsHistory];
//    }
//    
//    NSArray *maxGoodArr =  [self getDBModelArr:[HNGoodCatHistoryModel class] offset:50 count:10];
//    if(maxGoodArr && maxGoodArr.count>0)
//    {
//        [maxGoodArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj deleteToDB];
//        }];
//    }
//    
//    HNGoodCatHistoryModel *goodModel = [[HNGoodCatHistoryModel alloc] init];
//    goodModel.catId = catId;
//    return [globalHelper insertToDB:goodModel];
//}
//-(HNGoodHistoryModel*)getGoodsHistory:(NSString *)goodId
//{
//    NSArray *goodsHistoryArr = [globalHelper search:[HNGoodHistoryModel class] where:[NSString stringWithFormat:@"goodId = %@",goodId] orderBy:nil offset:0 count:1];
//    if ([goodsHistoryArr count]>0) {
//        HNGoodHistoryModel *goodModel = [goodsHistoryArr objectAtIndex:0];
//        return goodModel;
//    }
//    return nil;
//}
//
//
//-(HNGoodCatHistoryModel*)getGoodsCatHistory:(NSString *)catId
//{
//    NSArray *goodsHistoryArr = [globalHelper search:[HNGoodCatHistoryModel class] where:[NSString stringWithFormat:@"catId = %@",catId] orderBy:nil offset:0 count:1];
//    if ([goodsHistoryArr count]>0) {
//        HNGoodCatHistoryModel *goodModel = [goodsHistoryArr objectAtIndex:0];
//        return goodModel;
//    }
//    return nil;
//}
//#pragma mark 扫描历史
//-(BOOL)insertSweepHistoryGood:(NSString *)goodId
//{
//    HNGoodSweepModel *goodsHistory = [self getGoodsSweepHistory:goodId];
//    if(goodsHistory)
//    {
//        //        [self clearModel:[HNGoodModel className] withWhere:[NSString stringWithFormat:@"goodId = %@",goodsHistory.goodId]];
//        //        [goodsHistory deleteToDB];
//        [globalHelper deleteToDB:goodsHistory];
//    }
//    
//    NSArray *maxGoodArr =  [self getDBModelArr:[HNGoodSweepModel class] offset:50 count:10];
//    if(maxGoodArr && maxGoodArr.count>0)
//    {
//        [maxGoodArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj deleteToDB];
//        }];
//    }
//    
//    HNGoodSweepModel *goodModel = [[HNGoodSweepModel alloc] init];
//    goodModel.goodId = goodId;
//    return [globalHelper insertToDB:goodModel];
//    
//}
//
//-(HNGoodSweepModel*)getGoodsSweepHistory:(NSString *)goodId
//{
//    NSArray *goodsHistoryArr = [globalHelper search:[HNGoodSweepModel class] where:[NSString stringWithFormat:@"goodId = %@",goodId] orderBy:nil offset:0 count:1];
//    if ([goodsHistoryArr count]>0) {
//        HNGoodSweepModel *goodModel = [goodsHistoryArr objectAtIndex:0];
//        return goodModel;
//    }
//    return nil;
//}
//
//

@end
