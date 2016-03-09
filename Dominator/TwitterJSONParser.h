//
//  TwitterJSONParser.h
//  Dominator
//
//  Created by Edward Jones on 10/03/2016.
//  Copyright © 2016 The Dominator Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterJSONParser : NSObject

+(NSDictionary *)parseTwitterJSON:(NSDictionary *)dict;

@end
