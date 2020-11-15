//
//  ShowRestaurantTableViewCell.h
//  terminalOrder
//
//  Created by ren will on 05/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowRestaurantTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewType;
@property (weak, nonatomic) IBOutlet UILabel *restName;
@property (weak, nonatomic) IBOutlet UILabel *restPhone;
@property (weak, nonatomic) IBOutlet UILabel *restAddr;

@end
