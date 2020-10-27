//
//  DBManager.h
//  terminalOrder
//
//  Created by ren will on 31/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject


+ (DBManager *)getDBManagerInstance;

- (Boolean)insertArray:(NSArray *)arrInfo IntoTable:(NSString *)strTable;

- (Boolean)insertArray:(NSArray *)arrInfo   IntoTable:(NSString *)tableName WithPrimaryKey:(NSString *)primaryKey;

- (NSArray *)executeQuery:(NSString *)query;

@end
