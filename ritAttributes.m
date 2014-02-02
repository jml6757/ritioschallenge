//
//  ritAttributes.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritAttributes.h"

@implementation ritAttributes

-(id) init
{
    _dict = [[NSMutableDictionary alloc] init];
    return self;
}

-(id) getAttribute:(NSString*) attr
{
    return [_dict objectForKey:attr];
}

-(void) setAttribute:(NSString*) attr withValue:(NSString*)val
{
    
    [_dict setObject:val forKey:attr];
}

@end
