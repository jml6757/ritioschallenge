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
        
        //Initialize the contacts array
        _contacts = [[NSMutableArray alloc] init];
        
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
            //This means the database doesn't exist
            
            const char *dbpath = [_dbPath UTF8String];
            
            if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
            {
                char *errMsg;
                const char *sql_stmt ="CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT)";
                if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
                {
                    //Database was not created
                }
            }
        }
        else
        {
            //This means the database already exists so a new one does not need to be created
        }
        NSLog(@"Reading contact DB\n");
        [self readDbContacts];
    }
    return self;
}

- (void) addContact: (NSString*) contact
{
    sqlite3_stmt *statement;
    const char *path = [_dbPath UTF8String];
    
    if (sqlite3_open(path, &_contactDB) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO CONTACTS (name) VALUES (\"%@\")",contact];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            //Successfully added
            [_contacts addObject:contact];
        }
        else
        {
            //Addition failed
        }
        sqlite3_finalize(statement);
        sqlite3_close(_contactDB);
    }
}

- (void) deleteContact: (NSString*) contact
{
    const char *path = [_dbPath UTF8String];
    sqlite3_stmt *statement;
    
    if (sqlite3_open(path, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"DELETE FROM contacts WHERE name=\"%@\"", contact];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
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
    [_contacts removeObject:contact];
}

- (BOOL) hasContact: (NSString*) contact
{
    const char *path = [_dbPath UTF8String];
    sqlite3_stmt *statement;
    BOOL retVal = NO;
    
    if (sqlite3_open(path, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT name FROM contacts WHERE name=\"%@\"", contact];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //Name found
                retVal = YES;
            } else {
                //Name not found
                retVal = NO;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return retVal;
}

- (void) readDbContacts
{
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
                NSString *loadedContact = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];

                NSLog(@"%@\n", loadedContact);
                [_contacts addObject:loadedContact];
            } 
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
}

- (int) getContactID:   (NSString*) contact
{
    const char *path = [_dbPath UTF8String];
    sqlite3_stmt *statement;
    int retVal = 0;
    
    if (sqlite3_open(path, &_contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT id FROM contacts WHERE name=\"%@\"", contact];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(_contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //Name found
                NSString *contactId = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                retVal = [contactId intValue];
            } else {
                //Name not found
                retVal = 0;
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(_contactDB);
    }
    return retVal;
}

@end
