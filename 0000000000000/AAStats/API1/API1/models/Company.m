//
//  Company.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//
#import "Company.h"

@implementation Company
@synthesize company_id, subdomain, name;

- (id)initWithJsonDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
        
        self.company_id = dict[@"id"];
        self.subdomain = dict[@"subdomain"];
        self.name = dict[@"name"];
        
        /*
         NSArray *arrayOfPivots  = dict[@"pivot"];
         NSDictionary *dictionaryOfPivotAtIndex0  = arrayOfPivots[0];
         pivot = [[Pivot alloc] initWithJsonDictionary:dictionaryOfPivotAtIndex0];
        */
	}
    
	return self;
}

@end

