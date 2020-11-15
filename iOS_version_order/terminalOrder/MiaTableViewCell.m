//
//  MiaTableViewCell.m
//  terminalOrder
//
//  Created by ren will on 27/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "MiaTableViewCell.h"

@implementation MiaTableViewCell
@synthesize restaurantName;
@synthesize picContent;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
