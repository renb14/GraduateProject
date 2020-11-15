//
//  SelectTargetTVC.m
//  terminalOrder
//
//  Created by ren will on 04/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "SelectTargetTVC.h"
#import "UserConfigurationData.h"
#import "SelectedLocationTVC.h"

@interface SelectTargetTVC ()
@property (nonatomic, copy) NSMutableString *searchCity;
@property (nonatomic, copy) NSMutableString *searchState;
@property (nonatomic, copy) NSMutableString *searchNation;
@property (nonatomic, strong) SelectedLocationTVC *selectedLocation;
@property (nonatomic, strong) UserConfigurationData *userData;
@end

@implementation SelectTargetTVC
@synthesize searchCity, searchState, searchNation;
@synthesize selectedLocation, userData;
- (void)viewDidLoad {
    [super viewDidLoad];
    userData = [UserConfigurationData getSingletonInstance];
    searchCity = [[NSMutableString alloc] init];
    searchState = [[NSMutableString alloc] init];
    searchNation = [[NSMutableString alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    searchCity = (NSMutableString *)userData.city;
    searchState = (NSMutableString *)userData.state;
    searchNation = (NSMutableString *)userData.nation;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *name = nil;
    switch (section) {
        case 0:
            name = @"Select Nation";
            break;
        case 1:
            name = @"Select State";
            break;
        case 2:
            name = @"Select City";
            break;
    }
    return name;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"selecttargettvccell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSInteger section = [indexPath section];
    // Configure the cell...
    switch (section) {
        case 0:
            cell.textLabel.text = @"Country";
            cell.detailTextLabel.text = searchNation;
            break;
        case 1:
            cell.textLabel.text = @"State";
            cell.detailTextLabel.text = searchState;
            break;
        case 2:
            cell.textLabel.text = @"City";
            cell.detailTextLabel.text = searchCity;
            break;
        default:
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    switch (section) {
        case 0:
            [self performSegueWithIdentifier:@"showselectedlocationTVC" sender:indexPath];
            break;
        case 1:
            if (![searchNation isEqualToString:@""]) {
                [self performSegueWithIdentifier:@"showselectedlocationTVC" sender:indexPath];
            }
            break;
        case 2:
            if (![searchNation isEqualToString:@""] && ![searchState isEqualToString:@""]) {
                [self performSegueWithIdentifier:@"showselectedlocationTVC" sender:indexPath];
            }
            break;
        default:
            break;
    }
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showselectedlocationTVC"]) {
        selectedLocation = [segue destinationViewController];
        selectedLocation.nType = (NSInteger) [sender section];
    }
}


@end
