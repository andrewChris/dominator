//
//  HappinessViewController.h
//  Dominator
//
//  Created by Christophides, A. J. on 9/03/2016.
//  Copyright © 2016 The Dominator Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterObject.h"

@interface HappinessViewController : UIViewController

@property (nonatomic, strong) TwitterObject *twitterObject;
@property (nonatomic, strong) NSDictionary *followers;

@end
