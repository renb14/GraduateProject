//
//  CalloutMapAnnotation.h
//  terminalOrder
//
//  Created by ren will on 27/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CalloutMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationDegrees latitude;
@property (nonatomic) CLLocationDegrees longitude;
@property (nonatomic, strong) NSString *restID;
@property (nonatomic, copy) NSMutableDictionary *dicRest;

- (id)initWithLatitude:(CLLocationDegrees)lati
          andLongitude:(CLLocationDegrees)longi;

@end
