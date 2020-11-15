//
//  UserConfigurationSettingVC.h
//  terminalOrder
//
//  Created by ren will on 22/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserConfigurationSettingVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *userConfigTV;

@end
