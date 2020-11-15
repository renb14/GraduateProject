//
//  StartingConfigurationViewController.m
//  terminalOrder
//
//  Created by ren will on 20/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

/*
 THIS FILE IS ALREADY REMOVED FROM THE PROJECT
 */

#import "StartingConfigurationViewController.h"
#import "NetResource.h"
#import "UserConfigurationData.h"
#import "DisclaimerVC.h"

@interface StartingConfigurationViewController ()
@property (nonatomic, weak) DisclaimerVC *disclaimerVC;
@end

@implementation StartingConfigurationViewController
@synthesize idfv, delegate, disclaimerVC;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeDisclaimerVC:) name:@"disclaimerVCQuit" object:nil];
    // Do any additional setup after loading the view.
    [self SetupUserConfiguration];
   // [self isUserExisting];
}
- (IBAction)onClickQuit:(id)sender {
    [self postMessageQuit];
}

- (void)removeDisclaimerVC:(NSNotification *)notification{
    NSLog(@"get a message that quit disclaimerVC");
    //
    [disclaimerVC willMoveToParentViewController:nil];
    [disclaimerVC removeFromParentViewController];
    [disclaimerVC.view removeFromSuperview];
    //
    //[self postMessageQuit];
}

- (void)postMessageQuit{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"representsearchtargetbylocation" object:@"shut it"];
}
/*
 check out whether or not local file which is used to record information of user;
 if existing, indicate it is not first time to use this app, so we can skip the disclaim page and enter mainpage
 if not existing, 
    1. get idfv;
    2. go to disclaim page
    3. after agreement with disclaim, then jump to user configuration page
    4. after completing configuration, remove user configuration page from supview
 */
- (void)SetupUserConfiguration {
    UserConfigurationData *userDataInstance = [UserConfigurationData getSingletonInstance];
    if(userDataInstance.bFirst){
        disclaimerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"disclaimerVC"];
        [self addChildViewController:disclaimerVC];
        [self.view addSubview:disclaimerVC.view];
        [disclaimerVC didMoveToParentViewController:self];
    }else{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"I am in SetupUserConfiguration for 2 seconds");
        [self postMessageQuit];
    }
}
//
- (BOOL)isUserExisting {
    __block BOOL bExist = true;
    NSString* tmp = @"rambo";
    NSString *urlGetUserInfo = [NSString stringWithFormat:@"%@%@%@",AWSURLBASE,GETUSERINFOBYID,tmp];
    NSURL* url = [NSURL URLWithString:urlGetUserInfo];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *getUserInfoTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@" I am in block now!\n");
        if(!error)
        {
            NSLog(@"Networking is fine\n");
            //deal with NSData format data, convert NSData to JSon format
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@",dic);
            NSString *deviceID = [dic valueForKey:@"deviceID"];
            
            if(deviceID != nil)
            {
                bExist = true;
                NSLog(@"There is some strings : %@",deviceID);
                
            }else
            {
                bExist = false;
                NSLog(@"There is no data!\n");
            }
            
        }else
            bExist = false;
    }];
    [getUserInfoTask resume];
    return bExist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
