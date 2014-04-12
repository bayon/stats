//
//  FBFViewController.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"
#import "AsyncNetwork.h"
#import "Constants.h"
#import "Company.h"
#import "CompaniesCell.h"



@interface FBFViewController () {
	AsyncNetwork *asyncNetwork;
}

@end

@implementation FBFViewController
@synthesize reachability = _reachability, arrayOfCompaniesModels = _arrayOfCompaniesModels, companyTableView = _companyTableView;



- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterAsyncThreadCompletes:) name:kNotifySuccess object:asyncNetwork];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataFailed) name:kNotifyFail object:nil];
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

// after network call

- (void)dataFailed {
	NSString *msg =  @"Failed to get data with space in search word.";
	UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"No Data" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[alertmsg show];
	//[spinner stopAnimating];
}

- (void)afterAsyncThreadCompletes:(NSNotification *)notification {
	_arrayOfCompaniesModels = [notification userInfo][kArrayOfCompaniesModels];
	[_companyTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	//[spinner stopAnimating];
}

#pragma mark - Table Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_arrayOfCompaniesModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	CompaniesCell *cell = (CompaniesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[CompaniesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

	}
	Company *companiesModel = _arrayOfCompaniesModels[indexPath.row];
	cell.leftLabel.text = companiesModel.primary_id;
	cell.rightLabel.text = companiesModel.name;
    
	return cell;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
