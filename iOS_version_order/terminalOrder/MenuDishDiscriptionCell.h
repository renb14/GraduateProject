//
//  MenuDishDiscriptionCell.h
//  terminalOrder
//
//  Created by ren will on 13/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuDishDiscriptionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *nLike;

@property (weak, nonatomic) IBOutlet UILabel *nLblDislike;
@end
