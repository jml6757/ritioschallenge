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

    - (void) addContact:    (NSString*) contact;
    - (void) deleteContact: (NSString*) contact;
    - (void) readDbContacts;

    - (BOOL) hasContact:    (NSString*) contact;
    - (int) getContactID:   (NSString*) contact;

    //Path to the database
    @property (strong, nonatomic) NSString *dbPath;

    //Array of contact names (strings) which is accessible from outside
    @property (strong, nonatomic) IBOutlet NSMutableArray *contacts;

    //Database of contact names
    @property (nonatomic) sqlite3 *contactDB;

@end
