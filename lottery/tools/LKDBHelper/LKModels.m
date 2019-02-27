//
//  LKModels.m
//  House
//
//  Created by apple on 14-7-16.
//  Copyright (c) 2014年 LuckyTown. All rights reserved.
//

#import "LKModels.h"
#import "LKDBHelper.h"
#define DOCUMENT [NSHomeDirectory()stringByAppendingPathComponent:@"Documents/"]
@implementation Member
    //在类 初始化的时候
+(void)initialize
{
        //remove unwant property
        //比如 getTableMapping 返回nil 的时候   会取全部属性  这时候 就可以 用这个方法  移除掉 不要的属性
    [self removePropertyWithColumnName:@"error"];
    
    
        //enable the column binding property name
//    [self setTableColumnName:@"pwd" bindingPropertyName:@"password"];
    
}

    //重载可以选择 使用的LKDBHelper
+(LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString* dbpath = [self changeDataName];
        db = [[LKDBHelper alloc]initWithDBPath:dbpath];
    });
    return db;
}
//修改老版本的数据库名称
+(NSString *)changeDataName
{
//    NSError *error;
    //NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/matsa.db"];
    NSString *dbNewPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/hnt.db"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:dbpath]) {
//        if ([fileManager moveItemAtPath:dbpath toPath:dbNewPath error:&error]) {
//            return dbNewPath;
//        }
//        else
//        {
//             NSLog(@"Unable to move file: %@", [error localizedDescription]);
//            return dbpath;
//           
//        }
//    }
//    else
//    {
        return dbNewPath;
//    }
}
    // 将要插入数据库
+(BOOL)dbWillInsert:(NSObject *)entity
{
    LKErrorLog(@"will insert : %@",NSStringFromClass(self));
    return YES;
}
    //已经插入数据库
+(void)dbDidInserted:(NSObject *)entity result:(BOOL)result
{
    LKErrorLog(@"did insert : %@",NSStringFromClass(self));
}


+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"redLimit" : @"limit"};
}

@end

@implementation Slide
+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}


+(LKDBHelper *)getUsingLKDBHelper
{
    return [Member getUsingLKDBHelper];
}

@end

@implementation Search
+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}


+(LKDBHelper *)getUsingLKDBHelper
{
    return [Member getUsingLKDBHelper];
}

@end



@implementation GoodsHistory

+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}


+(LKDBHelper *)getUsingLKDBHelper
{
    return [Member getUsingLKDBHelper];
}

@end

@implementation Event
+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}

+(LKDBHelper *)getUsingLKDBHelper
{
    return [Member getUsingLKDBHelper];
}

@end

@implementation Page
+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
//    [self setTableColumnName:@"upTime" bindingPropertyName:@"updateTime"];
}

+(LKDBHelper *)getUsingLKDBHelper
{
    return [Member getUsingLKDBHelper];
}

@end


@implementation Tag
+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}

+(LKDBHelper *)getUsingLKDBHelper
{
    return [Member getUsingLKDBHelper];
}

@end


@implementation Article
+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}

+(LKDBHelper *)getUsingLKDBHelper
{
    return [Member getUsingLKDBHelper];
}

@end


@implementation Story
+(void)initialize
{
    [self removePropertyWithColumnName:@"error"];
}

+(LKDBHelper *)getUsingLKDBHelper
{
    return [Member getUsingLKDBHelper];
}

@end

@implementation NSObject(PrintSQL)

+(NSString *)getCreateTableSQL
{
    LKModelInfos* infos = [self getModelInfos];
    NSString* primaryKey = [self getPrimaryKey];
    NSMutableString* table_pars = [NSMutableString string];
    for (int i=0; i<infos.count; i++) {
        
        if(i > 0)
            [table_pars appendString:@","];
        
        LKDBProperty* property =  [infos objectWithIndex:i];
        [self columnAttributeWithProperty:property];
        
        [table_pars appendFormat:@"%@ %@",property.sqlColumnName,property.sqlColumnType];
        
        if([property.sqlColumnType isEqualToString:LKSQL_Type_Text])
            {
            if(property.length>0)
                {
                [table_pars appendFormat:@"(%d)",property.length];
                }
            }
        if(property.isNotNull)
            {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_NotNull];
            }
        if(property.isUnique)
            {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_Unique];
            }
        if(property.checkValue)
            {
            [table_pars appendFormat:@" %@(%@)",LKSQL_Attribute_Check,property.checkValue];
            }
        if(property.defaultValue)
            {
            [table_pars appendFormat:@" %@ %@",LKSQL_Attribute_Default,property.defaultValue];
            }
        if(primaryKey && [property.sqlColumnName isEqualToString:primaryKey])
            {
            [table_pars appendFormat:@" %@",LKSQL_Attribute_PrimaryKey];
            }
    }
    NSString* createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",[self getTableName],table_pars];
    return createTableSQL;
}

@end
