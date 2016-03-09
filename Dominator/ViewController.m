//
//  ViewController.m
//  Dominator
//
//  Created by Christophides, A. J. on 9/03/2016.
//  Copyright © 2016 The Dominator Company. All rights reserved.
//

#import "ViewController.h"
#import "TwitterObject.h"
#import "HappinessViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *twitterNameTextField;

@property (nonatomic, strong) TwitterObject *twitterResponse;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.navigationItem setTitle:@"Dominator"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.0/255.0 green:125.0/255.0 blue:186.0/255. alpha:1.0f]}];
    
    [self.twitterNameTextField setText:@"@"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)getTwitterFollwers
{
    NSURL *URL = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      NSError *error1;
                                      NSMutableDictionary * jsonResponse = [NSJSONSerialization
                                                                         JSONObjectWithData:data options:kNilOptions error:&error1];
                                      
                                      self.twitterResponse.jsonResponse = jsonResponse;
                                      HappinessViewController *happyVC = [[HappinessViewController alloc]init];
                                      happyVC.twitterObject = self.twitterResponse;
                                      [self.navigationController pushViewController:happyVC animated:YES];
                                  }];
    
    [task resume];
}


@end
