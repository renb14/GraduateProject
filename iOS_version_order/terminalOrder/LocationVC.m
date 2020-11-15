//
//  LocationVC.m
//  terminalOrder
//
//  Created by ren will on 23/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "LocationVC.h"

@interface LocationVC ()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, copy) NSMutableArray *origalList;
@property (nonatomic, copy) NSArray *wordList;
@property (nonatomic, copy) NSMutableDictionary *sortDictionary;
@end

@implementation LocationVC
@synthesize location, locationLabel;
@synthesize origalList;
@synthesize sortDictionary;
@synthesize wordList;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationLabel.text = location;


 
    origalList = [[NSMutableArray alloc] initWithArray: @[@"hello", @"people",@"hollow",@"hell",@"ya",@"yaya"]];
    //[self BubbleSort];
    [self convertArraytoDictionary];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)BubbleSort{
    NSInteger nSize = [origalList count];
    for (NSInteger i = 0 ; i < nSize - 1; ++i) {
        for (NSInteger j = 0; j < nSize - 1 - i; ++j) {
            NSString *strForward = [origalList objectAtIndex:j];
            NSString *strBackword = [origalList objectAtIndex:(j + 1)];
            if (![strForward isEqualToString:strBackword]) {
                BOOL bResult = [strForward compare:strBackword] == NSOrderedDescending;
                if (bResult) {
                    origalList[j] = strBackword;
                    origalList[j+1] = strForward;
                }
            }
        }
    }
}

- (void)convertArraytoDictionary{
    [self BubbleSort];
    NSMutableArray *copyArray = [[NSMutableArray alloc] initWithArray:origalList];
    sortDictionary = [[NSMutableDictionary alloc] initWithCapacity:27];
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:[origalList count]];
    NSString *prehead = [[copyArray objectAtIndex:0] substringWithRange:NSMakeRange(0, 1)];
    for (NSInteger i = 0; i < [copyArray count] ; ++i) {
        NSString *strElement = [copyArray objectAtIndex:i];
        NSString *curHead = [strElement substringWithRange:NSMakeRange(0, 1)];
        if (![curHead isEqualToString:prehead]) {
            NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithArray:tmpArray];
            [sortDictionary setObject:tmpArr forKey:prehead];
            [tmpArray removeAllObjects];
            [tmpArray addObject:strElement];
            prehead = curHead;
        }else{
            [tmpArray addObject:strElement];
        }
        
        if( i == [copyArray count] - 1){
            NSMutableArray *tmpArr = [[NSMutableArray alloc] initWithArray:tmpArray];
            [sortDictionary setObject:tmpArr forKey:prehead];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
