//
//  ritAttributes.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ritAttributes : NSObject

    @property NSMutableDictionary* dict;

    -(id)   init;
    -(id)   getAttribute:(NSString*) attr;
    -(void) setAttribute:(NSString*) attr withValue:(NSString*)val;

@end
