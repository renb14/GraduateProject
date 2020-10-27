//
//  CalloutMapAnnotation.m
//  terminalOrder
//
//  Created by ren will on 27/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import "CalloutMapAnnotation.h"

@implementation CalloutMapAnnotation
@synthesize latitude;
@synthesize longitude;
@synthesize restID;
@synthesize dicRest;

- (id)initWithLatitude:(CLLocationDegrees)lati
          andLongitude:(CLLocationDegrees)longi{
    self = [super init];
    if (self) {
        self.latitude = lati;
        self.longitude = longi;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}
@end
