//
//  ritGifteeViewController.h
//  ritioschallenge
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ritDatabaseManager.h"

@interface ritGifteeViewController : UITableViewController <UIActionSheetDelegate>

    - (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath;
    - (IBAction)addGiftee:(id)sender;
    - (IBAction)unwindToGifteeViewController:(UIStoryboardSegue *)unwindSegue;
    - (IBAction)unwindToGifteeViewControllerWithInfo:(UIStoryboardSegue *)unwindSegue;

    @property ritDatabaseManager* dbManager;
    @property NSString* selectedContact;

@end
