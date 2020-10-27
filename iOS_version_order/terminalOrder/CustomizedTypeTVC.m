//
//  CustomizedTypeTVC.m
//  terminalOrder
//
//  Created by ren will on 28/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "CustomizedTypeTVC.h"
#import "UserConfigurationData.h"
@interface CustomizedTypeTVC ()
@property (nonatomic, copy) NSMutableArray *selectIndexList;
@property (nonatomic, copy) NSArray *originList;
@property (nonatomic, strong) UserConfigurationData *userData;
@end

@implementation CustomizedTypeTVC
@synthesize selectIndexList;
@synthesize originList;
@synthesize userData;

- (IBAction)onClickDone:(id)sender {
    NSMutableArray *tmpArr = [[NSMutableArray alloc]initWithCapacity:[originList count]];
    for (NSIndexPath *index  in selectIndexList) {
        NSInteger i = [index row];
        NSString *tmpStr = [originList objectAtIndex:i];
        [tmpArr addObject:tmpStr];
    }
    if ([userData.arrTags count] > 0) {
        [userData.arrTags removeAllObjects];
    }
    userData.arrTags = tmpArr;
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSArray *arrTmp = @[@"chinese",@"japen",@"beef",@"coast",@"coffee",@"spicy",@"acid",@"hot"];
    originList = [arrTmp sortedArrayUsingSelector:@selector(compare:)];
    selectIndexList = [[NSMutableArray alloc] initWithCapacity:[originList count]];
    userData = [UserConfigurationData getSingletonInstance];
    for (NSString *strType in userData.arrTags) {
        for (NSInteger i = 0; i < [originList count]; i++) {
            if ([strType isEqualToString: [originList objectAtIndex:i]]) {
                NSIndexPath  *index = [NSIndexPath indexPathForRow:i inSection:1];
                [selectIndexList addObject:index];
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [originList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger nRow = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customizedtypecell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customizedtypecell"];
    }
    cell.textLabel.text = [originList objectAtIndex:nRow];
    cell.accessoryType = UITableViewCellAccessoryNone;
    for (NSIndexPath *index in selectIndexList) {
        if (index == indexPath) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [selectIndexList removeObject:indexPath];
    }else if(cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [selectIndexList addObject:indexPath];
    }
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
