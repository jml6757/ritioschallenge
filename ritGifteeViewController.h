//
//  ritGifteeViewController.h
//  ritioschallenge
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ritGifteeViewController : UITableViewController <UIActionSheetDelegate>
- (IBAction)addGiftee:(id)sender;
- (IBAction)unwindToGifteeViewController:(UIStoryboardSegue *)unwindSegue;
- (IBAction)unwindToGifteeViewControllerWithInfo:(UIStoryboardSegue *)unwindSegue;
@end
