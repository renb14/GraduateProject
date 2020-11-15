//
//  UserConfigurationData.m
//  terminalOrder
//
//  Created by ren will on 20/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "UserConfigurationData.h"
#import <UIKit/UIKit.h>

@implementation UserConfigurationData
@synthesize deviceID, eMail, historyID, arrTags, userName, bFirst, city, nation, state;
@synthesize bOrderModel;

static UserConfigurationData *instance = nil;

+ (UserConfigurationData *)getSingletonInstance{
    @synchronized (self)
    {
        if (instance == nil)
        {
            instance = [[UserConfigurationData alloc] init];
            [instance getInfofromLocalFile];
        }
    }
    return instance;
}

- (void)initUserConfigurationData{
    deviceID = [[UIDevice currentDevice]identifierForVendor].UUIDString;
    eMail = @"";
    historyID = @"";
    userName = @"";
    city = @"";
    nation = @"";
    state = @"";
    if (arrTags == nil) {
        arrTags = [[NSMutableArray alloc] initWithCapacity:4];
    }else
        [arrTags removeAllObjects];
    
    bOrderModel = NO;
}

- (NSString *)getLocalFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"UserConfigurationData.plist"];
    return path;
}

- (BOOL)isExistLocalFile{
    NSString* pathLocalFile = [self getLocalFilePath];
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:pathLocalFile];
}

- (void)getInfofromLocalFile{
    if([self isExistLocalFile]){
        bFirst = false;
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:[self getLocalFilePath]];
        if(dic != nil){
            deviceID = [dic valueForKey:@"deviceID"];
            eMail = [dic valueForKey:@"eMail"];
            userName = [dic valueForKey:@"userName"];
            historyID = [dic valueForKey:@"historyID"];
            arrTags = [dic objectForKey:@"tags"];
            state = [dic objectForKey:@"state"];
            nation = [dic objectForKey:@"nation"];
            city = [dic objectForKey:@"city"];
        }
    }else{
        bFirst = true;
        [self initUserConfigurationData];
    }
}

- (void)writeModificationintoLocalFile{
    if ([self isExistLocalFile]) {
        [self deleteInfoLocalFile];
    }
    NSString *path = [self getLocalFilePath];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setValue:self.deviceID forKey:@"deviceID"];
    [dic setValue:self.eMail forKey:@"eMail"];
    [dic setValue:self.historyID forKey:@"historyID"];
    [dic setValue:self.userName forKey:@"userName"];
    [dic setObject:self.arrTags forKey:@"tags"];
    [dic setObject:self.city forKey:@"city"];
    [dic setObject:self.state forKey:@"state"];
    [dic setObject:self.nation forKey:@"nation"];
    
    [dic writeToFile:path atomically:YES];
}

- (void)deleteInfoLocalFile{
    if ([self isExistLocalFile]) {
        NSString *path = [self getLocalFilePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:path error:nil];
    }
}
@end
