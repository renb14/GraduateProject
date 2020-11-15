//
//  SearchTargetByMapVC.m
//  terminalOrder
//
//  Created by ren will on 25/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "SearchTargetByMapVC.h"
#import <CoreLocation/CoreLocation.h>
#import "NetResource.h"
#import "BasicTypeAnnotation.h"
#import "CalloutMapAnnotation.h"
#import "CallOutAnnotationView.h"
#import "MiaTableViewCell.h"
#import "RelatedDegelate.h"

#import "DBManager.h"

@interface SearchTargetByMapVC ()
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) MKMapView *localMapView;
@property(nonatomic, assign) MKCoordinateSpan preSpan;
@property(nonatomic, copy) NSMutableDictionary *dicRestaurant;
@property(nonatomic, copy) NSMutableArray *listRestaurant;
@property(nonatomic, strong) CalloutMapAnnotation *curCalloutAnnotation;
@property (nonatomic, assign)     __block Boolean bTest;
@end

@implementation SearchTargetByMapVC
@synthesize localMapView, locationManager;
@synthesize preSpan;
@synthesize dicRestaurant;
@synthesize listRestaurant;
@synthesize curCalloutAnnotation;
@synthesize bTest;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //add notification observer
    bTest = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAllAnnotations:) name:@"getinfomationofannotation" object:nil];
    dicRestaurant = [[NSMutableDictionary alloc] init];
    listRestaurant = [[NSMutableArray alloc] init];
    [self initGUI];
}
- (void)showAllAnnotations:(NSNotification *)message{
    NSDictionary *tmpDic =  [[NSDictionary alloc]  initWithDictionary: [message object]];
    //NSLog(@"%@",tmpDic restName);
    //
    if ([listRestaurant count] != 0) {
        [listRestaurant removeAllObjects];
    }
    [listRestaurant setArray: [tmpDic objectForKey:@"listResult"]];
    for (NSDictionary *dic in listRestaurant) {
        CLLocationDegrees latitude=[[dic objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees longitude=[[dic objectForKey:@"longitude"] doubleValue];
        BasicTypeAnnotation *basicAnnotation = [[BasicTypeAnnotation alloc]initWithLatitude:latitude andLongitude:longitude];
        basicAnnotation.restID = [dic objectForKey:@"restID"];
        basicAnnotation.dicRest = [[NSMutableDictionary alloc] initWithDictionary:dic];
        [localMapView addAnnotation: (id)basicAnnotation];
    }
}
- (IBAction)onClickDone:(id)sender {
    NSLog(@"SearchTargetByMapVC click");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark add map frame
- (void)initGUI{
    CGRect rect = [UIScreen mainScreen].bounds;
    localMapView = [[MKMapView alloc] initWithFrame:rect];
    [self.view addSubview:localMapView];
    localMapView.delegate = self;
    //set up location service
    locationManager = [[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [locationManager requestWhenInUseAuthorization];
    }
    //set up user trace
    localMapView.userTrackingMode = MKUserTrackingModeFollow;
    //set up map mode
    localMapView.mapType = MKMapTypeStandard;
    localMapView.showsScale = YES;
    localMapView.showsBuildings = NO;
    localMapView.showsPointsOfInterest = NO;
}
- (void)downLoadRestaurantByRegion:(CLLocationCoordinate2D) leftTop withBottomRight:(CLLocationCoordinate2D) bottomRight{
    __block NSDictionary *tmpDic = [[NSDictionary alloc] init];
    //__block Boolean bTest = NO;
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlGetRestaurant = [NSString stringWithFormat:@"%@%@",AWSURLBASE,POSTREGIONBYMAP];
    NSURL *url  = [NSURL URLWithString:urlGetRestaurant];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
        [NSNumber numberWithFloat:bottomRight.longitude],@"maxLongitude",
        [NSNumber numberWithFloat:leftTop.longitude],@"minLongitude",
        [NSNumber numberWithFloat:bottomRight.latitude],@"minLatitude",
        [NSNumber numberWithFloat:leftTop.latitude], @"maxLatitude",
        nil];
    NSDictionary *wholeDic = [[NSDictionary alloc] initWithObjectsAndKeys:
        POSTREGIONBYMAPRESOURCE, @"action",
        dic, @"body",
        nil];
    NSData *data = [NSJSONSerialization dataWithJSONObject:wholeDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *httpBody = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    request.HTTPBody = [httpBody dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            NSLog(@"Networking is fine\n");
            //deal with NSData format data, convert NSData to JSon format
            tmpDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (bTest) {
                DBManager *instance = [DBManager getDBManagerInstance];
                [instance insertArray:[tmpDic objectForKey:@"listResult"] IntoTable:@"restaurantlist" WithPrimaryKey:@"restID"];
                bTest = NO;
            }

            if ([tmpDic objectForKey:@"nCount"] != nil && [tmpDic objectForKey:@"nCount"] > 0 ) {
                //post the message to mapView to show the annotoations
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getinfomationofannotation" object:tmpDic];
            }
            NSLog(@"%@",tmpDic);
        }
    }];
    // 启动任务
    [task resume];
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view.annotation isKindOfClass:[BasicTypeAnnotation class]]) {
        if (curCalloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            curCalloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            return;
        }
        if (curCalloutAnnotation) {
            [mapView removeAnnotation:curCalloutAnnotation];
            curCalloutAnnotation = nil;
        }
        
        curCalloutAnnotation = [[CalloutMapAnnotation alloc]
                               initWithLatitude:view.annotation.coordinate.latitude
                               andLongitude:view.annotation.coordinate.longitude] ;
        BasicTypeAnnotation *tmp  = (BasicTypeAnnotation *)view.annotation;
        curCalloutAnnotation.restID = tmp.restID;
        curCalloutAnnotation.dicRest = tmp.dicRest;
        [mapView addAnnotation:curCalloutAnnotation];
        
        [mapView setCenterCoordinate:curCalloutAnnotation.coordinate animated:YES];
    }
    else{
        NSLog(@"How can I get in here?");
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if (curCalloutAnnotation && ![view isKindOfClass:[CallOutAnnotationView class]]) {
        if (curCalloutAnnotation.coordinate.latitude == view.annotation.coordinate.latitude&&
            curCalloutAnnotation.coordinate.longitude == view.annotation.coordinate.longitude) {
            //NSString *restID = curCalloutAnnotation.restID;
            NSMutableDictionary *tmp = curCalloutAnnotation.dicRest ;
            [mapView removeAnnotation:curCalloutAnnotation];
            curCalloutAnnotation = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showspecificrestaurant" object:tmp];
        }
    }
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BasicTypeAnnotation class]]) {
        
        MKAnnotationView *annotationView =[self.localMapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnotation"];
            annotationView.canShowCallout = NO;
            annotationView.image = [UIImage imageNamed:@"pin.png"];
        }
        
        return annotationView;
    }else if ([annotation isKindOfClass:[CalloutMapAnnotation class]]) {
        
        CallOutAnnotationView *annotationView = (CallOutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CalloutView"];
        if (!annotationView) {
            annotationView = [[CallOutAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CalloutView"];
            MiaTableViewCell  *cell = [[[NSBundle mainBundle] loadNibNamed:@"MiaTableViewCell" owner:self options:nil] objectAtIndex:0];
            [annotationView.contentView addSubview:cell];
            
        }
        return annotationView;
    }
    return nil;
}

- (void)addALLAnnotations{

}
#pragma mark implement protocol
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"didUpdateUserLocation");
}
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    //get topleft point and rightbottom point of screem(measured in degree)
    MKCoordinateRegion region = mapView.region;
    CLLocationCoordinate2D topLeft = CLLocationCoordinate2DMake(region.center.latitude + region.span.latitudeDelta/2, region.center.longitude - region.span.longitudeDelta/2);
    CLLocationCoordinate2D bottomRight = CLLocationCoordinate2DMake(region.center.latitude - region.span.latitudeDelta/2, region.center.longitude + region.span.longitudeDelta/2);
    //download restaurant
    [self downLoadRestaurantByRegion:topLeft withBottomRight:bottomRight];
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
