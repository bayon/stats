//
//  FBFViewController.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"
#import "AsyncNetwork.h"

@interface FBFViewController () {
	AsyncNetwork *asyncNetwork;
}

@end

@implementation FBFViewController
@synthesize reachability = _reachability;
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

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


	[self process:self];
}

- (IBAction)process:(id)sender {
	Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
	NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
	if (networkStatus == NotReachable) {
		NSString *msg = @"Please check your network";
		UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"Network" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

		[alertmsg show];
	}
	else {
		NSString *postParams = [NSString stringWithFormat:@"&subdomain=%@&email=%@&password=%@", @"bwebb-gemini", @"bwebb@indatus.com", @"telecom1"];


		NSString *baseURL = @"http://hive.indatus.com/authenticate";
		asyncNetwork = [[AsyncNetwork alloc]init];

        
        NSString *totalURL = [NSString stringWithFormat:@"%@%@",baseURL,postParams ];
        NSLog(@"\n total URL%@",totalURL);
        
        NSURL *url = [NSURL URLWithString:@"http://hive.indatus.com/authenticate"];
        NSDictionary *paramametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"bwebb-gemini", @"subdomain",
                                                @"bwebb@indatus.com", @"email",@"telecom1",@"password", nil];
        //[asyncNetwork asyncButtonPushed:self];
        [asyncNetwork postRequestToURL:url withParameters:paramametersDictionary];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
