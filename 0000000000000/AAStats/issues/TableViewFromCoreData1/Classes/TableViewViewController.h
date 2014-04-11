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

@interface TableViewViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView* tblTest;
    //core data
    NSFetchedResultsController  *fetchedResultsController;
    NSManagedObjectContext      *managedObjectContext;
    NSMutableArray *nsMutableArray;
}
//core data
@property (nonatomic, retain) NSFetchedResultsController    *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext        *managedObjectContext;
@property (nonatomic, retain) NSMutableArray        *nsMutableArray;

@end

