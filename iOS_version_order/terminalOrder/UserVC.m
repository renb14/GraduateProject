//
//  UserVC.m
//  terminalOrder
//
//  Created by ren will on 23/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "UserVC.h"
#import "UserConfigurationData.h"

@interface UserVC ()
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (nonatomic, strong) UserConfigurationData *userData;
@end

@implementation UserVC
@synthesize name, userLabel,inputTextField, userData;
- (IBAction)onClickDone:(id)sender {
    if ([name isEqualToString:@"username"]) {
        if(![userData.userName isEqualToString:inputTextField.text])
        {
            userData.userName = inputTextField.text;
        }
    }else{
        if (![userData.eMail isEqualToString:inputTextField.text]) {
            userData.eMail = inputTextField.text;
        }
    }
    //[self dismiss:NO completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)showTextField{
    inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    inputTextField.clearsOnBeginEditing = YES;
    userData = [UserConfigurationData getSingletonInstance];
    if([name isEqualToString:@"username"]){
        inputTextField.placeholder = [userData.userName isEqualToString:@""]?@"Please enter your username":userData.userName;
    }else{
        inputTextField.placeholder = [userData.eMail isEqualToString:@""]?@"Please enter your EMail":userData.eMail;
    }
    
    [inputTextField becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    userLabel.text = name;
    [self showTextField];
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
