//
//  DBManager.m
//  terminalOrder
//
//  Created by ren will on 31/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "DBManager.h"

#define DATABASENAME (@"rest")

static DBManager *instanceDBManager = nil;
static sqlite3 *db = nil;

@implementation DBManager

+ (DBManager *)getDBManagerInstance{
    if (!instanceDBManager) {
        instanceDBManager = [[super alloc] init];
        //[instanceDBManager createDatabase];
    }
    return instanceDBManager;
}

- (NSString *)pathDataBase{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"restaurant.db"];
    return path;
}

- (Boolean)openandCreateDatabaseandTable:(NSString *)tableName WithArrayInfo:(NSArray *)arrInfo WithPrimaryKey:(NSString *)priKey{
    Boolean bResult = NO;
    int nCount = 0;
    char *err;
    const char *dbPath = [[self pathDataBase] UTF8String];
    NSArray *allKeys = [[arrInfo firstObject] allKeys];
        NSMutableString *sqlStatement = [NSMutableString stringWithFormat:@"create table if not exists %@ ( %@ text primary key , ",tableName,priKey];
    
    if (sqlite3_open(dbPath, &db) == SQLITE_OK) {
        for (NSString *dicKey in allKeys) {
            nCount++;
            if ([dicKey isEqualToString:priKey]) {
                continue;
            }
            NSString *type;
            if ([[[arrInfo firstObject] valueForKey:dicKey] isKindOfClass:[NSNumber class]]) {
                NSNumber *tmp = [[arrInfo firstObject] valueForKey:dicKey];
                if (CFNumberIsFloatType((CFNumberRef)tmp))
                    type = @"real";
                else
                    type = @"integer";
            }else if([[[arrInfo firstObject] valueForKey:dicKey] isKindOfClass:[NSString class]]){
                type = @"text";
            }else{
                type = @"blob";
            }
            [sqlStatement appendFormat:@"%@ %@", dicKey,type];
            if (nCount != [allKeys count]) {
                [sqlStatement appendString:@", "];
            }
        }
        [sqlStatement appendFormat:@" )"];
        const char *openTable = [sqlStatement UTF8String];
        if (sqlite3_exec(db, openTable, NULL, NULL, &err) != SQLITE_OK ) {
            sqlite3_close(db);
            bResult = NO;
        }else
            bResult = YES;
    }

    return bResult;
}

//"create table if not exists studentsDetail (regno integer primary key, name text, department text, year text)";
- (Boolean)openDatabaseAndTable:(NSString *)tableName WithArrayInfo:(NSArray *)arrInfo{
    Boolean bResult = NO;
    int nCount = 0;
    char *err;
    const char *dbPath = [[self pathDataBase] UTF8String];
    NSArray *allKeys = [[arrInfo firstObject] allKeys];
    NSMutableString *sqlStatement = [NSMutableString stringWithFormat:@"create table if not exists %@ ( sqlID integer primary key autoincrement, ",tableName];
    if (sqlite3_open(dbPath, &db) == SQLITE_OK) {
        for (NSString *dicKey in allKeys) {
            nCount++;
            NSString *type;
            if ([[[arrInfo firstObject] valueForKey:dicKey] isKindOfClass:[NSNumber class]]) {
                NSNumber *tmp = [[arrInfo firstObject] valueForKey:dicKey];
                if (CFNumberIsFloatType((CFNumberRef)tmp))
                    type = @"real";
                else
                    type = @"integer";
            }else if([[[arrInfo firstObject] valueForKey:dicKey] isKindOfClass:[NSString class]]){
                type = @"text";
            }else{
                type = @"blob";
            }
            [sqlStatement appendFormat:@"%@ %@", dicKey,type];
            if (nCount != [allKeys count]) {
                [sqlStatement appendString:@", "];
            }
        }
        [sqlStatement appendFormat:@" )"];
        const char *openTable = [sqlStatement UTF8String];
        if (sqlite3_exec(db, openTable, NULL, NULL, &err) != SQLITE_OK ) {
            sqlite3_close(db);
            bResult = NO;
        }else
            bResult = YES;
    }
    return bResult;
}
//@"insert into studentsDetail (regno,name, department, year) values ( %d,'%@', '%@', '%@')"
- (Boolean)insertArray:(NSArray *)arrInfo IntoTable:(NSString *)strTable{
    Boolean bResult = NO;
    char *err;
    //open BD and table
    bResult = [self openDatabaseAndTable:strTable WithArrayInfo:arrInfo];
    //for-loop, insert data to db
    if (bResult == YES) {
        for (NSDictionary *dicUnit in arrInfo) {
            int nCount = 0;
            NSMutableString *strSQL = [NSMutableString stringWithFormat:@"insert into %@ ",strTable];
            NSMutableString *strID = [[NSMutableString alloc] initWithString:@" ( "];
            NSMutableString *strValue = [[NSMutableString alloc] initWithString:@" values ( "];
            for (NSString *strKey in [dicUnit allKeys]) {
                nCount++;
                //[strID appendFormat:@"%@",strKey];
                if ([[dicUnit objectForKey:strKey] isKindOfClass:[NSNumber class]]) {
                    NSNumber *tmp = [dicUnit objectForKey:strKey];
                    if (CFNumberIsFloatType((CFNumberRef)tmp))
                        [strValue appendFormat:@"%f", [tmp floatValue]];
                    else
                        [strValue appendFormat:@"%d", [tmp intValue]];
                }else if ([[dicUnit objectForKey:strKey] isKindOfClass:[NSString class]]){
                    [strValue appendFormat:@" '%@'",[dicUnit objectForKey:strKey]];
                }else if ([[dicUnit objectForKey:strKey] isKindOfClass:[NSArray class]]){
                    continue;
                }
                [strID appendFormat:@"%@",strKey];
                if (nCount != [[dicUnit allKeys] count]) {
                    [strValue appendString:@", "];
                    [strID appendString:@", "];
                }else{
                    [strValue appendString:@")"];
                    [strID appendString:@")"];
                }
                
            }
            [strSQL appendFormat:@" %@ %@",strID,strValue];
            if(sqlite3_exec(db, [strSQL UTF8String], NULL, NULL, &err) != SQLITE_OK){
                bResult = NO;
                sqlite3_close(db);
                break;
            }
        }
    }
    if (bResult == YES) {
        sqlite3_close(db);
    }
    return bResult;
}
- (Boolean)insertArray:(NSArray *)arrInfo   IntoTable:(NSString *)tableName WithPrimaryKey:(NSString *)primaryKey{
    Boolean bResult = NO;
    char *err;
    bResult = [self openandCreateDatabaseandTable:tableName WithArrayInfo:arrInfo WithPrimaryKey:primaryKey];
    if (bResult) {
        for (NSDictionary *dicUnit in arrInfo) {
            int nCount = 0;
            NSMutableString *strSQL = [NSMutableString stringWithFormat:@"insert into %@ ",tableName];
            NSMutableString *strID = [[NSMutableString alloc] initWithString:@" ( "];
            NSMutableString *strValue = [[NSMutableString alloc] initWithString:@" values ( "];
            for (NSString *strKey in [dicUnit allKeys]) {
                nCount++;
                //[strID appendFormat:@"%@",strKey];
                if ([[dicUnit objectForKey:strKey] isKindOfClass:[NSNumber class]]) {
                    NSNumber *tmp = [dicUnit objectForKey:strKey];
                    if (CFNumberIsFloatType((CFNumberRef)tmp))
                        [strValue appendFormat:@"%f", [tmp floatValue]];
                    else
                        [strValue appendFormat:@"%d", [tmp intValue]];
                }else if ([[dicUnit objectForKey:strKey] isKindOfClass:[NSString class]]){
                    [strValue appendFormat:@" '%@'",[dicUnit objectForKey:strKey]];
                }else if ([[dicUnit objectForKey:strKey] isKindOfClass:[NSArray class]]){
                    continue;
                }
                [strID appendFormat:@"%@",strKey];
                if (nCount != [[dicUnit allKeys] count]) {
                    [strValue appendString:@", "];
                    [strID appendString:@", "];
                }else{
                    [strValue appendString:@")"];
                    [strID appendString:@")"];
                }
                
            }
            [strSQL appendFormat:@" %@ %@",strID,strValue];
            if(sqlite3_exec(db, [strSQL UTF8String], NULL, NULL, &err) != SQLITE_OK){
                bResult = NO;
                sqlite3_close(db);
                break;
            }
        }
    }
    if (bResult == YES) {
        sqlite3_close(db);
    }
    return bResult;
}
- (NSArray *)executeQuery:(NSString *)query{
    NSMutableArray *mutarrTmp = [[NSMutableArray alloc] init];
    const char *path = [[self pathDataBase] UTF8String];
    sqlite3_stmt *stmt;
    const char *tail;
    if (sqlite3_open(path, &db) == SQLITE_OK) {

        sqlite3_prepare_v2(db, [query UTF8String], -1, &stmt, &tail);
        if (stmt == NULL) {
            return nil;
        }
        
        int status, num_cols,i,type;
        id obj;
        NSString *key;
        NSMutableDictionary *row;
        
        while ((status = sqlite3_step(stmt)) != SQLITE_DONE) {
            if (status != SQLITE_ROW)
                continue;
            
            row = [NSMutableDictionary dictionary];
            num_cols = sqlite3_data_count(stmt);
            for (i = 0; i < num_cols; i++) {
                obj = nil;
                type = sqlite3_column_type(stmt, i);
                switch (type) {
                    case SQLITE_INTEGER:
                        obj = [NSNumber numberWithLongLong:sqlite3_column_int64(stmt, i)];
                        break;
                    case SQLITE_FLOAT:
                        obj = [NSNumber numberWithDouble:sqlite3_column_double(stmt, i)];
                        break;
                    case SQLITE_TEXT:
                        obj = [NSString stringWithUTF8String:sqlite3_column_text(stmt, i)];
                        break;
                    case SQLITE_BLOB:
                        obj = [NSData dataWithBytes:sqlite3_column_blob(stmt, i)
                                             length:sqlite3_column_bytes(stmt, i)];
                        break;
                    case SQLITE_NULL:
                        obj = [NSNull null];
                        break;
                    default:
                        break;
                }
                
                key = [NSString stringWithUTF8String:sqlite3_column_name(stmt, i)];
                [row setObject:obj forKey:key];
            }
            
            [mutarrTmp addObject:row];
        }
        
        sqlite3_finalize(stmt);
    }
    return mutarrTmp;
}

@end
