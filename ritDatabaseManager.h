//
//  ritDatabaseManager.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface ritDatabaseManager : NSObject


@property (strong, nonatomic) IBOutlet UITextField *name;

- (IBAction) addContact:(id)sender;
- (IBAction) deleteContact: (id) sender;
- (IBAction) getContact: (id) sender;
- (IBAction) getAllContacts: (id) sender;

@property (strong, nonatomic) NSString *dbPath;
@property (nonatomic) sqlite3 *contactDB;


@end
