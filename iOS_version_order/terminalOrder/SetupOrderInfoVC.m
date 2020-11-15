//
//  SetupOrderInfoVC.m
//  terminalOrder
//
//  Created by ren will on 14/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "SetupOrderInfoVC.h"
#import "OrderHistoryData.h"
#import "NetResource.h"

@interface SetupOrderInfoVC ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtContact;
@property (weak, nonatomic) IBOutlet UIDatePicker *orderTime;

@end

@implementation SetupOrderInfoVC
@synthesize txtName, txtNumber, txtContact, orderTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    txtName.keyboardType = UIKeyboardTypeDefault;
    txtName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    txtName.clearButtonMode = UITextFieldViewModeAlways;
    txtName.delegate = self;
    txtNumber.keyboardType = UIKeyboardTypeNumberPad;
    txtNumber.delegate = self;
    txtContact.keyboardType = UIKeyboardTypeDefault;
    txtContact.delegate = self;
    orderTime.datePickerMode = UIDatePickerModeDateAndTime;
    orderTime.minuteInterval = 15;
    NSDate *minDate = [NSDate date];
    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:30 * 24 * 60 * 60];
    orderTime.minimumDate = minDate;
    orderTime.maximumDate = maxDate;
}
- (IBAction)onClickDone:(id)sender {
    NSString *strNum = txtNumber.text;
    if (strNum == nil || [strNum integerValue] > 10 || [strNum integerValue] < 1) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"The Input is not valid." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){[alert dismissViewControllerAnimated:YES completion:nil];}];
        [alert addAction:ok];
        [self presentViewController:alert animated:NO completion:nil];
    }else{
        OrderHistoryData *historyData = [OrderHistoryData getOrderHistoryDataInstance];
        NSMutableDictionary * dicTmp = historyData.curOrdrtDic;
        if ([historyData.curOrdrtDic count] > 0) {
            [historyData.curOrdrtDic removeAllObjects];
        }
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *lunchTime = [df stringFromDate:orderTime.date];
        [historyData.curOrdrtDic setObject:strNum forKey:HISTORYATTENDNUMBER];
        [historyData.curOrdrtDic setObject:txtName.text forKey:HISTORYORDERNAME];
        [historyData.curOrdrtDic setObject:txtContact.text forKey:HISTORYORDERCONTACT];
        [historyData.curOrdrtDic setObject:lunchTime forKey:HISTORYORDERTIME];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [txtName becomeFirstResponder];
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
