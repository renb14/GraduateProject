//
//  DisclaimerVC.h
//  terminalOrder
//
//  Created by ren will on 21/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserConfigurationSettingVC.h"
#import "UserConfigNav.h"

@interface DisclaimerVC : UIViewController

@property(nonatomic, weak) UserConfigurationSettingVC *userConfigTVC;
@property(nonatomic, weak) UserConfigNav* userConfigNav;

@end
