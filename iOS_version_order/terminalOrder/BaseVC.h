//
//  BaseVC.h
//  terminalOrder
//
//  Created by ren will on 21/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisclaimerVC.h"
#import "RelatedDegelate.h"

@interface BaseVC : UITabBarController <RelatedDegelate>

@property (nonatomic, strong) DisclaimerVC *disclaimerVC;

@end
