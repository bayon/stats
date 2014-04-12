//
//  FBFViewController.h
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface FBFViewController : UIViewController
{
    Reachability *reachability;
}
@property (nonatomic, retain) Reachability *reachability;
@property (nonatomic, retain) NSMutableArray *arrayOfUserModels;
@property (nonatomic, retain) NSMutableArray *arrayOfCompanies;
@property (nonatomic, weak) IBOutlet UITableView *companyTableView;
- (IBAction)process:(id)sender;
@end


// L E F T   O F F   H E R E
// finished up the models , when trying to test I didn't get any data back. connection/service/password ???
