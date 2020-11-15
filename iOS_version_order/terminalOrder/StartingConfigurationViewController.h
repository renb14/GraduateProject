//
//  StartingConfigurationViewController.h
//  terminalOrder
//
//  Created by ren will on 20/03/2017.
//  Copyright © 2017 ren will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RelatedDegelate.h"


@interface StartingConfigurationViewController : UIViewController

@property (nonatomic, copy) NSString *idfv;
@property (nonatomic, assign) id<RelatedDegelate> delegate;

@end
