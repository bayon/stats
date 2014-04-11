//
//  AsyncNetwork.m
//  Music Search
//
//  Created by Bayon Forte on 1/13/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "AsyncNetwork.h"
#import "Constants.h"
#import "Companies.h"


@interface AsyncNetwork () {
	NSURLConnection *connection;
	NSMutableData *responseData;
}

@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic) int spaceIndex;

@end

@implementation AsyncNetwork
@synthesize connection, responseData, spaceIndex;



- (IBAction)postRequestToURL:(NSURL *)url withParameters:(NSDictionary *)parameterDictionary{
   

    NSData *paramatersData = [self encodeDictionary:parameterDictionary];
    //convert data to string
    NSString* dataString = [[NSString alloc] initWithData:paramatersData
                                                 encoding:NSUTF8StringEncoding];
    
    NSLog(@"\n URL:%@",url);
    NSLog(@"\n post data:%@",dataString);
    
    // Create the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%d", paramatersData.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:paramatersData];
    
     connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    
    [connection start];  
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - NSURL Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if (responseData != nil) {
		[self parseResponseData:responseData];
        NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
        
        //NSLog(@"response data: %@",responseData);
        [self viewJSONFromData:responseData];
	}
	else {
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
	}
}


-(void) viewJSONFromData:(NSData *)data{
    NSString* stringOfJsonEncodedData;
    stringOfJsonEncodedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"stringOfJsonEncodedData:%@",stringOfJsonEncodedData);
    
    // response 1 : {"errors":"Login failure"}
}


#pragma mark - Parse Dictionary
 /**
  This method parses the json response as NSMutableData, then creates and sends a dictionary
  back with the notification if successful.
  */
/**/

- (NSMutableArray *)parseResponseData:(NSMutableData *)mutableResponseData {
    //note: This method returns an array for the sake of a unit test.
    NSMutableArray *localArrayOfCompaniesModels = [[NSMutableArray alloc] init];
	@try {
		NSError *e;
		NSDictionary *dictionaryOfJsonFromResponseData =
		    [NSJSONSerialization JSONObjectWithData:mutableResponseData
		                                    options:NSJSONReadingMutableContainers
		                                      error:&e];

		NSMutableArray *arrayOfCompanies = dictionaryOfJsonFromResponseData[@"companies"];

		

		for (NSDictionary *dict in arrayOfCompanies) {
			Companies *companiesModel = [[Companies alloc] initWithJsonDictionary:dict];
			[localArrayOfCompaniesModels addObject:companiesModel];
		}

		NSDictionary *dictionaryOfCompaniesModels = @{ kArrayOfCompaniesModels : localArrayOfCompaniesModels };

		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifySuccess object:self userInfo:dictionaryOfCompaniesModels];
	}
	@catch (NSException *exception)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
	}
    
    
    return localArrayOfCompaniesModels;
}

@end
