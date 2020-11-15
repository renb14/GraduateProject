//
//  UserConfigurationTableViewController.m
//  terminalOrder
//
//  Created by ren will on 21/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "UserConfigurationTableViewController.h"
#import "UserConfigurationData.h"

@interface UserConfigurationTableViewController ()
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *eMail;
@property (nonatomic, strong) NSString *notion;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *city;
@end

@implementation UserConfigurationTableViewController
@synthesize userName, eMail, notion,state,city;

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"User Configuration";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)initUserData{
    userName = @"";
    eMail = @"";
    notion = @"";
    state = @"";
    city = @"";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initUserData];
    UserConfigurationData* userData = [UserConfigurationData getSingletonInstance];
    if ([userData isExistLocalFile]) {
        [userData getInfofromLocalFile];
        userName = userData.userName;
        userName = userData.eMail;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
            name = @"About+Me";
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"User Configuration Cell" forIndexPath:indexPath];
    // Configure the cell...
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    cell.textLabel.text = @"userName";
                    cell.detailTextLabel.text = self.userName;
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"eMail";
                    cell.detailTextLabel.text = self.eMail;
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
                    cell.detailTextLabel.text = self.notion;
                }
                    break;
                case 1:
                {
                    cell.textLabel.text = @"State";
                    cell.detailTextLabel.text = self.state;
                }
                    break;
                case 2:
                {
                    cell.textLabel.text = @"City";
                    cell.detailTextLabel.text = self.city;
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
