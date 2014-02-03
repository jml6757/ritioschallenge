//
//  ritBackgroundTask.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ritProduct.h"
#import "ritQueue.h"

@interface ritBackgroundTask : NSObject

-(void) waitQueue;
-(void) signalQueue;

-(ritProduct*) getSuggestion;
-(NSMutableArray*) getFavorites;

+(ritBackgroundTask*) getInstance;

-(void) run;

@property NSMutableArray* suggestionQueue;
@property NSMutableArray* favoriteArray;
@property NSString* contact;

@end
