//
//  AsyncNetwork.h
//  Music Search
//
//  Created by Bayon Forte on 1/13/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncNetwork : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>




- (NSMutableArray *)parseResponseData:(NSMutableData *)mutableResponseData;


- (IBAction)asyncButtonPushed:(NSURL *) url withParameters:(NSDictionary *)parameterDictionary;
@end
