//
//  BasicTypeAnnotation.h
//  terminalOrder
//
//  Created by ren will on 27/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BasicTypeAnnotation : NSObject

@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;
@property (nonatomic, strong) NSString *restID;
@property (nonatomic, copy) NSMutableDictionary *dicRest;

- (id)initWithLatitude:(CLLocationDegrees) lati
                      andLongitude:(CLLocationDegrees) longi;

- (void)setCoordinate:(CLLocationCoordinate2D) newCoordinate;

@end
