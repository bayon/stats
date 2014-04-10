//
//  TableViewAppDelegate.h
//  TableView
//
//  Created by Safwan Ahmed on 08/08/09.
//  Copyright Mindcob 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewViewController;

@interface TableViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TableViewViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TableViewViewController *viewController;

@end

