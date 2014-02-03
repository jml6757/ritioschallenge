//
//  ritProfileViewController.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritProfileViewController.h"
#import "ritRemoteDataManager.h"
#import "ritProduct.h"

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
    NSArray *strs =      [NSArray arrayWithObjects:   @"10",
                          @"3",
                          @"3",
                          @"7",
                          @"5",
                          @"6",
                          @"7",
                          @"3",
                          nil];
    
    NSArray *strs1 =      [NSArray arrayWithObjects:  @"Electronics",
                           @"Reading",
                           @"Toys",
                           @"Sports",
                           @"Movies",
                           @"Music",
                           @"Fashion",
                           @"Cooking",
                           nil];
    
    // UIGravityBehavior* gravity = [[UIGravityBehavior alloc] init];
    //[gravity setGravityDirection:CGVectorMake(-1, 0)];
    
    for(int i = 0; i < [strs count]; ++i)
    {
        //Create Labels
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i*40-30, 170.0f, 100, 50)];
        [label setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        label.textColor = [UIColor lightGrayColor];
        label.text = strs1[i];
        
        
        //Create Graphs
        NSString* attr_str = strs[i];
        int max_height = [attr_str intValue]*7;
        UIView *bar = [[UIView alloc] initWithFrame:CGRectMake(i*40+10, 150.0f, 20.0f, 0.0f)];
        [bar setBackgroundColor:[UIColor redColor]];
        [UIView animateWithDuration:1.25 animations:^{
            [bar setCenter:CGPointMake(i*40+20, 150.0f-max_height/2)];
            [bar setBounds:CGRectMake(i*40+10, 150.0f, 20.0f, max_height)];
        }];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [bar addGestureRecognizer:tapRecognizer];
        [self.view addSubview:label];
        [self.view addSubview:bar];    /*
                                        UIView* square = [[UIView alloc] initWithFrame:
                                        CGRectMake(100, 100, 100, 100)];
                                        square.backgroundColor = [UIColor grayColor];
                                        [self.view addSubview:square];
                                        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
                                        [gravity addItem:square];
                                        [_animator addBehavior:gravity];
                                        
                                        */
        // Do any additional setup after loading the view, typically from a nib.
       
        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:scrollView];
        UITapGestureRecognizer *viewresults = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewresults:)];
        
        [scrollView addGestureRecognizer:viewresults];

        NSMutableArray * Favs =[[ritRemoteDataManager getInstance] getFavorites:_contact];
        for(ritProduct * fav in Favs){
            
            NSLog(@"%@",fav.title);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [btn setTitle:[fav title] forState:UIControlStateNormal];
            [btn setFrame:CGRectMake(0,0 , 100, 100)];
            [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:btn];
            
        }
    //Create new button
    UIBarButtonItem *rButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(exitProfileViewController)];
    
    //Add button to navigation menu
    self.navigationItem.leftBarButtonItem=rButton;
}
    
}
-(IBAction)action:(id)sender{
    NSLog(@"%@", @"hello");

}
-(IBAction)tapped:(id)sender{
    NSLog(@"%@", @"hello");
}
-(IBAction)viewresults:(id)sender{
    NSLog(@"%@", @"Hi");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end