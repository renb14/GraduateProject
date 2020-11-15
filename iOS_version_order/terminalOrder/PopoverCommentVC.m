//
//  PopoverCommentVC.m
//  terminalOrder
//
//  Created by ren will on 14/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "PopoverCommentVC.h"
#import "NetResource.h"
#import "UserConfigurationData.h"

@interface PopoverCommentVC ()
@property (weak, nonatomic) IBOutlet UITextView *comments;
@property (weak, nonatomic) IBOutlet UILabel *lblHolder;
@property (weak, nonatomic) IBOutlet UILabel *numberReminder;

@end

@implementation PopoverCommentVC
@synthesize comments;
@synthesize lblHolder,numberReminder;
@synthesize restID, dishID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.comments.delegate = self;
    self.comments.layer.borderWidth = 1.0;//边宽
    self.comments.layer.cornerRadius = 5.0;//设置圆角

}
- (IBAction)onClickPublish:(id)sender {
    NSLog(@"%@",self.comments.text);
    UserConfigurationData *userData = [UserConfigurationData getSingletonInstance];
    userData.userName = @"bohan";
    NSString *userID = userData.deviceID;
    NSString *userName = [userData.userName isEqualToString:@""]?@"anonymous":userData.userName;
    NSString *commentContent = self.comments.text;
    NSDate *now = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *lunchTime = [df stringFromDate:now];
    NSString *like = @"YES";
    NSDictionary *notificationComment = [[NSDictionary alloc] initWithObjectsAndKeys:userName,COMMENTUSERNAME,userID,COMMENTUSERID,commentContent,COMMENTCONTENT,lunchTime,COMMENTTIME,like,COMMENTLIKE,nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:GETNOTIFICATIONCOMMENTONDISH object:notificationComment];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onClickCancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidChange:(UITextView*)textView
{
    
    if([textView.text length] == 0){
        
        self.lblHolder.text = @"Please input your comment within 400 letters!";
        
    }else{
        
        self.lblHolder.text = @"";//这里给空
        
    }
    
    //计算剩余字数   不需要的也可不写
    
    NSString *nsTextCotent = textView.text;
    
    NSInteger existTextNum = [nsTextCotent length];
    
    NSInteger remainTextNum = 400 - existTextNum;
    
    self.numberReminder.text = [NSString stringWithFormat:@"%d/400",(int)remainTextNum];
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"])
    
        {
            [textView resignFirstResponder];
            return YES;
            
        }
        
        if (range.location >= 400)
            return NO;
        else
            return YES;
    
        
}

@end
