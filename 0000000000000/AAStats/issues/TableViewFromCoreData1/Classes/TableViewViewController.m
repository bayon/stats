//
//  TableViewViewController.m
//  TableView
//
//  Created by Safwan Ahmed on 08/08/09.
//  Copyright Mindcob 2009. All rights reserved.
//

#import "TableViewViewController.h"
 //core data
#import "TableViewAppDelegate.h"
//v2
#import "User.h"
//v2 memory
#import "AppDelegateProtocol.h"
#import "AppMemory.h"
#import "TableViewAppDelegate.h"

@implementation TableViewViewController

//core data
@synthesize fetchedResultsController,nsMutableArray,managedObjectContext;
  
//v2 memory
-(AppMemory*)theAppDataObject;
{
    id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
    AppMemory *theDataObject ;
    theDataObject = (AppMemory*)theDelegate.theAppDataObject;
    return theDataObject;
    
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	tblTest.delegate = self;
	tblTest.dataSource = self;
     
    //core data
    //CHECK the managedObjectContext: add this when outside of the app delegate file.
     if (managedObjectContext == nil)
     {
     managedObjectContext = [(TableViewAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
     }
     // **** save object to Core Data ****
     //(USE IF INSIDE THE APPDELEGATE) NSManagedObjectContext *context = [self managedObjectContext];
     NSManagedObject	*user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:managedObjectContext];
     NSError *error;
     //sqlite integer converts to NSNumber
     NSNumber * currentNumber = [NSNumber numberWithInt:[@"4" integerValue]];
     [user setValue:currentNumber forKey:@"id"];
     [user setValue:@"Nicholas Cage" forKey:@"username"];
     // here's where the actual save happens, and if it doesn't we print something out to the console
     if (![managedObjectContext save:&error])
     {
     NSLog(@"Problem saving: %@", [error localizedDescription]);
     }
     // **** log objects in database ****
     // create fetch object, this objects fetch's the objects out of the database
     NSError *error2;
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
     [fetchRequest setEntity:entity];
     NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error2];
    //v2 memory
    AppMemory *theDataObject = [self theAppDataObject];
    theDataObject.mutableArray = [[NSMutableArray alloc] init];
    theDataObject.mutableArray= [NSMutableArray arrayWithArray:fetchedObjects];
      
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
    AppMemory *theDataObject = [self theAppDataObject];
    return [theDataObject.mutableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)ttableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [ttableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	if (!cell) {
		//If a cell with this identifier doesn't already created then it will be created and assigned an identofier
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier]  ;
	}

	// Index of the cell to be processed
	int index = indexPath.row;
	// Text is going to be set of the cell
	cell.text = [NSString stringWithFormat:@"%i", index];
 
    //v2 memory
    AppMemory *theDataObject = [self theAppDataObject];
    User *user = (User *)[theDataObject.mutableArray objectAtIndex:indexPath.row];
    NSString *string = [NSString stringWithFormat:@"%@ ",[user username]] ;
     cell.text =string;
    
    
	// Cell is returned which will be shown on table
	return cell;
}



-(void)tableView: (UITableView*) ttableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Message to show. indexPath.row is the row number selected
    NSString* msg = [NSString stringWithFormat:@"Row# %i is selected", indexPath.row];
    // Creating an alert view with the message above
   // UIAlertView *alertmsg = [[UIAlertViewalloc] initWithTitle:@"title" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"title" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil ];
    
    // Show the alert
    [alertmsg show];
    // Releae the alert
    //alertmsg release];
    
    //NAVIGATE TO ANOTHER VIEW CONTROLLER
    //ThirdView *thirdView = [[ThirdView alloc] initWithStyle:UITableViewStyleGrouped];
    //[self.navigationController pushViewController:thirdView  animated:YES];
}





/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
