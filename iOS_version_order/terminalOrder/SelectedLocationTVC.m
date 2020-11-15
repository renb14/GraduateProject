//
//  SelectedLocationTVC.m
//  terminalOrder
//
//  Created by ren will on 04/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "SelectedLocationTVC.h"
#import "DBManager.h"
#import "UserConfigurationData.h"
@interface SelectedLocationTVC ()
@property(nonatomic, copy) NSMutableArray *origList;
@property (nonatomic, strong) NSMutableDictionary *sortedDic;
@property (nonatomic, strong) NSIndexPath * curIndexPath;
@property (nonatomic, strong) UserConfigurationData *userData;
@end

@implementation SelectedLocationTVC
@synthesize nType;
@synthesize origList, sortedDic;
@synthesize curIndexPath;
@synthesize userData;

- (void)bubbleSort{
    NSInteger nSize = [origList count];
    for (NSInteger i = 0 ; i < nSize - 1; ++i) {
        for (NSInteger j = 0; j < nSize - 1 - i; ++j) {
            NSString *strForward = [origList objectAtIndex:j];
            NSString *strBackword = [origList objectAtIndex:(j + 1)];
            if (![strForward isEqualToString:strBackword]) {
                BOOL bResult = [strForward compare:strBackword] == NSOrderedDescending;
                if (bResult) {
                    //NSString *tmp = [[NSString alloc] initWithString:strForward];
                    origList[j] = strBackword;
                    origList[j+1] = strForward;
                }
            }
        }
    }
}
- (void)convertArraytoDictionary{
    [self bubbleSort];
    NSMutableArray *copyArray = [[NSMutableArray alloc] initWithArray:origList];
    if (sortedDic == nil) {
        sortedDic = [[NSMutableDictionary alloc] initWithCapacity:[origList count]];
    }
    if ([sortedDic count] != 0) {
        [sortedDic removeAllObjects];
    }
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:[origList count]];
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
//@"select name, department, year from studentsDetail where regno=\"%@\"",registerNumber
- (NSArray *)searchDataBase:(NSString *)tableName{
    NSMutableString *strSQL = [[NSMutableString alloc]init];
    NSMutableArray * arrMu = [[NSMutableArray alloc]init];
    NSArray *arrResult;
    switch (nType) {
        case 0:
            [strSQL appendFormat:@"select distinct restNation from %@ order by restNation asc",tableName];
            break;
        case 1:
            [strSQL appendFormat:@"select distinct restState from %@ where restNation = '%@' order by restState asc",tableName,userData.nation];
            break;
        case 2:
            [strSQL appendFormat:@"select distinct restCity from %@ where restNation = '%@' and restState = '%@' order by restCity asc",tableName,userData.nation, userData.state];
            break;
        default:
            break;
    }
    if (![strSQL isEqualToString:@""]) {
        DBManager* dbManager = [DBManager getDBManagerInstance];
        NSArray *arr = [dbManager executeQuery:strSQL];
        for (NSDictionary *dicUnit in arr) {
            NSArray *tmp = [dicUnit allKeys];
            NSString *name = [tmp firstObject];
            [arrMu addObject:[dicUnit objectForKey:name]];
        }
        arrResult = [[NSArray alloc]initWithArray:arrMu];
        return arrResult;
    }else
        return nil;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    userData = [UserConfigurationData getSingletonInstance];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (origList == nil) {
        origList = [[NSMutableArray alloc] initWithArray:[self searchDataBase:@"restaurantlist"] ];
    }else{
        if ([origList count] > 0) {
            [origList removeAllObjects];
        }
        [origList addObjectsFromArray:[self searchDataBase:@"restaurantlist"]];
    }
    [self convertArraytoDictionary];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sortedDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sortKeys = [[sortedDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *strSection = [sortKeys objectAtIndex:section];
    NSInteger count = [[sortedDic objectForKey:strSection] count];
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *sortKeys = [[sortedDic allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *strSection = [sortKeys objectAtIndex:section];
    return strSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rbhfish" forIndexPath:indexPath];
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"rbhfish"];
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
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSString *strKey = [[sortedDic allKeys] objectAtIndex:section];
    NSArray *tmp = [sortedDic objectForKey:strKey];
    NSString *strValue = [tmp objectAtIndex:row];

    switch (nType) {
        case 0:
            userData.nation = strValue;
            break;
        case 1:
            userData.state = strValue;
            break;
        case 2:
            userData.city = strValue;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}
- (UITableViewCellAccessoryType)tableView:(UITableView*)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath*)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSString *strKey = [[sortedDic allKeys] objectAtIndex:section];
    NSArray *tmp = [sortedDic objectForKey:strKey];
    NSString *strValue = [tmp objectAtIndex:row];
    NSString *preSelected;
    switch (nType) {
        case 0:
            preSelected = userData.nation;
            break;
        case 1:
            preSelected = userData.state;
            break;
        case 2:
            preSelected = userData.city;
            break;
        default:
            break;
    }
    if (curIndexPath == nil && [preSelected isEqualToString:strValue]) {
        return UITableViewCellAccessoryCheckmark;
    }
    else if( curIndexPath == indexPath && curIndexPath!= nil)
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
