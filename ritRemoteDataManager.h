//
//  ritRemoteDataManager.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ritAttributes.h"

#define KEY_VAL_TOKEN @"|"
#define ATTR_TOKEN    @"="
#define PROD_TOKEN    @"="

@interface ritRemoteDataManager : NSObject

    - (id)init;

    - (void)serverPost:      (NSString*)requestType withData:(NSString*)data;
    - (NSString*) serverGet: (NSString*)requestType withData:(NSString*)data;

    - (void) postContact:        (NSString*) contact withAttributes:(ritAttributes*) attributes;
    - (void) postYesOrNo:        (NSString*) contact withASIN:(NSString*) ASIN withYesOrNo:(BOOL) yesOrNo;
    - (void) postFavorite:       (NSString*) contact withASIN:(NSString*) ASIN;
    - (void) postFavoriteDelete: (NSString*) contact withASIN:(NSString*) ASIN;

    - (NSMutableArray*) getSuggestions: (NSString*) contact;
    - (NSMutableArray*) getFavorites:   (NSString*) contact;
    - (ritAttributes*)  getAttributes:  (NSString*) contact;

    - (ritAttributes*)  parseAttributeData:  (NSString*) data;
    - (NSMutableArray*) parseProductData:    (NSString*) data;

    @property NSString* appId;

@end
