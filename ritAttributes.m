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

-(void) parseResponse:(NSString*)data
{
    NSArray* pair;
    NSArray* mapping = [data componentsSeparatedByString:@"|"];
    for(int i = 0; i < [mapping count]; ++i)
    {
        pair = [mapping[i] componentsSeparatedByString:@"="];
        [self setAttribute:pair[0] withValue:pair[1]];
    }
    NSLog(@"YOU GOT DICKED: %@", _dict);
}
/*
 map.put("electronics", 0);
 map.put("reading", 0);
 map.put("travelling", 0);
 map.put("sports", 0);
 map.put("video games", 0);
 map.put("movies", 0);
 map.put("music", 0);
 map.put("fashion", 1);
 map.put("cooking", 1);
 map.put("art", 1);
 map.put("toys", 0);
 */

@end
