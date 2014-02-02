//
//  ritNewContactViewController.m
//  ritioschallenge
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritNewContactViewController.h"

@interface ritNewContactViewController ()

@end

@implementation ritNewContactViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)sliderAction:(id)sender
{
    float value = [sender floatValue];
    NSLog(@"%f", value);
    //-- Do further actions
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
    CGRect rectangle = CGRectMake(20, 150, fullScreenRect.size.width-20, fullScreenRect.size.height);
    UIScrollView *scroll=[[UIScrollView alloc] initWithFrame:rectangle];
    scroll.contentSize=CGSizeMake(200,600);
    UISlider* slider;
    for (int i = 0; i< 11; ++i) {
        rectangle = CGRectMake(fullScreenRect.size.width/2,i*40, 100, 100);
        slider = [[UISlider alloc] initWithFrame:rectangle];
        [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.minimumValue = 0.0;
        slider.maximumValue = 10.0;
        slider.continuous = YES;
        slider.value = 5.0;
        [scroll addSubview:slider];
    }
    
    // do any further configuration to the scroll view
    // add a view, or views, as a subview of the scroll view.
    // release scrollView as self.view retains it
    [self.view addSubview:scroll];
    
    //self.scrollView.contentSize =CGSizeMake(320, 700);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
