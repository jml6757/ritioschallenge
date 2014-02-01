//
//  ritShopScreenViewController.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 1/31/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ritShopScreenViewController : UIViewController

    @property IBOutlet NSString* contact;

    - (IBAction)unwindToShopScreenViewController:(UIStoryboardSegue *)unwindSegue;

@end
