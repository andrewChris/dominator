//
//  TwitterObject.h
//  Dominator
//
//  Created by Christophides, A. J. on 9/03/2016.
//  Copyright © 2016 The Dominator Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterObject : NSObject

@property (nonatomic, strong) NSMutableDictionary *jsonResponse;

@end

@interface TwitterFollower : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic) bool isHappy;

@end
