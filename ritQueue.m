//
//  ritQueue.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritQueue.h"

@implementation NSMutableArray (QueueAdditions)

- (id) head
{
    return [self objectAtIndex:0];
}

- (void) pop
{
    id headObject = [self objectAtIndex:0];
    if (headObject != nil) {
        [self removeObjectAtIndex:0];
    }
}

- (void) push:(id)anObject
{
    [self addObject:anObject];
}

@end
