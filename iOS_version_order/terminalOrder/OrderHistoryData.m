//
//  OrderHistoryData.m
//  terminalOrder
//
//  Created by ren will on 16/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "OrderHistoryData.h"

@implementation OrderHistoryData
@synthesize orderHistoryList;
@synthesize curOrdrtDic;

static OrderHistoryData *instance = nil;

+ (OrderHistoryData *)getOrderHistoryDataInstance{
    @synchronized (self) {
        if (instance == nil) {
            instance = [[OrderHistoryData alloc] init];
            [instance setupInstancefromLocalFile];
        }
    }
    return instance;
}
- (NSString *)getLocalFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"OrderHistoryData.plist"];
    return path;
}

- (BOOL)isExistLocalFile{
    NSString* pathLocalFile = [self getLocalFilePath];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:pathLocalFile];
}

- (void)initUserDataManager{
    orderHistoryList = [[NSMutableArray alloc]init];
    curOrdrtDic = [[NSMutableDictionary alloc]init];
}
- (void)setupInstancefromLocalFile{
    if([self isExistLocalFile]){
        NSArray *tmp = [[NSArray alloc] initWithContentsOfFile:[self getLocalFilePath]];
        if(tmp != nil && [tmp count ] > 0){
            orderHistoryList = [[NSMutableArray alloc]initWithArray:tmp];
        }else
            orderHistoryList = [[NSMutableArray alloc] init];
        curOrdrtDic = [[NSMutableDictionary alloc] init];
    }else{
        [self initUserDataManager];
    }
}
- (void)writeModificationintoLocalFile{
    [self deleteInfoLocalFile];
    if (curOrdrtDic != nil && [curOrdrtDic count] > 0) {
        [orderHistoryList addObject:curOrdrtDic];
        [curOrdrtDic removeAllObjects];
    }
    NSString *path = [self getLocalFilePath];
    [orderHistoryList writeToFile:path atomically:YES];
}

- (void)deleteInfoLocalFile{
    if ([self isExistLocalFile]) {
        NSString *path = [self getLocalFilePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:path error:nil];
    }
}

@end
