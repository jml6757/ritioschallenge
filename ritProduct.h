//
//  ritProduct.h
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/2/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ritProduct : NSObject

    @property NSMutableDictionary* dict;

    -(id) init;

    -(NSString*)  ASIN;
    -(NSString*)  title;
    -(NSString*)  price;
    -(NSString*)  productLink;
    -(NSString*)  imageLink;
    -(NSString*)  rating;

@end
