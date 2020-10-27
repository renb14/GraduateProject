//
//  DisclaimerVC.m
//  terminalOrder
//
//  Created by ren will on 21/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "DisclaimerVC.h"
#import "UserConfigurationData.h"

@interface DisclaimerVC ()

@end

@implementation DisclaimerVC
@synthesize userConfigTVC, userConfigNav;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSLog(@"I am in DisclaimerVC");
}

- (void)getNotification:(NSNotification *)notification{
    NSLog(@"I am userConfigTVC in DisclaimerVC");
    
    //
    [userConfigTVC willMoveToParentViewController:nil];
    [userConfigTVC removeFromParentViewController];
    [userConfigTVC.view removeFromSuperview];
    
    // send a notification that remove
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disclaimerVCQuit" object:nil];
}
//
- (void)showUserConfigTVC{
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:@"userConfigTVCQuit" object:nil];
    userConfigTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"userconfigurationsetting"];
    [self addChildViewController:userConfigTVC];
    [self.view addSubview:userConfigTVC.view];
    [userConfigTVC didMoveToParentViewController:self];
}
- (IBAction)onClickQuit:(id)sender {
    NSLog(@"I am in onClickQuit");
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"Are you sure to quit this wonderful app?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){[alert dismissViewControllerAnimated:YES completion:nil];}];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action)
        {
            [alert dismissViewControllerAnimated:YES completion:nil];
            [[UserConfigurationData getSingletonInstance] deleteInfoLocalFile];
            exit(0);
        }
    ];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:NO completion:nil];

}
- (void)getNotificationNav:(NSNotification *)notification{
    [userConfigNav willMoveToParentViewController:nil];
    [userConfigNav removeFromParentViewController];
    [userConfigNav.view removeFromSuperview];
    // send a notification that remove
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disclaimerVCQuit" object:nil];
}
- (void)showUserConfigNav{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotificationNav:) name:@"userConfigNavQuit" object:nil];
    userConfigNav = [self.storyboard instantiateViewControllerWithIdentifier:@"userconfignav"];
    [self addChildViewController:userConfigNav];
    [self.view addSubview:userConfigNav.view];
    [userConfigNav didMoveToParentViewController:self];
}
- (IBAction)onClickYes:(id)sender {
    //[self showUserConfigTVC];
    [self showUserConfigNav];
    //add notification observer

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
