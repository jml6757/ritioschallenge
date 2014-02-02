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
