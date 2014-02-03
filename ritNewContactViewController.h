//
//  ritNewContactViewController.h
//  ritioschallenge
//
//  Created by Student on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ritAttributes.h"

@interface ritNewContactViewController : UIViewController <UITextFieldDelegate>

    -(IBAction)sliderAction:(id)sender;
    @property (weak, nonatomic) IBOutlet UITextField *contactName;
    @property (strong, nonatomic) IBOutlet ritAttributes* contactAttr;

@end
