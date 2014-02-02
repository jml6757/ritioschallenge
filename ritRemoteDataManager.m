//
//  ritRemoteDataManager.m
//  ritioschallenge
//
//  Created by Kassaundra Porres on 2/1/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "ritRemoteDataManager.h"
#import "ritAttributes.h"
#import "ritProduct.h"

@implementation ritRemoteDataManager

#define SERVER @"http://129.21.148.40:8080/AmazonIntelliBack/rest/iosInformationService"

- (id)init
{
    //UIDevice* device = [[UIDevice alloc] init];
    _appId = @"0";//[[device identifierForVendor] UUIDString];
    return self;
}

- (void)serverPost:(NSString*)requestType withData:(NSString*)data
{
    //Format URL and data
    NSString *url = [[NSString alloc] initWithFormat:@"%@/%@/", SERVER, requestType];
    NSData *postData = [data dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    //Format request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //Make request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (NSString*) serverGet:(NSString*)requestType withData:(NSString*)data
{
    //Format URL
    NSString *urlstr = [[NSString alloc] initWithFormat:@"%@/%@/%@", SERVER, requestType, data];
    NSURL *url = [[NSURL alloc] initWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    //Format Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [request setHTTPMethod:@"GET"];
    
    //Get response
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    //Return in string form
    NSString* ret = [[NSString alloc] initWithData:response encoding:NSASCIIStringEncoding];
    return ret;
}

- (NSString*)formatData: (NSString*)contact withKeys:(NSMutableArray*)keys withVals:(NSMutableArray*)vals
{
    NSMutableString* data = [[NSMutableString alloc] init];
    [data appendFormat:@"%@", _appId];
    [data appendFormat:@"|%@", contact];
    for (int i = 0; i < [keys count]; ++i) {
        [data appendFormat:@"|%@=%@", [keys objectAtIndex:i], [vals objectAtIndex:i]];
    }
    return data;
}

- (void) postContact: (NSString*) contact withAttributes:(ritAttributes*) attributes
{
    NSLog(@"Posting Contact");
    NSMutableArray* keys = [[NSMutableArray alloc] init];
    [keys addObjectsFromArray:[[attributes dict] allKeys]];
    
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    for(int i = 0; i < [keys count]; ++i) [vals addObject:[attributes getAttribute:[keys objectAtIndex:i]]];
    
    NSString* post = [self formatData:contact withKeys:keys withVals:vals];
    [self serverPost:@"POSTPerson" withData:post];
}

- (void) postYesOrNo: (NSString*) contact withYesOrNo:(BOOL) yesOrNo
{
    NSLog(@"Posting YesOrNo");
    NSMutableArray* keys = [[NSMutableArray alloc] init];
    [keys addObject:@"key0"];
    [keys addObject:@"key1"];
    
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    [vals addObject:@"0"];
    [vals addObject:@"1"];
    
    NSString* post = [self formatData:contact withKeys:keys withVals:vals];
    [self serverPost:@"POSTYesOrNo" withData:post];
}

- (void) postFavorite: (NSString*) contact withFavorite:(NSString*) favorite
{
    NSLog(@"Posting Favorite");
    NSMutableArray* keys = [[NSMutableArray alloc] init];
    [keys addObject:@"key"];
    
    NSMutableArray* vals = [[NSMutableArray alloc] init];
    [vals addObject:@"0"];
    
    NSString* post = [self formatData:contact withKeys:keys withVals:vals];
    [self serverPost:@"POSTFavorite" withData:post];
}

- (NSString*) getSuggestions: (NSString*) contact
{
    NSLog(@"Getting Suggestions");
    NSString* tx_data = [self formatData:contact withKeys:nil withVals:nil];
    return [self serverGet:@"GETSuggestions" withData:tx_data];
}

- (NSString*) getFavorites:   (NSString*) contact
{
    NSLog(@"Getting Favorites");
    NSString* tx_data = [self formatData:contact withKeys:nil withVals:nil];
    return [self serverGet:@"GETFavorites" withData:tx_data];

}

- (NSString*) getAttributes:  (NSString*) contact
{
    NSLog(@"Getting Attributes");
    NSString* tx_data = [self formatData:contact withKeys:nil withVals:nil];
    NSString* d = [self serverGet:@"GETAttributes" withData:tx_data];
    NSLog(@"%@", d);
    return d;

}

@end
