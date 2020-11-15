//
//  RelatedDegelate.h
//  terminalOrder
//
//  Created by ren will on 21/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RelatedDegelate <NSObject>

@optional

- (void)removeSelfFromBaseView;

- (void)didDeselectAnnotationView:(NSString *)restaurantID;

@end
