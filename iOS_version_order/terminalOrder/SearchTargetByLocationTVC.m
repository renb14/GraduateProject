//
//  SearchTargetByLocationTVC.m
//  terminalOrder
//
//  Created by ren will on 25/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "SearchTargetByLocationTVC.h"
#import "UserConfigurationData.h"
#import "NetResource.h"
#import "DBManager.h"
#import "ShowRestaurantTableViewCell.h"

@interface SearchTargetByLocationTVC ()
@property (nonatomic, strong) UserConfigurationData *userData;
@property (nonatomic, strong) NSMutableArray *restaurantList;
@end

@implementation SearchTargetByLocationTVC
@synthesize userData;
@synthesize restaurantList;

- (NSArray *)searchRestaurantListByLocation:(NSString *)tableName{
    NSMutableString *strSQL = [[NSMutableString alloc]init];
    if ([userData.nation isEqualToString:@""] || [userData.state isEqualToString:@""] || [userData.city isEqualToString:@""]) {
        return nil;
    }
    [strSQL appendFormat:@"select * from %@ where restNation = '%@' and restState = '%@' and restCity = '%@'order by restName asc",tableName,userData.nation, userData.state, userData.city];
    if (![strSQL isEqualToString:@""]) {
        DBManager* dbManager = [DBManager getDBManagerInstance];
        NSArray *arr = [dbManager executeQuery:strSQL];
        return arr;
    }else
        return nil;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    userData = [UserConfigurationData getSingletonInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(representTableView:) name:@"representsearchtargetbylocation" object:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShowRestaurantTableViewCell" bundle:nil] forCellReuseIdentifier:@"customizedshowrestaurant"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (restaurantList == nil) {
        restaurantList = [[NSMutableArray alloc]init];
    }else if ([restaurantList count] > 0){
        [restaurantList removeAllObjects];
    }
    [restaurantList addObjectsFromArray:[self searchRestaurantListByLocation:@"restaurantlist"]];
    [self.tableView reloadData];
}
- (void)representTableView:(NSNotification *)message{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([restaurantList count] > 0) {
        [restaurantList removeAllObjects];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([restaurantList count] > 0) {
        return 2;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger nCount = 0;
    switch (section) {
        case 0:
            nCount = 1;
            break;
        case 1:
            nCount = [restaurantList count];
        default:
            break;
    }
    return nCount;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *name = nil;
    switch (section) {
        case 0:
            name = @"Search Restaurants By City";
            break;
        case 1:
            name = @"Restaurant List";
            break;
    }
    return name;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    if (section == 0) {
        [self performSegueWithIdentifier:@"showselectTVC" sender:indexPath];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showspecificrestaurant" object:[restaurantList objectAtIndex:row] ];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL bShow = YES;
    NSInteger nSection = [indexPath section];
    NSInteger nRow = [indexPath row];

    // Configure the cell..
    if ([userData.city isEqualToString:@""]) {
        bShow = NO;
    }
    if(nSection == 0) {
        UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"searchrestaurantbycitycell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"Target City";
        if (bShow) {
            NSString *info = [NSString stringWithFormat:@"%@ %@,%@",userData.city,userData.state,userData.nation];
            cell.detailTextLabel.text = info;
        }
        return cell;
    } else if (nSection == 1){
        ShowRestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customizedshowrestaurant" forIndexPath:indexPath];
        NSString *restName = [[restaurantList objectAtIndex:nRow] objectForKey:@"restName"];
        NSString *restPhone = [[restaurantList objectAtIndex:nRow] objectForKey:@"restPhone"];
        NSString *restAddr = [[restaurantList objectAtIndex:nRow] objectForKey:@"restAddress"];
        NSString *tag = [[restaurantList objectAtIndex:nRow] objectForKey:@"typeTag"];
        cell.restName.text = restName;
        cell.restPhone.text = [[NSString alloc] initWithFormat:@"Phone : %@",restPhone ];
        cell.restAddr.text = restAddr;
        if ([tag isEqualToString:@"Chinese"]) {
            cell.imgViewType.image = [UIImage imageNamed:@"chinese.png"];
        } else if([tag isEqualToString:@"Japen"]){
            cell.imgViewType.image = [UIImage imageNamed:@"japen.png"];
        }else{
            cell.imgViewType.image = [UIImage imageNamed:@"thailand.png"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else{
        return nil;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    if (section == 0) {
        return 44.0;
    }else
        return 111.0;
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
