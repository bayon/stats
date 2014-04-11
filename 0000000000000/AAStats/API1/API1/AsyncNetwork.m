//
//  AsyncNetwork.m
//  Music Search
//
//  Created by Bayon Forte on 1/13/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "AsyncNetwork.h"
#import "Constants.h"


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
 

/*
 #### API
 
 Url: http://hive.indatus.com/authenticate
 
 Method: POST
 
 Parameters (for testing only, actual input should be used):
 
 Parameter | Value
 --- | ---
 subdomain | bwebb-gemini
 email | bwebb@indatus.com
 password | telecom1
 
 */



  // L E F T   O F F   H E R E   build this method to receive parameters. Asynchronous? should be.


- (IBAction)asyncButtonPushed:(NSURL *) url withParameters:(NSDictionary *)parameterDictionary{
   // NSURL *url = [NSURL URLWithString:@"http://hive.indatus.com/authenticate"];
    //NSDictionary *paramametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"bwebb-gemini", @"subdomain",
                             // @"bwebb@indatus.com", @"email",@"telecom1",@"password", nil];
    
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

/*
 http://hive.indatus.com/authenticate
 telecom1=password&bwebb-gemini=subdomain&bwebb@indatus.com=email
 */



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
		//[self parseResponseData:responseData];
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
/*
- (NSMutableArray *)parseResponseData:(NSMutableData *)mutableResponseData {
    //note: This method returns an array for the sake of a unit test.
    NSMutableArray *localArrayOfMusicModels = [[NSMutableArray alloc] init];
	@try {
		NSError *e;
		NSDictionary *dictionaryOfJsonFromResponseData =
		    [NSJSONSerialization JSONObjectWithData:mutableResponseData
		                                    options:NSJSONReadingMutableContainers
		                                      error:&e];

		NSMutableArray *arrayOfAlbums = dictionaryOfJsonFromResponseData[@"albums"];

		

		for (NSDictionary *dict in arrayOfAlbums) {
			MusicModel *musicModel = [[MusicModel alloc] initWithJsonDictionary:dict];
			[localArrayOfMusicModels addObject:musicModel];
		}

		NSDictionary *dictionaryOfMusicModels = @{ kArrayOfMusicModels : localArrayOfMusicModels };

		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifySuccess object:self userInfo:dictionaryOfMusicModels];
	}
	@catch (NSException *exception)
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:kNotifyFail object:nil];
	}
    return localArrayOfMusicModels;
}
*/
@end
