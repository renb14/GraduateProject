//
//  UserConfigurationData.h
//  terminalOrder
//
//  Created by ren will on 20/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserConfigurationData : NSObject
//unique number which is used to identify user in Database
@property (nonatomic, strong) NSString *deviceID;
//
@property (nonatomic, strong) NSString *eMail;
//not consider to how to use this variable
@property (nonatomic, strong) NSString *historyID;
@property (nonatomic, strong) NSString *userName;
// indicate that favorite style of users
@property (nonatomic, copy) NSMutableArray *arrTags;
//check out whether or not it is the first time to use this app
@property (nonatomic, assign) BOOL bFirst;

@property (nonatomic, strong) NSString *nation;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) BOOL bOrderModel;


//get singleton
+ (UserConfigurationData *)getSingletonInstance;
//check on whether or not the local file is existed
- (BOOL)isExistLocalFile;
//put the local file into memory(UserConfigurationData instance)
- (void)getInfofromLocalFile;
//save the modificions into local file
- (void)writeModificationintoLocalFile;
//delete this local file
- (void)deleteInfoLocalFile;
@end
