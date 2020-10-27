//
//  BaseVC.m
//  terminalOrder
//
//  Created by ren will on 21/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "BaseVC.h"
#import "UserConfigurationData.h"

@interface BaseVC ()

@end

@implementation BaseVC
@synthesize disclaimerVC;

/*
 check out whether or not local file which is used to record information of user;
 if existing, indicate it is not first time to use this app, so we can skip the disclaim page and enter mainpage
 if not existing,
 1. get idfv;
 2. go to disclaim page
 3. after agreement with disclaim, then jump to user configuration page
 4. after completing configuration, remove user configuration page from supview
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UserConfigurationData *userData = [UserConfigurationData getSingletonInstance];
    if (userData.bFirst) {
        [self showDisclaimerVC];
    }
}


- (void)showDisclaimerVC{
    //add notification observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMessage:) name:@"disclaimerVCQuit" object:nil];
    //
    disclaimerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"disclaimerVC"];
    [self addChildViewController:disclaimerVC];
    [self.view addSubview:disclaimerVC.view];
    [disclaimerVC didMoveToParentViewController:self];
}
/*
 this function respond when BaseVC class gets the message which is disclaimerVCQuit, the message is received when disclaimer is removed( first loggin is done)
 */
- (void)getMessage:(NSNotification *)message{
    //remove
    NSLog(@"%@",[message name]);
    /*
     
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:@"representsearchtargetbylocation" object:nil];
    [disclaimerVC willMoveToParentViewController:nil];
    [disclaimerVC removeFromParentViewController];
    [disclaimerVC.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //delete the notification observer
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
