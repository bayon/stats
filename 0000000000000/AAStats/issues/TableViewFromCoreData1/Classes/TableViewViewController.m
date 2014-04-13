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
@interface TableViewViewController(){
    
}
@property (nonatomic) BOOL pinched;
@end

@implementation TableViewViewController

//core data
@synthesize fetchedResultsController,nsMutableArray,managedObjectContext;
@synthesize txtInput, btnAdd, pinched;
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
    pinched = NO;
	tblTest.delegate = self;
	tblTest.dataSource = self;
    
    
    txtInput.delegate = self;
    [txtInput setPlaceholder:@"whatever"];
    [txtInput setKeyboardType:UIKeyboardTypeDefault];
    
    //core data
    //CHECK the managedObjectContext: add this when outside of the app delegate file.
     if (managedObjectContext == nil)
     {
     managedObjectContext = [(TableViewAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
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
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    [self.view addGestureRecognizer:pinchRecognizer];
  
    
}
- (void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer
{
    NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
    pinched = YES;
    //CGFloat scale = pinchRecognizer.scale;
    //self.view.transform = CGAffineTransformScale(self.view.transform, scale, scale);
    //pinchRecognizer.scale = 1.0;
    [tblTest reloadData];
    
}
-(IBAction)addAnother:(id)sender{
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
    
    [user setValue:txtInput.text forKey:@"username"];
    // here's where the actual save happens, and if it doesn't we print something out to the console
    if (![managedObjectContext save:&error])
    {
        NSLog(@"Problem saving: %@", [error localizedDescription]);
    }
    
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
    
    //lose the keyboard
    [self dismissKeyboard];
    // clear the input test
    [txtInput setText:nil];
    
    
    
    [tblTest reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //AppMemory *theDataObject = [self theAppDataObject];
    //return [theDataObject.mutableArray count];
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if(pinched){
        return 0;
    }else{
        AppMemory *theDataObject = [self theAppDataObject];
        return [theDataObject.mutableArray count];
    }
   
    
    
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
    
    pinched = NO;
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


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    AppMemory *theDataObject = [self theAppDataObject];
    
   // NSString *string =[theDataObject.mutableArray  objectAtIndex:section];
    NSString *string = @"section header";
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    
    /* make button one pixel less high than customView above, to account for separator line */
    UIButton *button = [[[UIButton alloc] initWithFrame: CGRectMake(0.0, 0.0, 320.0, 80.0)] autorelease];
    button.alpha = 0.7;
   // [button setImage: myPNGImage forState: UIControlStateNormal];
    
    /* Prepare target-action */
    [button addTarget: self action: @selector(headerTapped:)
     forControlEvents: UIControlEventTouchUpInside];
    
    [view addSubview: button];
    
    
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}
- (void) headerTapped: (UIButton*) sender
{
    /* do what you want in response to section header tap */
    NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
    pinched = NO;
    [tblTest reloadData];
    
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

// "Return Key" dismiss keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [txtInput resignFirstResponder];
    
    
    return YES;
}
// "Tap" dismiss keyboard
-(void)dismissKeyboard {
    [txtInput resignFirstResponder];
    
    
}

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
