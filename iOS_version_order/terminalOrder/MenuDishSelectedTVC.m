//
//  MenuDishSelectedTVC.m
//  terminalOrder
//
//  Created by ren will on 13/04/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "MenuDishSelectedTVC.h"
#import "MenuDishCommentCell.h"
#import "MenuDishDiscriptionCell.h"
#import "MenuDishPicCell.h"
#import "NetResource.h"
#import "UserConfigurationData.h"

@interface MenuDishSelectedTVC ()
//the value of arrComment is sorted by lunched time, means earlier, more head.
@property (nonatomic, copy) NSMutableArray *arrComment;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSelected;
@property (nonatomic, strong) __block NSString *curPicName;
@property (nonatomic, strong) __block UIImage *imgDish;
@property (nonatomic, strong) __block MenuDishPicCell* dishPicCell;
@property (nonatomic, strong) UserConfigurationData *userData;
@property (nonatomic, assign) BOOL bRefresh;
@end

@implementation MenuDishSelectedTVC
@synthesize dicInfo;
@synthesize arrComment;
@synthesize curPicName;
@synthesize imgDish;
@synthesize bSelected,btnSelected;
@synthesize userData;
@synthesize bRefresh;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuDishPicCell" bundle:nil] forCellReuseIdentifier:@"menudishpiccell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuDishDiscriptionCell" bundle:nil] forCellReuseIdentifier:@"menudishdiscriptioncell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuDishCommentCell" bundle:nil] forCellReuseIdentifier:@"menudishcommentcell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithNotificationComment:) name:GETNOTIFICATIONCOMMENTONDISH object:nil];
    arrComment = [[NSMutableArray alloc] init];
    userData = [UserConfigurationData getSingletonInstance];
    bRefresh = NO;
}

- (void)dealwithNotificationComment:(NSNotification *)message{
    NSDictionary *dicComment = [message object];
    [arrComment addObject:dicComment];
    self.bRefresh = YES;
}

- (void)downloadDishComments{
    
    
}
- (void)downloadDishPic{
    NSString *tmpFile = [dicInfo objectForKey:@"restID"];
    NSString *tmpDoc = [dicInfo objectForKey:@"dishUrl"];
    NSString *fileDirection = [[NSString alloc] initWithFormat:@"%@/%@",tmpFile,tmpDoc];
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlGetRestaurant = [NSString stringWithFormat:@"%@%@",AWSS3URL,fileDirection];
    NSURL *url  = [NSURL URLWithString:urlGetRestaurant];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if (![curPicName isEqualToString:tmpDoc]) {
    
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(!error)
            {
                NSString *ttmpFile = [dicInfo objectForKey:@"restID"];
                NSString *ttmpDoc = [dicInfo objectForKey:@"dishUrl"];
                NSString *ffileDirection = [[NSString alloc] initWithFormat:@"%@/%@",ttmpFile,ttmpDoc];
                NSString *curUrl = [NSString stringWithFormat:@"%@%@",AWSS3URL,ffileDirection];
                if ([[request.URL absoluteString] isEqualToString:curUrl]) {
                    imgDish = [UIImage imageWithData:data];
                    curPicName = ttmpDoc;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
                    });

                }
            }
        }
                                      ];
        [task resume];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (bSelected == YES) {
        btnSelected.title = @"cancel";
    }else
        btnSelected.title = @"select";
    if (bRefresh) {
        [self.tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onClickSelected:(id)sender {
    bSelected = !bSelected;
    if (bSelected == YES) {
        btnSelected.title = @"Cancel";
    }else
        btnSelected.title = @"Select";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GETNOTIFICATIONADDSELECTEDDISH object:[dicInfo objectForKey:@"dishID"]];
    if (userData.bOrderModel == NO) {
        userData.bOrderModel = YES;
        [self performSegueWithIdentifier:@"setuporderinfomation" sender:nil];
    }
    
}
- (IBAction)onClickComment:(id)sender {
    
    /*
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle: @"Alert Title"
                                message: @"Alert message"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action){
                                                   
                                                   
                                                   UITextField *alertTextField = alert.textFields.firstObject;
                                                   
                                                   NSLog(@"And the text is... %@!", alertTextField.text);
                                                   
                                               }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler: nil];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.placeholder = @"Text here";
        
    }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
     */
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger nCount = 0;
    if (section > 1) {
        if ([arrComment count] == 0) {
            nCount = 1;
        }else
            nCount = [arrComment count];
    }else
        nCount = 1;
    return nCount;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = [indexPath section];
    if (section == 0) {
        //Magic number
        return 375.0;
    }else if (section == 1) {
        NSString * description = [dicInfo objectForKey:@"description"];
        CGRect rect = [description boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-120, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        return rect.size.height + 42 + 16;
    }else if  (section == 2) {
        NSString *comment;
        NSInteger row = [indexPath row];
        if ([arrComment count] == 0) {
            comment = @"No Comment! Please Comment!";
        }else{
            NSArray *arrTmp = [[arrComment reverseObjectEnumerator] allObjects];
            NSDictionary *tmp = [arrTmp objectAtIndex:row];
            comment = [tmp objectForKey:COMMENTCONTENT];
            
        }
        CGRect rect = [comment boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame)-120, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        return rect.size.height + 21 +21 + 8 + 8;
    }else
        return 44.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = [indexPath section];
    if (section == 0) {
        MenuDishPicCell *cell =[tableView dequeueReusableCellWithIdentifier:@"menudishpiccell" forIndexPath:indexPath];
        if (imgDish == nil) {
            [cell.indicator startAnimating];
            [self downloadDishPic];
        }

        if (imgDish != nil) {
            cell.imgViewDish.image = imgDish;
            [cell.indicator stopAnimating];
        }
        
        return cell;
    }else if (section == 1){
        MenuDishDiscriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menudishdiscriptioncell" forIndexPath:indexPath];
        cell.lblDescription.text = [dicInfo objectForKey:@"description"];
        cell.lblPrice.text = [[dicInfo objectForKey:@"dishPrice"] stringValue];
        cell.nLblDislike.text = @"121";
        cell.nLike.text = @"2121";
        return cell;
    }else{
        MenuDishCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menudishcommentcell" forIndexPath:indexPath];
        if ([arrComment count] < 1) {
            cell.lblComment.text = @"No Comment! Please Comment!";
        }else{
            NSDictionary *dicComment = [[[arrComment reverseObjectEnumerator] allObjects] objectAtIndex:[indexPath row]];
            cell.lblTime.text = [dicComment objectForKey:COMMENTTIME];
            cell.lblUserID.text = [dicComment objectForKey:COMMENTUSERNAME];
            cell.lblComment.text = [dicComment objectForKey:COMMENTCONTENT];
            NSString *userID = [dicComment objectForKey:COMMENTUSERID];
            
            if ([userData.deviceID isEqualToString:userID]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                bRefresh = NO;
            }
        }
        return  cell;
    }
    // Configure the cell...
    

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
