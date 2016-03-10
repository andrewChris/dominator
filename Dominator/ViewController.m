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
#import "TwitterJSONParser.h"
#import "MBProgressHUD.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *twitterNameTextField;

@property (nonatomic, strong) TwitterObject *twitterResponse;

- (IBAction)getTwitterFollowers:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    [self.navigationItem setTitle:@"Dominator"];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.0/255.0 green:125.0/255.0 blue:186.0/255. alpha:1.0f]}];
    
    [self.twitterNameTextField setText:@"@Dain_IBM"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)getTwitterFollowers:(id)sender
{
    NSString *URLString = [NSString stringWithFormat:@"http://dain-twitter.mybluemix.net/?id=%@", self.twitterNameTextField.text];
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    HappinessViewController *happyVC = (HappinessViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"happinessVC"];
//    happyVC.twitterObject = self.twitterResponse;
//    //happyVC.followers = followers;
//    [self.navigationController pushViewController:happyVC animated:YES];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      NSError *error1;
                                      NSMutableDictionary * jsonResponse = [NSJSONSerialization
                                                                         JSONObjectWithData:data options:kNilOptions error:&error1];
                                      
                                      NSDictionary *followers = [TwitterJSONParser parseTwitterJSON:jsonResponse];
                                      
                                      self.twitterResponse.jsonResponse = jsonResponse;
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                         
                                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                                          HappinessViewController *happyVC = (HappinessViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"happinessVC"];
                                          happyVC.twitterObject = self.twitterResponse;
                                          happyVC.followers = followers;
                                          [self.navigationController pushViewController:happyVC animated:YES];
                                          
                                      });
                                      
                                  }];
    
    [task resume];
}


@end
