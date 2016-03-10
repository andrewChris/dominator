//
//  HappinessViewController.m
//  Dominator
//
//  Created by Christophides, A. J. on 9/03/2016.
//  Copyright © 2016 The Dominator Company. All rights reserved.
//

#import "HappinessViewController.h"
#import "FollowerCell.h"

@interface HappinessViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *happyBar;
@property (nonatomic, strong) IBOutlet UIView *sadBar;
@property (nonatomic, strong) IBOutlet UILabel *overviewLabel;
@property (nonatomic, strong) IBOutlet UILabel *happyLabel;
@property (nonatomic, strong) IBOutlet UILabel *sadLabel;
@property (nonatomic, strong) IBOutlet UITableView *tableview;

@end

@implementation HappinessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Happy or Sad?"];
    
    [self performSelector:@selector(animateGraph) withObject:nil afterDelay:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}

- (void)animateGraph
{
    double happyPercent = [[self.followers objectForKey:@"percentHappy"] doubleValue];
    double sadPercent = [[self.followers objectForKey:@"percentSad"] doubleValue];
    
    CGFloat happyBarWidth = ((self.view.frame.size.width - 115) / 100.0) * happyPercent;
    CGFloat sadBarWidth = ((self.view.frame.size.width - 115) / 100.0) * sadPercent;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        int count = 0;
        
        for (int i = 0; i <= happyPercent; i++) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.happyLabel.text = [NSString stringWithFormat:@"%d%% Happy", count];
                
            });
            
            [NSThread sleepForTimeInterval:(1.0/happyPercent)];
            
            count++;
            
        }
        
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        int count = 0;
        
        for (int i = 0; i <= sadPercent; i++) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.sadLabel.text = [NSString stringWithFormat:@"%d%% Sad", count];
                
            });
            
            [NSThread sleepForTimeInterval:(1.0/sadPercent)];
            
            count++;
            
        }
        
    });
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^ {
                         
                         //Happy
                         CGRect frame = self.happyBar.frame;
                         frame.size.width = happyBarWidth;
                         [self.happyBar setFrame:frame];
                         
                         CGRect happyLabelFrame = self.happyLabel.frame;
                         happyLabelFrame.origin.x += happyBarWidth;
                         self.happyLabel.frame = happyLabelFrame;
                         
                         //Sad
                         frame = self.sadBar.frame;
                         frame.size.width = sadBarWidth;
                         [self.sadBar setFrame:frame];
                         
                         CGRect sadLabelFrame = self.sadLabel.frame;
                         sadLabelFrame.origin.x += sadBarWidth;
                         self.sadLabel.frame = sadLabelFrame;
                         
                         
                     }completion:^(BOOL finished) {
                         
                     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowerCell *cell = (FollowerCell *)[tableView dequeueReusableCellWithIdentifier:@"followerCell"];
    
    NSArray *followersArray = [self.followers objectForKey:@"followers"];
    
    TwitterFollower *twitterFollower = [followersArray objectAtIndex:indexPath.row];

    NSData *data = [NSData dataWithContentsOfURL:twitterFollower.imageURL];
    UIImage *img = [[UIImage alloc] initWithData:data];
    
    [cell.profilePic]
    [cell.profilePic setImage:img];
    [cell.followerName setText:twitterFollower.name];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *followers = [self.followers objectForKey:@"followers"];
    
    return [followers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
