//
//  UserConfigurationSettingVC.m
//  terminalOrder
//
//  Created by ren will on 22/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "UserConfigurationSettingVC.h"
#import "UserConfigurationData.h"

@interface UserConfigurationSettingVC ()
@property (nonatomic, strong) UserConfigurationData *userData;
@end

@implementation UserConfigurationSettingVC
@synthesize userConfigTV, userData;

- (void)addUserConfigTV{
    [self.userConfigTV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UserConfigCell"];
    userConfigTV.delegate = self;
    userConfigTV.dataSource = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addUserConfigTV];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //
    userData = [UserConfigurationData getSingletonInstance];
}
- (IBAction)onClickDone:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userConfigTVCQuit" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *name = nil;
    switch (section) {
        case 0:
            name = @"UserInfomation";
            break;
        case 1:
            name = @"Location";
            break;
        case 2:
            name = @"About_Me";
            break;
    }
    return name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch(section){
        case 0:
            count = 2;
            break;
        case 1:
            count = 3;
            break;
        case 2:
            count = 1;
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserConfigCell" forIndexPath:indexPath];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserConfigCell" forIndexPath:indexPath];
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UserConfigCell"];
//    cell.
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    cell.textLabel.text = @"user";
                    cell.detailTextLabel.text = @"Mason Dupre";//userData.userName;
//                    cell.
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"eMail";
                    cell.detailTextLabel.text = userData.eMail;
                }
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (row) {
                case 0:
                {
                    cell.textLabel.text = @"nation";
                    cell.detailTextLabel.text = @"";
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"state";
//                    cell.detailTextLabel.text = self.state;
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"City";
//                    cell.detailTextLabel.text = self.city;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (row) {
                case 0:
                {
                    cell.textLabel.text = @"Software Info";
                    cell.detailTextLabel.text = @"check on me";
                }
                    break;
            }
        }
            break;
            
    }
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
