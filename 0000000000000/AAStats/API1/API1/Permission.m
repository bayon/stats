//
//  Permission.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "Permission.h"

@implementation Permission

@synthesize pivot, permission_id, product_id, name, description, created_at, updated_at;

- (id)initWithJsonDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
		self.permission_id = dict[@"permission_id"];
		self.product_id = dict[@"product_id"];
		self.description = dict[@"description"];
		self.created_at = dict[@"created_at"];
		self.updated_at = dict[@"updated_at"];

		NSArray *arrayOfPivots  = dict[@"pivot"];
		NSDictionary *dictionaryOfPivotAtIndex0  = arrayOfPivots[0];
		pivot = [[Pivot alloc] initWithJsonDictionary:dictionaryOfPivotAtIndex0];
	}

	return self;
}

@end
