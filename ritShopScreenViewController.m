//
//  ritShopScreenViewController.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 1/31/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritShopScreenViewController.h"

@implementation ritShopScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSLog(@"%@", _sender);
    self.title = _contact;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToShopScreenViewController:(UIStoryboardSegue *)unwindSegue
{
}

@end
