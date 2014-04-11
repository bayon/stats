//
//  User.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize user_id, first_name, last_name, mobile_phone_number, alt_phone_number,alt_phone_type_id ,email, created_at, updated_at,deleted_at ,role, company, preference, status;

- (id)initWithJsonDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
        
        self.user_id = dict[@"id"];
        self.first_name = dict[@"first_name"];
        self.last_name = dict[@"last_name"];
        self.mobile_phone_number = dict[@"mobile_phone_number"];
        self.alt_phone_number = dict[@"alt_phone_number"];
        self.alt_phone_type_id = dict[@"alt_phone_type_id"];
        self.email = dict[@"email"];
        self.created_at = dict[@"created_at"];
        self.updated_at = dict[@"updated_at"];
        self.deleted_at = dict[@"deleted_at"];
        
        /*
         NSArray *arrayOfRole  = dict[@"role"];
         NSDictionary *dictionaryOfRole = arrayOfRole[0];
         role  = [[Role alloc] initWithJsonDictionary:dictionaryOfRole];
         */
        
        NSArray *arrayOfRole  = dict[@"role"];
        NSDictionary *dictionaryOfRole = arrayOfRole[0];
        role  = [[Role alloc] initWithJsonDictionary:dictionaryOfRole];
        
        NSArray *arrayOfCompany  = dict[@"company"];
        NSDictionary *dictionaryOfCompany = arrayOfCompany[0];
        company  = [[Company alloc] initWithJsonDictionary:dictionaryOfCompany];
        
        NSArray *arrayOfPreference  = dict[@"preference"];
        NSDictionary *dictionaryOfPreference = arrayOfPreference[0];
        preference  = [[Preference alloc] initWithJsonDictionary:dictionaryOfPreference];
        
        NSArray *arrayOfStatus  = dict[@"status"];
        NSDictionary *dictionaryOfStatus = arrayOfStatus[0];
        status  = [[Status alloc] initWithJsonDictionary:dictionaryOfStatus];
         
	}
    
	return self;
}

@end
