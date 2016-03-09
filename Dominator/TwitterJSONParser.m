//
//  TwitterJSONParser.m
//  Dominator
//
//  Created by Edward Jones on 10/03/2016.
//  Copyright © 2016 The Dominator Company. All rights reserved.
//

#import "TwitterJSONParser.h"
#import "TwitterObject.h"

@implementation TwitterJSONParser

+(NSDictionary *)parseTwitterJSON:(NSDictionary *)dict {
    
    NSMutableDictionary *result = [NSMutableDictionary new];
    
    NSMutableArray *followers = [NSMutableArray new];
    
    NSArray *usersArray = [dict objectForKey:@"users"];
    
    int numberHappy = 0;
    int numberSad = 0;
    
    for (NSDictionary *followerDict in usersArray) {
        
        TwitterFollower *follower = [TwitterFollower new];
        
        follower.name = [followerDict objectForKey:@"name"];
        follower.imageURL = [NSURL URLWithString:[followerDict objectForKey:@"profile_image_url"]];
        
        [followers addObject:follower];
        
        bool isHappy = false; //Pull from JSON
        
        follower.isHappy = isHappy;
        
        if (isHappy) {
            numberHappy++;
        }else {
            numberSad++;
        }
        
    }
    
    [result setObject:followers forKey:@"followers"];
    [result setObject:[NSNumber numberWithDouble:((double)numberHappy / (double)followers.count) * 100.0] forKey:@"percentHappy"];
    [result setObject:[NSNumber numberWithDouble:((double)numberSad / (double)followers.count) * 100.0] forKey:@"percentSad"];
                              
    return result;
    
}

@end
