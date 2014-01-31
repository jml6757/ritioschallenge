//
//  ritDatabaseManager.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 1/30/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritDatabaseManager.h"

@implementation ritDatabaseManager

- (id)init
{
    self = [super init];
    if (self) {
        NSString *docsDir;
        NSArray *dirPaths;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        docsDir = dirPaths[0];
        
        // Build the path to the database file
        _dbPath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"contacts.db"]];
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
        
        if ([filemgr fileExistsAtPath: _dbPath ] == NO)
        {
            const char *dbpath = [_dbPath UTF8String];
            
            if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
            {
                char *errMsg;
                const char *sql_stmt =
                "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT)";
            }
        }
    }
    return self;
}

- (IBAction) addContact:(id)sender
{
    sqlite3_stmt *statement;
    const char *path = [_dbPath UTF8String];
    
    if (sqlite3_open(path, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO CONTACTS (name) VALUES (\"%@\")", _name.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            //Successfully added
        }
        else
        {
            //Addition failed
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
}

- (IBAction) deleteContact: (id) sender
{
    const char *path = [_dbPath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(path, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"DELETE FROM contacts WHERE name=\"%@\"", _name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //Name found
            } else {
                //Name not found
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

- (IBAction) getContact: (id) sender
{
    const char *path = [_dbPath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(path, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT name FROM contacts WHERE name=\"%@\"", _name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //Name found
            } else {
                //Name not found
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

- (IBAction) getAllContacts: (id) sender
{
    {
        NSMutableArray *contacts;
        // setup the reminders array
        contacts = nil;
        contacts = [[NSMutableArray alloc] init];
        
        //Retrieve the values of database
        const char *path = [self.dbPath UTF8String];
        sqlite3_stmt *statement;
        if (sqlite3_open(path, &_contactDB) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM contacts"];
            
            const char *query_stmt = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(_contactDB ,query_stmt , -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    NSString *loadedContact = [[NSString alloc]
                                              initWithUTF8String:
                                              (const char *) sqlite3_column_text(
                                                                                 statement, 0)];

                    [contacts addObject:loadedContact];
                } 
                
                sqlite3_finalize(statement);
            }
            sqlite3_close(_contactDB);
        }
    }
}


@end
