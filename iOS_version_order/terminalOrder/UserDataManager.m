//
//  UserDataManager.m
//  terminalOrder
//
//  Created by ren will on 08/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "UserDataManager.h"

@implementation UserDataManager
@synthesize arrDishListByRestID, arrRestaurantList;

static UserDataManager *instance = nil;

+ (UserDataManager *)getUserDataManagerInstance{
    @synchronized (self) {
        if (instance == nil) {
            instance = [[UserDataManager alloc] init];
            [instance setupInstancefromLocalFile];
        }
    }
    return instance;
}
- (NSString *)getLocalFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"UserDataManager.plist"];
    return path;
}

- (BOOL)isExistLocalFile{
    NSString* pathLocalFile = [self getLocalFilePath];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:pathLocalFile];
}

- (void)initUserDataManager{
    arrRestaurantList = [[NSMutableArray alloc]init];
    arrDishListByRestID = [[NSMutableArray alloc]init];
}
- (void)setupInstancefromLocalFile{
    if([self isExistLocalFile]){
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:[self getLocalFilePath]];
        if(dic != nil){
            arrRestaurantList = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"restaurantlist"]];
            arrDishListByRestID = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"dishlist"]];
        }
    }else{
        [self initUserDataManager];
    }
}
- (void)writeModificationintoLocalFile{
    [self deleteInfoLocalFile];
    NSString *path = [self getLocalFilePath];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:self.arrDishListByRestID forKey:@"dishlist"];
    [dic setValue:self.arrRestaurantList forKey:@"restaurantlist"];
    
    [dic writeToFile:path atomically:YES];
}
- (void)refreshUserDataManagerInstance{
    //save data, and write the data changed into the local file
    if (instance != nil) {
        [instance writeModificationintoLocalFile];
    }
    if ([arrDishListByRestID count] > 0) {
        [arrDishListByRestID removeAllObjects];
    }
    if ([arrRestaurantList count] > 0) {
        [arrRestaurantList removeAllObjects];
    }
    [self setupInstancefromLocalFile];
}
- (void)deleteInfoLocalFile{
    if ([self isExistLocalFile]) {
        NSString *path = [self getLocalFilePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:path error:nil];
    }
}
@end
