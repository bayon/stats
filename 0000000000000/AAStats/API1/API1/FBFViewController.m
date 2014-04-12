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

#import "BackgroundThreadWorker.h"


@interface FBFViewController () {
	AsyncNetwork *asyncNetwork;
    User *user;
    NSString *intervalType;
}
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSString *intervalType;
@end

@implementation FBFViewController
@synthesize reachability = _reachability, arrayOfCompanies = _arrayOfCompanies,
companyTableView = _companyTableView, arrayOfUserModels = _arrayOfUserModels, user = _user, intervalType = _intervalType;


@synthesize label1 = _label1;

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _intervalType = @"today";
    
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterUserAsyncThreadCompletes:) name:kNotifyUserSuccess object:asyncNetwork];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataFailed) name:kNotifyUserFail object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(afterIntervalAsyncThreadCompletes:) name:kNotifyIntervalSuccess object:asyncNetwork];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(intervalDataFailed) name:kNotifyIntervalFail object:nil];

	[self process:self];
}
#pragma mark -
#pragma mark API call
- (IBAction)process:(id)sender {
	Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
	NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
	if (networkStatus == NotReachable) {
		NSString *msg = @"Please check your network";
		UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"Network" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

		[alertmsg show];
	}
	else {
		asyncNetwork = [[AsyncNetwork alloc]init];
		NSURL *url = [NSURL URLWithString:@"http://hive.indatus.com/authenticate"];
		NSDictionary *paramametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"bwebb-gemini", @"subdomain",
		                                        @"bwebb@indatus.com", @"email", @"telecom1", @"password", nil];
		[asyncNetwork postRequestToURL:url withParameters:paramametersDictionary];
	}
}

// after network call

- (void)dataFailed {
	NSString *msg =  @"Failed to get data .";
	UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"No Data" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

	[alertmsg show];
	//[spinner stopAnimating];
}

- (void)afterUserAsyncThreadCompletes:(NSNotification *)notification {
	
	_arrayOfUserModels = [notification userInfo][kArrayOfUserModels];
	_user = [[User alloc]init];
    _user = [_arrayOfUserModels objectAtIndex:0];

	_arrayOfCompanies = [_user getAllCompanies];
    
	
    
    ////////////////////////////////////////////////////
    // CANDIDATE FOR OPERATION QUEUE
     // second API - loop through companies and call interval per company
    for(Company *company in _arrayOfCompanies){
        
      //--->>>  [self refreshInterval:_intervalType forCompanyId:company.primary_id];
    }
    BackgroundThreadWorker *bThread = [[BackgroundThreadWorker alloc]init];
    
    [bThread doBackgroundThing:_label1 andString:@"Foo Haa Haa"];
    
    // hopefully applying the interval data to each company object.
    ///////////////////////////////////////////////////////////////////////
    
    
    
    [_companyTableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	//[spinner stopAnimating];
}

- (void)intervalDataFailed {
	NSString *msg =  @"Failed to get data .";
	UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"No Data" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	[alertmsg show];
	//[spinner stopAnimating];
}
- (void)afterIntervalAsyncThreadCompletes:(NSNotification *)notification {
    
}
#pragma mark -
#pragma mark Interval
/*
   Url: http://hive.indatus.com/precompiled_reports/{interval}/{company_id}

   Method: GET

   intervals:
 * today
 * yesterday
 * this_week
 * last_week
 * this_month
 * last_month
 * this_year
 * last_year

   company_id
 */



- (IBAction)selectInterval:(id)sender {
	UIButton *btnPressed = (UIButton *)sender;
	int btnTag = btnPressed.tag;
   
	switch (btnTag) {
		case 1:
           _intervalType = @"today";
			break;

		case 2:
			_intervalType = @"this_week";
			break;

		case 3:
			_intervalType = @"this_month";
			break;

		default:
            _intervalType = @"today";
			break;
	}
    // call table reload and then each company will need to refresh interval
    [_companyTableView reloadData];
    
    
}

-(void)refreshInterval:(NSString *)interval forCompanyId:(NSString *)companyId{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSString *msg = @"Please check your network";
        UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"Network" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertmsg show];
    }
    else {
        asyncNetwork = [[AsyncNetwork alloc]init];
        NSURL *url = [NSURL URLWithString:@"http://hive.indatus.com/precompiled_reports/"];
        NSDictionary *paramametersDictionary = [NSDictionary dictionaryWithObjectsAndKeys:interval, @"interval",
                                                companyId, @"company_id",  nil];
        [asyncNetwork getRequestToURL:url withParameters:paramametersDictionary];
    }
}


#pragma mark - Table Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_arrayOfCompanies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	/**/
	static NSString *CellIdentifier = @"Cell";
	CompaniesCell *cell = (CompaniesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[CompaniesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	Company *company = _arrayOfCompanies[indexPath.row];
    
    
   
    
    
	cell.leftLabel.text = company.name;
	cell.rightLabel.text = company.unit_count;
	return cell;


	/*
	   static NSString *CellIdentifier = @"UserCell";
	   UserCell *cell = (UserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	   if (cell == nil) {
	    cell = [[UserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	   }
	   User *userModel = _arrayOfUserModels[indexPath.row];
	   Company *company = userModel.company;

	   NSLog(@"company :%@",company);
	   cell.leftLabel.text = company.name;
	   cell.rightLabel.text = company.unit_count;
	   return cell;
	 */
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
