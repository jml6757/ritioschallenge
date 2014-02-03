//
//  ritShopScreenViewController.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 1/31/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritShopScreenViewController.h"
#import "ritRemoteDataManager.h"
#import "ritBackgroundTask.h"
#import "ritProfileViewController.h"
@implementation ritShopScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)handleCheckButton:(id) sender{
    [[ritRemoteDataManager getInstance] postYesOrNo:_contact withASIN:[_currentlyShowing ASIN] withYesOrNo:YES];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                         ^{
                             _suggestions = [[ritRemoteDataManager getInstance] getSuggestions:_contact];
                         });
    
    dispatch_group_notify(group, dispatch_get_main_queue(),
                          ^{
                              _currentlyShowing = [_suggestions objectAtIndex:0];
                              [_suggestions pop];
                              [self setData:_currentlyShowing];
                          });
    NSLog(@"CheckButtonPressed: %@", @"hhig");
}

-(IBAction)handleCrossButton:(id) sender{
    [[ritRemoteDataManager getInstance] postYesOrNo:_contact withASIN:[_currentlyShowing ASIN] withYesOrNo:NO];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                         ^{
                             _suggestions = [[ritRemoteDataManager getInstance] getSuggestions:_contact];
                         });
    
    dispatch_group_notify(group, dispatch_get_main_queue(),
                          ^{
                              _currentlyShowing = [_suggestions objectAtIndex:0];
                              [_suggestions pop];
                              [self setData:_currentlyShowing];
                          });
    NSLog(@"CheckButtonPressed: %@", @"hhig");
}

-(IBAction)handlegiftButton:(id) sender{
    [[ritRemoteDataManager getInstance] postFavorite:_contact withASIN:[_currentlyShowing ASIN]];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                         ^{
                             _suggestions = [[ritRemoteDataManager getInstance] getSuggestions:_contact];
                         });
    
    dispatch_group_notify(group, dispatch_get_main_queue(),
                          ^{
                              _currentlyShowing = [_suggestions objectAtIndex:0];
                              [_suggestions pop];
                              [self setData:_currentlyShowing];
                          });}

-(IBAction)gotoLink:(id) sender{
    NSURL *url = [NSURL URLWithString:_currentlyShowing.productLink];
    [[UIApplication sharedApplication] openURL:url];
    NSLog(@"CheckButtonPressed: %@", @"hhig");
}
-(void) setData:(ritProduct*) product
{
    double delayInSeconds = 0.74;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
    {
        
    });
    //Add Image on bottom layer
	NSURL *url = [NSURL URLWithString:[product imageLink]];
	NSData *data = [NSData dataWithContentsOfURL:url];
	UIImage *image = [[UIImage alloc] initWithData:data];
    
	[_iv setImage:image];
    
    [_iv setFrame:CGRectMake(0,40,self.view.frame.size.width,self.view.frame.size.height-80)];
    
	_iv.contentMode =UIViewContentModeScaleAspectFit;

    [self.view addSubview:_iv];
    
    //Add check button
    UIButton* checkButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [checkButton setFrame:CGRectMake(0, self.view.frame.size.height-100, 75, 75)];
    UIImage* checkImage = [UIImage imageNamed:@"/gift_yes.png"];
    [checkButton setImage:checkImage forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(handleCheckButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkButton];
   
    //Add x button
    UIButton* crossButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [crossButton setFrame:CGRectMake(self.view.frame.size.width-75, self.view.frame.size.height-100, 75, 75)];
    UIImage* crossImage = [UIImage imageNamed:@"/gift_no.png"];
    [crossButton setImage:crossImage forState:(UIControlStateNormal)];
    [crossButton addTarget:self action:@selector(handleCrossButton:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:crossButton];
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLink:)];
    _iv.userInteractionEnabled = YES;
    [_iv addGestureRecognizer:recognizer];
    
    //Add favorite button
    UIButton* giftButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [giftButton setFrame:CGRectMake((self.view.frame.size.width/2)-38, self.view.frame.size.height-100, 75, 75)];
    UIImage* giftImage = [UIImage imageNamed:@"/appiconResized.png"];
    [giftButton setImage:giftImage forState:(UIControlStateNormal)];
    [giftButton addTarget:self action:@selector(handlegiftButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:giftButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	_iv = [[UIImageView alloc] initWithFrame:CGRectMake(0,40,self.view.frame.size.width,self.view.frame.size.height-80)];
    
    //NSLog(@"%@", _sender);
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [[ritBackgroundTask getInstance] run]; // 1
//    });
//    
//    NSMutableArray* suggestions = [[ritRemoteDataManager getInstance] getSuggestions:_contact];
//    ritProduct* prod = suggestions[0];
//    NSLog(@"%@", [prod dict]);
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
    ^{
        _suggestions = [[ritRemoteDataManager getInstance] getSuggestions:_contact];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(),
    ^{
        _currentlyShowing = [_suggestions objectAtIndex:0];
        [_suggestions pop];
        [self setData:_currentlyShowing];
    });

    //dispatch_release(group);
    
    
    self.title = _contact;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"ProfileViewSegue"])
    {
        NSLog(@"!!!!!");
        ritProfileViewController *sequeView = (ritProfileViewController*)[(UINavigationController*)segue.destinationViewController topViewController];
       sequeView.contact = _contact;
    }
}

- (IBAction)unwindToShopScreenViewController:(UIStoryboardSegue *)unwindSegue
{
    /*
-(IBAction)setbackImage
{
        
}
     */
}

@end
