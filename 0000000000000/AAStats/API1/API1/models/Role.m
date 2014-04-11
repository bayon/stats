//
//  Role.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "Role.h"

@implementation Role
@synthesize company_id, description, name, permissions;

- (id)initWithJsonDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
        
        self.company_id = dict[@"company_id"];
        self.description = dict[@"description"];
        self.name = dict[@"name"];
        
          
        permissions        = dict[@"permissions"];
        
        
        //NSDictionary *permissions0  = permissions[0];
         //NSString *artistName = permissions0[@"name"];
         //self.permissions = artistName;
         
	}
    
	return self;
}

@end
