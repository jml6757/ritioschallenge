//
//  ritShopScreenViewController.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 1/31/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ritProduct.h"
@interface ritShopScreenViewController : UIViewController

    @property IBOutlet NSString* contact;
    @property __block ritProduct* currentlyShowing;
    @property NSMutableArray* suggestions;
    - (IBAction)unwindToShopScreenViewController:(UIStoryboardSegue *)unwindSegue;
    -(IBAction)handleCheckButton:(id) sender;
    @property UIImageView *iv;

@end
