//
//  ritRemoteDataManager.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritRemoteDataManager.h"

@implementation ritRemoteDataManager

#define SERVER @"http://129.21.148.40:8080/AmazonIntelliBack/rest/iosInformationService"

- (id)init
{
    UIDevice* device = [[UIDevice alloc] init];
    _appId =[[device identifierForVendor] UUIDString];
    return self;
}

- (NSData*) serverRequest:(NSString*)request withContact:(NSString*)contact withAttributes:(NSString*)data
{
    //Build the URL string
    NSString* urlstr = [[NSString alloc] initWithFormat:@"%@/%@/%@|%@|%@",
                        SERVER, request, _appId, contact, data];
    
    //Log generated URL
    NSLog(@"%@", urlstr);
    
    //Create URL object
    NSURL *url = [NSURL URLWithString:urlstr];
    
    //Get URL data response
    NSData *retdata = [NSData dataWithContentsOfURL:url];
    return retdata;
}

- (void) postContact:    (NSString*) contact withAttributes:(NSMutableArray*) attributes
{
    NSString* attr = [[NSString alloc] initWithFormat:@"%@", @"OTHERDATA"];
    [self serverRequest:@"POSTContact" withContact:contact withAttributes:attr];
}

- (void) postYesOrNo:    (NSString*) contact withYesOrNo:(BOOL) yesOrNo
{
    NSString* attr = [[NSString alloc] initWithFormat:@"%@", @"OTHERDATA"];
    [self serverRequest:@"POSTYesorno" withContact:contact withAttributes:attr];
}

- (void) postFavorite:   (NSString*) contact withFavorite:(NSString*) favorite
{
    NSString* attr = [[NSString alloc] initWithFormat:@"%@", @"OTHERDATA"];
    [self serverRequest:@"POSTFavorite" withContact:contact withAttributes:attr];
}

- (NSMutableArray*) getSuggestions: (NSString*) contact
{
    NSString* attr = [[NSString alloc] initWithFormat:@"%@", @"OTHERDATA"];
    NSData *data = [self serverRequest:@"GETSuggestion" withContact:contact withAttributes:@"HarryPotter"];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ret=%@", ret);

    return nil;
}

- (NSMutableArray*) getFavorites:   (NSString*) contact
{
    return nil;
}

- (NSMutableArray*) getAttributes:  (NSString*) contact
{
    return nil;
}

@end
