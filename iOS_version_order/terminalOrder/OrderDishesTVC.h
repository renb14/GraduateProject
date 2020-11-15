//
//  OrderDishesTVC.h
//  terminalOrder
//
//  Created by ren will on 06/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDishesTVC : UITableViewController
@property (nonatomic, strong) NSString *restID;
// array of DishIDs
@property (nonatomic, copy) NSMutableArray *selectedDishesList;
@property (nonatomic, strong) NSString *restName;
@property (nonatomic, strong) NSString *introduction;
@end
