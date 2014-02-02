//
//  ritProduct.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritProduct.h"

@implementation ritProduct

-(id) init
{
    _dict = [[NSMutableDictionary alloc] init];
    return self;
}

-(id) initWithData:(NSString*) data
{
    _dict = [[NSMutableDictionary alloc] init];
    [self parseResponse:data];
    return self;
}

-(void) parseResponse:(NSString*)data
{
    NSArray* pair;
    NSArray* mapping = [data componentsSeparatedByString:@"|"];
    for(int i = 0; i < [mapping count]; ++i)
    {
        pair = [mapping[i] componentsSeparatedByString:@"="];
        [_dict setObject:pair[1] forKey:pair[0]];
    }
    NSLog(@"YOU GOT DICKED: %@", _dict);
}

-(NSString*)  ASIN
{
    return [_dict valueForKey:@"ASIN"];
}

-(NSString*)  name
{
    return [_dict valueForKey:@"name"];
}

-(NSString*)  price
{
    return [_dict valueForKey:@"price"];
}

-(NSString*)  productLink
{
    return [_dict valueForKey:@"productLink"];
}

-(NSString*)  imageLink
{
    return [_dict valueForKey:@"imageLink"];
}

-(NSString*)  rating
{
    return [_dict valueForKey:@"rating"];
}

@end
