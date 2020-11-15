//
//  UserDataManager.h
//  terminalOrder
//
//  Created by ren will on 08/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataManager : NSObject
@property (nonatomic, copy) NSMutableArray *arrDishListByRestID;
@property (nonatomic, copy) NSMutableArray *arrRestaurantList;

+ (UserDataManager *)getUserDataManagerInstance;
- (void)writeModificationintoLocalFile;
- (void)refreshUserDataManagerInstance;
- (void)deleteInfoLocalFile;
@end
