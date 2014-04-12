//
//  BackgroundObjectWorker.m
//  workBench
//
//  Created by Bayon Forte on 3/27/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "BackgroundThreadWorker.h"

@interface BackgroundThreadWorker (){
    dispatch_queue_t background_queue;
}
@end

void (^changeLabelText)(UILabel *, NSString *) = ^(UILabel *label, NSString *text)
{
	 
    sleep(4);
    
	// CAN ONLY INTERACT WITH UI ON MAIN THREAD
	dispatch_async(dispatch_get_main_queue(), ^(void)
                   {
                       [label setText:text];
                   }
                   
	               );
};

@implementation BackgroundThreadWorker

-(void)doBackgroundThing:(UILabel *) label andString:(NSString *)string{
    
    background_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_async(background_queue, ^{ changeLabelText(label, string);  });
	
}

@end
