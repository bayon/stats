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
#import "User.h"
#import "UserCell.h"



@interface FBFViewController () {
	AsyncNetwork *asyncNetwork;
}

@end

@implementation FBFViewController
@synthesize reachability = _reachability, arrayOfCompaniesModels = _arrayOfCompaniesModels,
companyTableView = _companyTableView, arrayOfUserModels = _arrayOfUserModels;



- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterAsyncThreadCompletes:) name:kNotifySuccess object:asyncNetwork];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataFailed) name:kNotifyFail object:nil];
	

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
    NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
	_arrayOfUserModels = [notification userInfo][kArrayOfUserModels];
    
    
    NSLog(@"_arrayOfUserModels : %d",[_arrayOfUserModels count]);
    User *currentUser = [[User alloc]init];
    currentUser = [_arrayOfUserModels objectAtIndex:0];
    
    NSLog(@"current User: %@",currentUser.first_name);
	[_companyTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	//[spinner stopAnimating];
}

#pragma mark - Table Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_arrayOfUserModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    /*
     static NSString *CellIdentifier = @"Cell";
     CompaniesCell *cell = (CompaniesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[CompaniesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
     }
     Company *companiesModel = _arrayOfCompaniesModels[indexPath.row];
     cell.leftLabel.text = companiesModel.primary_id;
     cell.rightLabel.text = companiesModel.name;
     return cell;
     */
    
    static NSString *CellIdentifier = @"UserCell";
	UserCell *cell = (UserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	User *userModel = _arrayOfUserModels[indexPath.row];
	cell.leftLabel.text = userModel.first_name;
	cell.rightLabel.text = userModel.last_name;
	return cell;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
