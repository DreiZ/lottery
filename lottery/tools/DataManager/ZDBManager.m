//
//  ZDBManager.m
//  ZBigHealth
//
//  Created by 承希-开发 on 2018/10/16.
//  Copyright © 2018年 承希-开发. All rights reserved.
//

#import "ZDBManager.h"

static ZDBManager *manager;

@implementation ZDBManager

+ (ZDBManager *)sharedInstance
{
    if (manager == nil) {
        static dispatch_once_t once;

        dispatch_once(&once, ^{
            manager = [[ZDBManager alloc] init];
        });
    }

    return manager;
}

- (void)loginout {
    manager = nil;
}

- (id)init
{
    if (self = [super init]) {
        NSString *commonQueuePath = [self pathDBCommon];
        self.commonQueue = [FMDatabaseQueue databaseQueueWithPath:commonQueuePath];
    }
    return self;
}

- (NSString *)pathDBCommon
{
    NSString *path = [NSString stringWithFormat:@"/"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"File Create Failed: %@", path);
        }
    }
    
    return [path stringByAppendingString:@"common.sqlite3"];
}
@end
