//
//  SearchVC.m
//  terminalOrder
//
//  Created by ren will on 21/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "SearchVC.h"
#import "SearchTargetByMapVC.h"
#import "SearchTargetByLocationTVC.h"
#import "RelatedDegelate.h"
#import "OrderDishesTVC.h"
#import "UserConfigurationData.h"

@interface SearchVC () <RelatedDegelate>
@property (nonatomic, weak) SearchTargetByMapVC *searchTargetByMapVC;
@property (nonatomic, weak) SearchTargetByLocationTVC *searchTargetByLocationTVC;
@property (nonatomic, assign) BOOL bChange;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnChange;
@end

@implementation SearchVC
@synthesize searchTargetByMapVC, searchTargetByLocationTVC;
@synthesize bChange;
@synthesize btnChange;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addDoubleVC];
    bChange = YES;
    btnChange.title = @"List";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMessagefromShow:) name:@"showspecificrestaurant" object:nil];
}
- (IBAction)onClickChange:(id)sender {
    bChange = !bChange;
    if (bChange) {
        btnChange.title = @"List";
    } else {
        btnChange.title = @"Map";
    }
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView commitAnimations];
}

- (void)addDoubleVC{
    searchTargetByMapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchtargetbymapvc"];
    searchTargetByLocationTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchtargetbylocationtvc"];
    [self addChildViewController:searchTargetByLocationTVC];
    [self addChildViewController:searchTargetByMapVC];
    [searchTargetByLocationTVC didMoveToParentViewController:self];
    [searchTargetByMapVC didMoveToParentViewController:self];
    [self.view insertSubview:searchTargetByLocationTVC.view atIndex:0];
    [self.view insertSubview:searchTargetByMapVC.view atIndex:1];


}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showspecificrestaurant"]){
        UserConfigurationData *dataUser = [UserConfigurationData getSingletonInstance];
        dataUser.bOrderModel = NO;
        OrderDishesTVC *tmp = [segue destinationViewController];
        NSMutableDictionary *dicRest = (NSMutableDictionary *)sender;
        tmp.restID = [dicRest objectForKey:@"restID"];
        tmp.restName = [dicRest objectForKey:@"restName"];
        tmp.introduction = [[NSString alloc] initWithFormat:@"The name of the restaurant is %@. The location is %@. The contact number is %@. %@.", [dicRest objectForKey:@"restName"],[dicRest objectForKey:@"restAddress"], [dicRest objectForKey:@"restPhone"], [dicRest objectForKey:@"restMenu"]];
    }
}
- (void)getMessagefromShow:(NSNotification *)message{
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithDictionary: [message object]];
    NSString *restaurantID = [tmp objectForKey:@"restID"];
    if (restaurantID != nil && ![restaurantID isEqualToString:@""]) {
        [self performSegueWithIdentifier:@"showspecificrestaurant" sender:tmp];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
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
