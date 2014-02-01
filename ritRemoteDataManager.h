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

    - (NSData*) serverRequest:(NSString*)request withContact:(NSString*)contact withAttributes:(NSString*)data;

    - (void) postContact:    (NSString*) contact withAttributes:(NSMutableArray*) attributes;
    - (void) postYesOrNo:    (NSString*) contact withYesOrNo:(BOOL) yesOrNo;
    - (void) postFavorite:   (NSString*) contact withFavorite:(NSString*) favorite;

    - (NSMutableArray*) getSuggestions: (NSString*) contact;
    - (NSMutableArray*) getFavorites:   (NSString*) contact;
    - (NSMutableArray*) getAttributes:  (NSString*) contact;

    @property NSString* appId;

@end
