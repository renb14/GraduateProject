//
//  ShowRestaurantTableViewCell.m
//  terminalOrder
//
//  Created by ren will on 05/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "ShowRestaurantTableViewCell.h"

@implementation ShowRestaurantTableViewCell
@synthesize imgViewType;
@synthesize restName;
@synthesize restPhone, restAddr;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
