//
//  ritNewContactViewController.m
//  ritioschallenge
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritNewContactViewController.h"
#import "ritRemoteDataManager.h"

@interface ritNewContactViewController ()

@end

@implementation ritNewContactViewController

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"YOUR_SEGUE_NAME_HERE"])
    {
        //[segue destinationViewController];
        
        [[ritRemoteDataManager getInstance] postContact:_contactName.text withAttributes:nil];
    }
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    NSString *numberString = [NSString stringWithFormat:@"%d",lroundf(sender.value)];
    NSString *attributeString = sender.restorationIdentifier;
    [_contactAttr setAttribute:attributeString withValue:numberString];
}

-(void)dismissKeyboard {
    [_contactName resignFirstResponder];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(dismissKeyboard)];
//    
//    [self.view addGestureRecognizer:tap];
    
    [_contactName resignFirstResponder];
    _contactAttr = [[ritAttributes alloc] init];
    CGRect fullScreenRect=[[UIScreen mainScreen] applicationFrame];
    CGRect srectangle;
    CGRect lrectangle;
    UISlider* slider;
    UILabel* label;
    NSArray* values = [NSArray arrayWithObjects:
                       @"toys",
                       @"reading",
                       @"electronics",
                       @"sports",
                       @"movies",
                       @"music",
                       @"fashion",
                       @"cooking",
                       nil
                       ];
    for (int i = 0; i< 8; ++i) {
        
        //Create rectangle to hold slider
        lrectangle = CGRectMake(20,(fullScreenRect.size.height/3)+(i*40), fullScreenRect.size.width, 34);
        
        //Create rectangle to hold label
        srectangle = CGRectMake(fullScreenRect.size.width/2,(fullScreenRect.size.height/3)+(i*40), 118, 34);

        //Create slider
        slider = [[UISlider alloc] initWithFrame:srectangle];
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [slider setBackgroundColor:[UIColor clearColor]];
        slider.minimumValue = 0.0;
        slider.maximumValue = 10.0;
        slider.continuous = NO;
        slider.value = 5.0;
        slider.restorationIdentifier=values[i];
        
        //Create label
        label = [[UILabel alloc] initWithFrame:lrectangle];
        [label setText:values[i]];
        
        //Add label to view
        [self.view addSubview:label];
        
        //Add slider to view
        [self.view addSubview:slider];
    }
    
    // do any further configuration to the scroll view
    // add a view, or views, as a subview of the scroll view.
    // release scrollView as self.view retains it
    
    //self.scrollView.contentSize =CGSizeMake(320, 700);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
