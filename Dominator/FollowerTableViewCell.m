//
//  FollowerTableViewCell.m
//  Dominator
//
//  Created by Christophides, A. J. on 10/03/2016.
//  Copyright © 2016 The Dominator Company. All rights reserved.
//

#import "FollowerTableViewCell.h"
#import "TwitterObject.h"

@interface FollowerTableViewCell ()

@property (nonatomic, strong) IBOutlet UIImageView *profilePic;
@property (nonatomic, strong) IBOutlet UIImageView *happinessImageView;
@property (nonatomic, strong) IBOutlet UILabel *followerName;

@end

@implementation FollowerTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(TwitterObject *)twitterObj
{
    
}

@end
