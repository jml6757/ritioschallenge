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

- (NSString*)formatProductData: (NSString*)contact withOption:(NSString*) option
{
    NSMutableString* data = [[NSMutableString alloc] init];
    [data appendFormat:@"%@", _appId];
    [data appendFormat:@"|%@", contact];
    [data appendFormat:@"|%@", option];
    return data;
}

- (id)init
{
    //UIDevice* device = [[UIDevice alloc] init];
    _appId = @"0";//[[device identifierForVendor] UUIDString];
    return self;
}

+ (ritRemoteDataManager *) getInstance
{
    static ritRemoteDataManager *instance;
    
    @synchronized(self)
    {
        if (!instance)
            instance = [[ritRemoteDataManager alloc] init];
        return instance;
    }
}

- (void)serverPost:(NSString*)requestType withData:(NSString*)data
{
    //Format URL and data
    NSString *url = [[NSString alloc] initWithFormat:@"%@/%@/", SERVER, requestType];
    NSLog(@"POST URL: %@", url);
    NSLog(@"POST BODY: %@", data);
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
    NSLog(@"GET URL: %@", urlstr);
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

- (void) postYesOrNo: (NSString*) contact withASIN:(NSString*) ASIN withYesOrNo:(BOOL) yesOrNo
{
    NSLog(@"Posting YesOrNo");
    NSString* option = [[NSString alloc] initWithFormat:@"%@|%d", ASIN, yesOrNo ];
    NSString* post = [self formatProductData:contact withOption:option];
    [self serverPost:@"POSTYesOrNoInfo" withData:post];
}

- (void) postFavorite: (NSString*) contact withASIN:(NSString*) ASIN
{
    NSLog(@"Posting Favorite");
    NSString* option = ASIN;
    NSString* post = [self formatProductData:contact withOption:option];
    [self serverPost:@"POSTFavorite" withData:post];
}

- (void) postFavoriteDelete: (NSString*) contact withASIN:(NSString*) ASIN
{
    NSLog(@"Posting Favorite Delete");
    NSString* option = ASIN;
    NSString* post = [self formatProductData:contact withOption:option];
    [self serverPost:@"POSTFavoriteDelete" withData:post];
}

- (NSMutableArray*) getSuggestions: (NSString*) contact
{
    NSLog(@"Getting Suggestions");
    NSString* tx_data = [self formatData:contact withKeys:nil withVals:nil];
    NSString* rx_data =  [self serverGet:@"GETSuggestion" withData:tx_data];
    return [self parseProductData:rx_data];
}

- (NSMutableArray*) getFavorites:   (NSString*) contact
{
    NSLog(@"Getting Favorites");
    NSString* tx_data = [self formatData:contact withKeys:nil withVals:nil];
    NSString* rx_data = [self serverGet:@"GETFavorite" withData:tx_data];
    return [self parseProductData:rx_data];
}

- (ritAttributes*) getAttributes:  (NSString*) contact
{
    NSLog(@"Getting Attributes");
    NSString* tx_data = [self formatData:contact withKeys:nil withVals:nil];
    NSString* rx_data = [self serverGet:@"GETAttributes" withData:tx_data];
    return [self parseAttributeData:rx_data];
}

- (ritAttributes*) parseAttributeData: (NSString*) data
{
    ritAttributes* attr = [[ritAttributes alloc] init];
    NSArray* pair;
    
    //Separate key-value pairs from data
    NSArray* mapping = [data componentsSeparatedByString:@"|"];
    
    //Store key-value pairs to attributes object
    for(int i = 0; i < [mapping count]; ++i)
    {
        pair = [mapping[i] componentsSeparatedByString:@"="];
        [attr setAttribute:pair[0] withValue:pair[1]];
    }
    
    //Return attributes object
    NSLog(@"Parsed Attributes: %@", attr.dict);
    return attr;
}

- (NSMutableArray*) parseProductData: (NSString*) data
{
    if([data isEqualToString:@""]) return nil;
    NSMutableArray* products = [[NSMutableArray alloc] init];
    ritProduct* product;
    NSArray* pair;
    NSString* key;
    NSString* val;
    
    //Separate key-value pairs
    NSArray* mapping = [data componentsSeparatedByString:@"|"];
    
    //Store key-value pairs to product objects
    for(int i = 0; i < [mapping count]; ++i)
    {
        pair = [mapping[i] componentsSeparatedByString:@"="];
        key = pair[0];
        val = pair[1];
        
        //If we got a new ASIN this means that we got a new product
        if([key isEqualToString:@"ASIN"])
        {
            product = [[ritProduct alloc] init];
            [products addObject:product];
        }
        
        //Always add the key-value pair to the proeuct
        [product.dict setObject:val forKey:key];
    }
#if 0
    for(int i = 0; i < [products count]; ++i)
    {
        NSLog(@"Parsed Product: %@\n\n\n", [products[i] dict]);
    }
#endif
    return products;
}

@end
