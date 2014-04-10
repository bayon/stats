//
//  TableViewViewController.m
//  TableView
//
//  Created by Safwan Ahmed on 08/08/09.
//  Copyright Mindcob 2009. All rights reserved.
//

#import "TableViewViewController.h"
#import "ThirdView.h"
@implementation TableViewViewController

@synthesize pinchGestureRecognizer, pinchGestureOn, pinched;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	 
    
    pinchGestureOn = NO;
    pinched = 0;
    //tblTest = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    //UITableViewStyleGrouped
   // _tblTest = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 300) style:UITableViewStylePlain];
    [self refreshTable];
    
    // GESTURE PINCH
    self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)] ;

    [self.view addGestureRecognizer:self.pinchGestureRecognizer];

    

    
}

-(void)refreshTable{
    NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n",__FUNCTION__);
    _tblTest = nil;
    _tblTest.delegate = self;
	_tblTest.dataSource = self;
    
   _tblTest = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 300) style:UITableViewStylePlain];
}


- (void)pinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer
{
	NSLog(@"*** Pinch: Scale: %f Velocity: %f", gestureRecognizer.scale, gestureRecognizer.velocity);
   pinchGestureOn = YES;
    pinched = 1;
    NSLog(pinchGestureOn ? @"pinch Yes" : @"No");
    
    [self.tblTest reloadData];
    [self refreshTable];
    /*
	UIFont *font = self.myTextView.font;
	CGFloat pointSize = font.pointSize;
	NSString *fontName = font.fontName;
    
	pointSize = ((gestureRecognizer.velocity > 0) ? 1 : -1) * 1 + pointSize;
	
	if (pointSize < 13) pointSize = 13;
	if (pointSize > 42) pointSize = 42;
	
	self.myTextView.font = [UIFont fontWithName:fontName size:pointSize];
	
	// Save the new font size in the user defaults.
    // (UserDefaults is my own wrapper around NSUserDefaults.)
	[[UserDefaults sharedUserDefaults] setFontSize:pointSize];
    */
    
    
}






- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    
    if(pinched == 1){
        return 0;
    }
    
    
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)ttableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *MyIdentifier = @"MyIdentifier";
	UITableViewCell *cell = [ttableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	if (!cell) {
		//If a cell with this identifier doesn't already created then it will be created and assigned an identofier
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:MyIdentifier] autorelease];
	}

	// Index of the cell to be processed
	int index = indexPath.row;
	// Text is going to be set of the cell
	cell.text = [NSString stringWithFormat:@"%i", index];

	// Cell is returned which will be shown on table
	return cell;
}



-(void)tableView: (UITableView*) ttableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Message to show. indexPath.row is the row number selected
    NSString* msg = [NSString stringWithFormat:@"Row# %i is selected", indexPath.row];
    // Creating an alert view with the message above
   // UIAlertView *alertmsg = [[UIAlertViewalloc] initWithTitle:@"title" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    UIAlertView *alertmsg = [[UIAlertView alloc] initWithTitle:@"title" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil ];
    
     pinchGestureOn = NO;
    NSLog(pinchGestureOn ? @"didSelect Yes" : @"No");
    pinched = 0;
     [self.tblTest reloadData];
    [self refreshTable];
    
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
    //NSString *string =[list objectAtIndex:section];
    NSString *string = @"man oh man";
    
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    
    return view;
    
    
    
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
