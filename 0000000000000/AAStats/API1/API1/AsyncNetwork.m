//
//  AsyncNetwork.m
//  Music Search
//
//  Created by Bayon Forte on 1/13/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "AsyncNetwork.h"
#import "Constants.h"
#import "Company.h"
#import "User.h"


@interface AsyncNetwork () {
	NSURLConnection *postConnection;
	NSMutableData *postResponseData;

	NSURLConnection *getConnection;
	NSMutableData *getResponseData;
}


@property (nonatomic, retain) NSURLConnection *postConnection;
@property (nonatomic, retain) NSMutableData *postResponseData;

@property (nonatomic, retain) NSURLConnection *getConnection;
@property (nonatomic, retain) NSMutableData *getResponseData;

@property (nonatomic) int spaceIndex;

@end

@implementation AsyncNetwork
@synthesize postConnection, postResponseData, spaceIndex;
@synthesize getConnection, getResponseData;

- (IBAction)postRequestToURL:(NSURL *)url withParameters:(NSDictionary *)parameterDictionary {
	NSData *paramatersData = [self encodeDictionary:parameterDictionary forRequestType:@"post"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setValue:[NSString stringWithFormat:@"%d", paramatersData.length] forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:paramatersData];

	postConnection = [[NSURLConnection alloc] initWithRequest:request
	                                                 delegate:self];
	[postConnection start];
}

- (NSData *)encodeDictionary:(NSDictionary *)dictionary forRequestType:(NSString *)requestType {
	NSData *returnData;
	if ([requestType isEqualToString:@"post"]) {
		NSMutableArray *parts = [[NSMutableArray alloc] init];
		for (NSString *key in dictionary) {
			NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			NSString *part = [NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue];
			[parts addObject:part];
		}
		NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
		returnData = [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
	}
	if ([requestType isEqualToString:@"get"]) {
		NSMutableArray *parts = [[NSMutableArray alloc] init];
		for (NSString *key in dictionary) {
			NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			NSString *part = [NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue];
			[parts addObject:part];
		}
		NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
		NSString *finalGetParams = [NSString stringWithFormat:@"%@%@", @"?", encodedDictionary];

		NSLog(@"\n finalGetParams:%@", finalGetParams);
		returnData = [finalGetParams dataUsingEncoding:NSUTF8StringEncoding];
	}


	return returnData;
}

- (IBAction)getRequestToURL:(NSString *)urlString withParameters:(NSString *)parameterString {
	
    /*
    NSData *parametersData = [self encodeDictionary:parameterDictionary forRequestType:@"get"];
	 //convert data to string
    NSString* stringParameters = [[NSString alloc] initWithData:parametersData encoding:NSUTF8StringEncoding];
    
    
    //FAIL get request: http://hive.indatus.com/precompiled_reports/<3f696e74 65727661 6c3d746f 64617926 636f6d70 616e795f 69643d32 33>
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
	                                                       cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
	                                                   timeoutInterval:10];
	[request setHTTPMethod:@"GET"];
	//[request setValue:[NSString stringWithFormat:@"%d", parametersData.length] forHTTPHeaderField:@"Content-Length"];
	//[request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];

	[request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

	[request setHTTPBody:parametersData];
    */
    
    ////////////////////////////////
    NSString *urlFinalString = [NSString stringWithFormat:@"%@%@",urlString,parameterString];
    NSLog(@"\n get url string: %@",urlFinalString);
    NSURL *url2 = [NSURL URLWithString:urlFinalString];
    NSMutableURLRequest *request2 = [NSMutableURLRequest requestWithURL:url2
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    
    
    
    
    
    
	getConnection = [[NSURLConnection alloc] initWithRequest:request2
	                                                delegate:self];
	[getConnection start];
}

#pragma mark -  NSURL Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	if ([connection isEqual:postConnection]) {
		postResponseData = [[NSMutableData alloc] init];
	}
	else if ([connection isEqual:getConnection]) {
		getResponseData = [[NSMutableData alloc] init];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	if ([connection isEqual:postConnection]) {
		[postResponseData appendData:data];
	}
	else if ([connection isEqual:getConnection]) {
        [getResponseData appendData:data];
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if ([connection isEqual:postConnection]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyUserFail object:nil];
	}
	else if ([connection isEqual:getConnection]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyIntervalFail object:nil];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if ([connection isEqual:postConnection]) {
		if (postResponseData != nil) {
			[self parseUserResponseData:postResponseData];
		}
		else {
			[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyUserFail object:nil];
		}
	}
	else if ([connection isEqual:getConnection]) {
		////////////////////////////////////////
		//   V I E W   R E S P O N S E   ///////
		[self viewJSONFromData:getResponseData];
		////////////////////////////////////////
        
        
        if(getResponseData != nil){
            
            NSDictionary *dictionaryOfIntervalModels = [self parseIntervalResponseData:getResponseData];
            // how do I get this back to the block?
            NSLog(@"\n\n get data: %@",dictionaryOfIntervalModels);
            
            //Invalid credentials
        }
        
	}
}

- (void)viewJSONFromData:(NSData *)data {
	NSString *stringOfJsonEncodedData;
	stringOfJsonEncodedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"stringOfJsonEncodedData:%@", stringOfJsonEncodedData);
}

#pragma mark - Parse Dictionary

- (NSMutableArray *)parseUserResponseData:(NSMutableData *)mutableResponseData {
	//note: This method returns an array for the sake of a unit test.
	NSMutableArray *localArrayOfUserModels = [[NSMutableArray alloc] init];
	@try {
		NSError *e;
		NSDictionary *dictionaryOfJsonFromResponseData =
		    [NSJSONSerialization JSONObjectWithData:mutableResponseData
		                                    options:NSJSONReadingMutableContainers
		                                      error:&e];

		User *user = [[User alloc] initWithJsonDictionary:dictionaryOfJsonFromResponseData];
		[localArrayOfUserModels addObject:user];

		NSDictionary *dictionaryOfUserModels = @{ kArrayOfUserModels : localArrayOfUserModels };
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyUserSuccess object:self userInfo:dictionaryOfUserModels];
	}
	@catch (NSException *exception)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyUserFail object:nil];
	}


	return localArrayOfUserModels;
}

- (NSDictionary *)parseIntervalResponseData:(NSMutableData *)mutableResponseData {
    NSMutableArray *localArrayOfIntervals = [[NSMutableArray alloc] init];
    NSDictionary *dictionaryOfIntervalModels;
    @try {
		NSError *e;
		NSDictionary *dictionaryOfJsonFromResponseData =
        [NSJSONSerialization JSONObjectWithData:mutableResponseData
                                        options:NSJSONReadingMutableContainers
                                          error:&e];
        
		Interval *interval = [[Interval alloc] initWithJsonDictionary:dictionaryOfJsonFromResponseData];
		[localArrayOfIntervals addObject:interval];
        
		 dictionaryOfIntervalModels = @{ kArrayOfIntervalModels : localArrayOfIntervals };
		//[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyIntervalSuccess object:self userInfo:dictionaryOfUserModels];
	}
	@catch (NSException *exception)
	{
		//[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyIntervalFail object:nil];
	}
    return dictionaryOfIntervalModels;
}
@end
