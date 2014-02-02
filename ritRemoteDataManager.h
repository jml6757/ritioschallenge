//
//  ritRemoteDataManager.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ritRemoteDataManager : NSObject

    - (id)init;

    - (void)serverPost:      (NSString*)requestType withData:(NSString*)data;
    - (NSString*) serverGet: (NSString*)requestType withData:(NSString*)data;

    - (NSString*)formatData:  (NSString*)contact withKeys:(NSMutableArray*)keys withVals:(NSMutableArray*)vals;

    - (void) postContact:    (NSString*) contact withAttributes:(NSMutableArray*) attributes;
    - (void) postYesOrNo:    (NSString*) contact withYesOrNo:(BOOL) yesOrNo;
    - (void) postFavorite:   (NSString*) contact withFavorite:(NSString*) favorite;

    - (NSString*) getSuggestions: (NSString*) contact;
    - (NSString*) getFavorites:   (NSString*) contact;
    - (NSString*) getAttributes:  (NSString*) contact;

    @property NSString* appId;

@end
