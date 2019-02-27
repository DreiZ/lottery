//
//  LKModels.h
//  House
//
//  Created by apple on 14-7-16.
//  Copyright (c) 2014年 LuckyTown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject
@property(copy,nonatomic)NSString* userid;
@property(copy,nonatomic)NSString* username;
//@property(copy,nonatomic)NSString* email;
@property(copy,nonatomic)NSString* password;
@property(copy,nonatomic)NSString* key;

@property(copy,nonatomic)NSString* address;
@property(copy,nonatomic)NSString* uid;
@property(copy,nonatomic)NSString* isfreeze;
@property(copy,nonatomic)NSString* lastlogin;
@property(copy,nonatomic)NSString* phone;
@property(copy,nonatomic)NSString* tel;
@property(copy,nonatomic)NSString* realname;
@property(copy,nonatomic)NSString* balance;
@property(copy,nonatomic)NSString* card;
@property(copy,nonatomic)NSString* score;
@property(copy,nonatomic)NSString* shopping;

@property(copy,nonatomic)NSString* newredpacked;//是否显示红包
@property(copy,nonatomic)NSString* redLimit;//红包金额
//@property BOOL isDeleted;
@property(copy,nonatomic)NSString* updateTime;
@property(copy,nonatomic)NSDictionary *member;
@property(copy,nonatomic)NSString* isMD5;
@end

@interface Slide : NSObject
@property(copy,nonatomic)NSArray* pics;

@end

@interface Search : NSObject
@property(copy,nonatomic)NSArray* hotSearch;
@property(copy,nonatomic)NSArray* nearSearch;
//@property(copy,nonatomic)NSString* event;
//@property(copy,nonatomic)NSString* mediaUrl;
//@property(copy,nonatomic)NSString* sha1;
//@property(copy,nonatomic)NSString* mime;
//@property(copy,nonatomic)NSString* size;
@end



@interface GoodsHistory : NSObject
@property(copy,nonatomic)NSString* goodId;
@end
@interface Event : NSObject
@property (copy,nonatomic)NSString *eventID;
@property (copy,nonatomic)NSString *owner;
@property(copy,nonatomic)NSString* name;
//@property BOOL isDeleted;
@property(copy,nonatomic)NSDate* updateTime;
@end

@interface Page : NSObject
@property (copy,nonatomic)NSString *owner;
@property (copy,nonatomic)NSString *pageID;
@property (copy,nonatomic)NSString *structure;
//@property BOOL isDeleted;
@property(copy,nonatomic)NSDate* updateTime;
@end

@interface Tag : NSObject
@property (copy,nonatomic)NSString *tagID;
@property (copy,nonatomic)NSString *name;
//@property BOOL isPublic;
//@property(copy,nonatomic)NSDate* updateTime;

@end

@interface Article : NSObject
@property (copy,nonatomic)NSString *articleID;
//@property (copy,nonatomic)NSString *owner;
@property (copy,nonatomic)NSString *title;
//@property (copy,nonatomic)NSString *description;
@property (copy,nonatomic)NSString *page;
@property (copy,nonatomic)NSString *tag;
@property (copy,nonatomic)NSString *event;
//@property BOOL isDeleted;
@property(copy,nonatomic)NSDate* updateTime;
@end

@interface Story : NSObject
@property (copy,nonatomic)NSString *storyID;
@property (copy,nonatomic)NSString *owner;
@property (copy,nonatomic)NSString *title;
@property (copy,nonatomic)NSString *article;
@property (copy,nonatomic)NSString *tag;
@property (copy,nonatomic)NSString *readcount;
//@property BOOL isPublic;
@property(copy,nonatomic)NSDate* updateTime;
@end



@interface NSObject(PrintSQL)
+(NSString*)getCreateTableSQL;
@end
