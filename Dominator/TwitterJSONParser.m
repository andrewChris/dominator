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
    
    NSDictionary *alchemyDict = [dict objectForKey:@"alchemy"];
    
    int numberHappy = 0;
    int numberSad = 0;
    
    for (NSArray *key in alchemyDict.allKeys) {
        
        NSDictionary *item = [alchemyDict objectForKey:key];
        
        if (item.allKeys.count == 0) continue;
        
        NSString *type = [[item objectForKey:@"docSentiment"] objectForKey:@"type"];
        
        TwitterFollower *follower = [TwitterFollower new];
        
        bool isHappy = false;
        
        if ([type isEqualToString:@"positive"]) {
            isHappy = YES;
            numberHappy++;
        }else {
            isHappy = NO;
            numberSad++;
        }
        
        follower.isHappy = isHappy;
        
        [followers addObject:follower];
        
    }
    
    NSDictionary *usersDict = [dict objectForKey:@"users"];
    
    int index = 0;
    
    for (NSArray *key in usersDict.allKeys) {
        
        if (index > followers.count - 1) continue;
        
        TwitterFollower *follower = followers[index];
        
        NSDictionary *item = [usersDict objectForKey:key];
        
        follower.name = [item objectForKey:@"name"];
        follower.imageURL = [NSURL URLWithString:[item objectForKey:@"profile_image_url"]];
        
        index++;
        
    }
    
    [result setObject:followers forKey:@"followers"];
    [result setObject:[NSNumber numberWithDouble:((double)numberHappy / (double)followers.count) * 100.0] forKey:@"percentHappy"];
    [result setObject:[NSNumber numberWithDouble:((double)numberSad / (double)followers.count) * 100.0] forKey:@"percentSad"];
                              
    return result;
    
}

@end
