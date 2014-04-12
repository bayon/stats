//
//  BackgroundObjectWorker.h
//  workBench
//
//  Created by Bayon Forte on 3/27/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 Purpose: This object is set up to do chores on a background thread.
 It receives standard method calls, and all the 'block' code and 'asynchronous' code
 is done here, semi out of view.
 
 */
@interface BackgroundThreadWorker : NSObject

-(void)doBackgroundThing:(UILabel *) label andString:(NSString *)string;

@end
