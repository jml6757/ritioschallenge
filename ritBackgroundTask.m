//
//  ritBackgroundTask.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritBackgroundTask.h"
#import "ritRemoteDataManager.h"

@implementation ritBackgroundTask

-(id) init
{
    return self;
}

-(void) waitQueue
{
    
}

-(void) signalQueue
{
    
}

-(void) setContact
{
    
}

-(ritProduct*) getSuggestion

{
    ritProduct* retVal = [_suggestionQueue head];
    [_suggestionQueue pop];
    return retVal;
}

-(NSMutableArray*) getFavorites
{
    return _favoriteArray;
}

+ (ritBackgroundTask*) getInstance
{
    static ritBackgroundTask *instance;
    
    @synchronized(self)
    {
        if (!instance)
            instance = [[ritBackgroundTask alloc] init];
        return instance;
    }
}

-(void) run
{
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    while(1)
    {
        if(_contact != nil)
        {
            if([_suggestionQueue count] < 10)
            {
                [_suggestionQueue addObjectsFromArray:[[ritRemoteDataManager getInstance] getSuggestions:_contact]];
            }
            else
            {
                dispatch_semaphore_wait(sem, 100);
            }
        }
    }
}

@end
