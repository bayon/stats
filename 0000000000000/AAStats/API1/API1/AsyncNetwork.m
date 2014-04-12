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
	NSURLConnection *connection;
	NSMutableData *responseData;
}

@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic) int spaceIndex;

@end

@implementation AsyncNetwork
@synthesize connection, responseData, spaceIndex;

- (IBAction)postRequestToURL:(NSURL *)url withParameters:(NSDictionary *)parameterDictionary {
	NSData *paramatersData = [self encodeDictionary:parameterDictionary];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	[request setHTTPMethod:@"POST"];
	[request setValue:[NSString stringWithFormat:@"%d", paramatersData.length] forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:paramatersData];

	connection = [[NSURLConnection alloc] initWithRequest:request
	                                             delegate:self];
	[connection start];
}

- (NSData *)encodeDictionary:(NSDictionary *)dictionary {
	NSMutableArray *parts = [[NSMutableArray alloc] init];
	for (NSString *key in dictionary) {
		NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		NSString *part = [NSString stringWithFormat:@"%@=%@", encodedKey, encodedValue];
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
        
		////////////////////////////////////////
		//   P A R S E  ////////////////////////
		[self parseResponseData:responseData];
		////////////////////////////////////////

        
        ////////////////////////////////////////
		//   V I E W   R E S P O N S E   ///////
		//[self viewJSONFromData:responseData];
        ////////////////////////////////////////

	}
	else {
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
	}
}

- (void)viewJSONFromData:(NSData *)data {
	NSString *stringOfJsonEncodedData;
	stringOfJsonEncodedData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"stringOfJsonEncodedData:%@", stringOfJsonEncodedData);
}

#pragma mark - Parse Dictionary

- (NSMutableArray *)parseResponseData:(NSMutableData *)mutableResponseData {
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
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifySuccess object:self userInfo:dictionaryOfUserModels];
	}
	@catch (NSException *exception)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
	}


	return localArrayOfUserModels;
}

@end
