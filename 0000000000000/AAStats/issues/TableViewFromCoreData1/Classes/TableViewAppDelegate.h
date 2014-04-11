//
//  TableViewAppDelegate.h
//  TableView
//
//  Created by Safwan Ahmed on 08/08/09.
//  Copyright Mindcob 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewViewController;
//v2 memory
@class AppMemory;

@interface TableViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TableViewViewController *viewController;
    //coredata
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    //v2 memory
     AppMemory *theAppDataObject;
    
     
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TableViewViewController *viewController;
//core data
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;
 //v2 memory
@property(nonatomic,retain)AppMemory *theAppDataObject;

@end
 
