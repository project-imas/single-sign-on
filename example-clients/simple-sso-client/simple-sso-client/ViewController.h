//
//  ViewController.h
//  simple-sso-client
//
//  Created by Black, Gavin S. on 12/18/13.
//  Copyright (c) 2013 Black, Gavin S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)logoutButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *hashArea;
- (IBAction)exitButton:(id)sender;

@end
