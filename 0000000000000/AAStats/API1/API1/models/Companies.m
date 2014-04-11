//
//  Companies.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//
#import "Companies.h"

@implementation Companies
@synthesize company_id, subdomain, name;

- (id)initWithJsonDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
        
        self.company_id = dict[@"id"];
        
        self.subdomain = dict[@"subdomain"];
        self.name = dict[@"name"];
        /*
         sub levels
		NSArray *artists        = dict[@"artists"];
		NSDictionary *artists0  = artists[0];
		NSString *artistName = artists0[@"name"];
		self.artist = artistName;
        */
	}
    
	return self;
}

@end
