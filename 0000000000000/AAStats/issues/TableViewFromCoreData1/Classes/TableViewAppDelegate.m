//
//  TableViewAppDelegate.m
//  TableView
//
//  Created by Safwan Ahmed on 08/08/09.
//  Copyright Mindcob 2009. All rights reserved.
//

#import "TableViewAppDelegate.h"
#import "TableViewViewController.h"
//v2 memory
#import "AppDelegateProtocol.h"
#import "AppMemory.h"

@implementation TableViewAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize managedObjectContext,managedObjectModel,persistentStoreCoordinator;
 //v2 memory
@synthesize theAppDataObject;


//v2 memory
-(id)init{
    
    self.theAppDataObject = [[AppMemory alloc]init];
    return [super init];
    
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}
//core data

  
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext
{
	
    NSError *error = nil;
    NSManagedObjectContext *objectContext = self.managedObjectContext;
    if (objectContext != nil)
    {
        if ([objectContext hasChanges] && ![objectContext save:&error])
        {
            // add error handling here
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark -
#pragma mark Core Data stack

// Returns the managed object context for the application.
 //If the context doesn't already exist, it is created and bound to the persistent store coordinator //for the application.

- (NSManagedObjectContext *)managedObjectContext
{
	
    if (managedObjectContext != nil)
    {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}

// Returns the managed object model for the application.
 //If the model doesn't already exist, it is created from the application's model.
 
- (NSManagedObjectModel *)managedObjectModel
{
    if (managedObjectModel != nil)
    {
        return managedObjectModel;
    }
    //managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
	
     managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil] ;
    
    
    
    return managedObjectModel;
}
//Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	
    if (persistentStoreCoordinator != nil)
    {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TableView.sqlite"];
	
    NSError *error = nil;
 
 
 //CORE DATA MIGRATION CLAUSE
 NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES],NSInferMappingModelAutomaticallyOption, nil];
   
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }  
	
    return persistentStoreCoordinator;
}





@end
