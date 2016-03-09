//
//  HappinessViewController.m
//  Dominator
//
//  Created by Christophides, A. J. on 9/03/2016.
//  Copyright © 2016 The Dominator Company. All rights reserved.
//

#import "HappinessViewController.h"
#import "TwitterObject.h"

@interface HappinessViewController ()

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
    double happyPercent = 70.0f;
    double sadPercent = 30.0f;
    
    CGFloat happyBarWidth = ((self.view.frame.size.width - 85) / 100.0) * happyPercent;
    CGFloat sadBarWidth = ((self.view.frame.size.width - 85) / 100.0) * sadPercent;
    
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

@end
