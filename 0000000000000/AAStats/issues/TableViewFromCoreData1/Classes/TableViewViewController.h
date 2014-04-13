//
//  TableViewViewController.h
//  TableView
//
//  Created by Safwan Ahmed on 08/08/09.
//  Copyright Mindcob 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
//v2 memory
#define myAppDelegate (AppDelegate *) [[UIApplication sharedApplication] delegate]

@interface TableViewViewController : UIViewController<UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate> {
	IBOutlet UITableView* tblTest;
    
    IBOutlet UITextField *txtInput;
    IBOutlet UIButton *btnAdd;
    //core data
    NSFetchedResultsController  *fetchedResultsController;
    NSManagedObjectContext      *managedObjectContext;
    NSMutableArray *nsMutableArray;
}
//core data
@property (nonatomic, retain) NSFetchedResultsController    *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext        *managedObjectContext;
@property (nonatomic, retain) NSMutableArray        *nsMutableArray;

@property (nonatomic, retain) IBOutlet UITextField *txtInput;
@property (nonatomic, retain) IBOutlet UIButton *btnAdd;

-(IBAction)addAnother:(id)sender;
@end

