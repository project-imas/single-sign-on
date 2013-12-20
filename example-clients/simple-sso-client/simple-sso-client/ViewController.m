//
//  ViewController.m
//  simple-sso-client
//
//  Created by Black, Gavin S. on 12/18/13.
//  Copyright (c) 2013 Black, Gavin S. All rights reserved.
//

#import "ViewController.h"
#import "ssoClient.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSString* ssoHash = [ssoClient fetchHash:@"imasSimpleSSOClient"];
    NSLog(@"%@",ssoHash);
    [[self hashArea] setText:ssoHash];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButton:(id)sender {
    [ssoClient logout];
    exit(0);
}
- (IBAction)exitButton:(id)sender {

    exit(0);
}
@end
