//
//  ritProfileViewController.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritProfileViewController.h"

@implementation ritProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void) exitProfileViewController
{
    [self.parentViewController dismissModalViewControllerAnimated: YES ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create new button
    UIBarButtonItem *rButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(exitProfileViewController)];
    
    //Add button to navigation menu
    self.navigationItem.leftBarButtonItem=rButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
