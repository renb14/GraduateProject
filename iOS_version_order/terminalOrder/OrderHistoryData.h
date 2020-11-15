//
//  OrderHistoryData.h
//  terminalOrder
//
//  Created by ren will on 16/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderHistoryData : NSObject
@property(nonatomic, copy) NSMutableArray *orderHistoryList;
@property(nonatomic, copy) NSMutableDictionary *curOrdrtDic;

+ (OrderHistoryData *)getOrderHistoryDataInstance;
- (void)writeModificationintoLocalFile;
- (void)deleteInfoLocalFile;
@end
