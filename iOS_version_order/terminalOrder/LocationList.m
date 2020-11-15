//
//  LocationList.m
//  terminalOrder
//
//  Created by ren will on 24/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "LocationList.h"
#import "UserConfigurationData.h"

@interface LocationList ()
@property (nonatomic, strong) NSMutableArray *nameList;
@property (nonatomic, strong) NSMutableDictionary *sortedDic;
@property (nonatomic, strong) NSIndexPath *curIndexPath;
@end

@implementation LocationList
@synthesize nameList, sortedDic;
@synthesize curIndexPath;
@synthesize functionName;

- (void)viewDidLoad {
    [super viewDidLoad];
    nameList = [[NSMutableArray alloc] initWithCapacity:50];
    sortedDic = [[NSMutableDictionary alloc] initWithCapacity:27];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)bubbleSort{
    NSInteger nSize = [nameList count];
    for (NSInteger i = 0 ; i < nSize - 1; ++i) {
        for (NSInteger j = 0; j < nSize - 1 - i; ++j) {
            NSString *strForward = [nameList objectAtIndex:j];
            NSString *strBackword = [nameList objectAtIndex:(j + 1)];
            if (![strForward isEqualToString:strBackword]) {
                BOOL bResult = [strForward compare:strBackword] == NSOrderedDescending;
                if (bResult) {
                    //NSString *tmp = [[NSString alloc] initWithString:strForward];
                    nameList[j] = strBackword;
                    nameList[j+1] = strForward;
                }
            }
        }
    }
}

- (void)convertArraytoDictionary{
    [self bubbleSort];
    NSMutableArray *copyArray = [[NSMutableArray alloc] initWithArray:nameList];
    if ([sortedDic count] != 0) {
        [sortedDic removeAllObjects];
    }
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:[nameList count]];
    NSString *prehead = [[copyArray objectAtIndex:0] substringWithRange:NSMakeRange(0, 1)];
    for (NSInteger i = 0; i < [copyArray count] ; ++i) {
        NSString *strElement = [copyArray objectAtIndex:i];
        NSString *curHead = [strElement substringWithRange:NSMakeRange(0, 1)];
        if (![curHead isEqualToString:prehead]) {
            NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithArray:tmpArray];
            [sortedDic setObject:tmpArr forKey:prehead];
            [tmpArray removeAllObjects];
            [tmpArray addObject:strElement];
            prehead = curHead;
        }else{
            [tmpArray addObject:strElement];
        }
        
        if( i == [copyArray count] - 1){
            NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithArray:tmpArray];
            [sortedDic setObject:tmpArr forKey:prehead];
        }
    }
}
- (void)downloadNameList{
    NSArray *list = @[ @"hollow",@"hello",@"ya",@"yaya",@"bohan",@"ren",@"people",@"yugang",@"hell",@"mason",@"leia"];
    if ([nameList count] != 0) {
        [nameList removeAllObjects];
    }
    nameList = [[NSMutableArray alloc] initWithArray:list];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self downloadNameList];
    [self convertArraytoDictionary];
    //NSLog(@"viewWillAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickDone:(id)sender {
    UserConfigurationData *userData = [UserConfigurationData getSingletonInstance];
    NSInteger section = [curIndexPath section];
    NSInteger row = [curIndexPath row];
    
    NSArray *sortKeys = [[sortedDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *strSection = [sortKeys objectAtIndex:section];
    
    NSString *name = [[sortedDic objectForKey:strSection] objectAtIndex:row];
    if ([functionName isEqualToString:@"nation"]) {
        userData.nation = name;
    } else if ([functionName isEqualToString:@"state"]){
        userData.state = name;
    }else {
        userData.city = name;
    }
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [sortedDic count];
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *sortKeys = [[sortedDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *strSection = [sortKeys objectAtIndex:section];
    return strSection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sortKeys = [[sortedDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *strSection = [sortKeys objectAtIndex:section];
    NSInteger count = [[sortedDic objectForKey:strSection] count];
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationlistcell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];

    NSArray *sortKeys = [[sortedDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *strSection = [sortKeys objectAtIndex:section];
    NSString *strName = [[sortedDic objectForKey:strSection] objectAtIndex:row];
    cell.textLabel.text = strName;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    curIndexPath = indexPath;
    [self.tableView reloadData];
}
- (UITableViewCellAccessoryType)tableView:(UITableView*)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath*)indexPath
{
    if( curIndexPath == indexPath && curIndexPath!= nil )
    {
        return UITableViewCellAccessoryCheckmark;
    }
    else
    {
        return UITableViewCellAccessoryNone;
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
