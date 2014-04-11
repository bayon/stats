//
//  User.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize user_id, first_name, last_name;

- (id)initWithJsonDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
        
        self.user_id = dict[@"id"];
        
        self.first_name = dict[@"first_name"];
        self.last_name = dict[@"last_name"];
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
