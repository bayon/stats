//
//  User.h
//  TableView
//
//  Created by David Durik on 10/3/12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * id;

@end
