//
//  UserConfigurationSettingTVC.m
//  terminalOrder
//
//  Created by ren will on 23/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "UserConfigurationSettingTVC.h"
#import "UserVC.h"
#import "LocationVC.h"
#import "UserConfigurationData.h"
#import "LocationList.h"

@interface UserConfigurationSettingTVC ()
@property (nonatomic, strong) UserConfigurationData *userData;
@end

@implementation UserConfigurationSettingTVC
@synthesize userData;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    userData = [UserConfigurationData getSingletonInstance];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //refresh tableview
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 click on button done
 1. save new user infomation to UserConfigurationData instance and write to local file
 2. update the new user infomation
 */
- (IBAction)onClickDone:(id)sender {
    [userData writeModificationintoLocalFile];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userConfigNavQuit" object:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
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
            name = @"Type";
            break;
        case 3:
            name = @"Software Infomation";
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
        case 3:
            count = 1;
            break;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
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
                    cell.textLabel.text = @"UserName";
                    cell.detailTextLabel.text = userData.userName;
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"EMail";
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
                    cell.textLabel.text = @"Nation";
                    cell.detailTextLabel.text = userData.nation;
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"State";
                    cell.detailTextLabel.text = userData.state;
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"City";
                    cell.detailTextLabel.text = userData.city;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"type";
        }
            break;
        case 3:
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"userinfo"]) {
        UserVC *userVC = [segue destinationViewController];
        userVC.name = (NSString *)sender;
    }else if ([[segue identifier] isEqualToString:@"showlocation"]){
        LocationList *loc = [segue destinationViewController];
        loc.functionName = (NSString *)sender;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSString *functionName = nil;
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                    [self performSegueWithIdentifier:@"userinfo" sender:@"username"];
                    break;
                case 1:
                    [self performSegueWithIdentifier:@"userinfo" sender:@"email"];
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (row) {
                case 0:
                    functionName = @"nation";
                    break;
                case 1:
                    functionName = @"state";
                    break;
                case 2:
                    functionName = @"city";
                    break;
                default:
                    break;
            }
            [self performSegueWithIdentifier:@"showlocation" sender:functionName];
        }
            
            break;
        case 2:
        {
            [self performSegueWithIdentifier:@"showmutipletypes" sender:nil];
        }
            break;
        default:
            break;
    }
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
