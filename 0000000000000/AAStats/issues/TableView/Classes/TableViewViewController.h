//
//  TableViewViewController.h
//  TableView
//
//  Created by Safwan Ahmed on 08/08/09.
//  Copyright Mindcob 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
	UITableView *tableView1; 
}

@property (nonatomic,retain) UITableView * tableView1;

@property (nonatomic, strong) IBOutlet UITableView * tblTest;
@property (nonatomic, retain) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (nonatomic) BOOL pinchGestureOn;
@property (nonatomic) int pinched;
@end

