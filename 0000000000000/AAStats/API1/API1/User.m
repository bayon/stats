//
//  User.m
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize role,  preference, status, usersHomeCompany; //company
@synthesize arrayOfPreferences, arrayOfRoles, arrayOfStatuses, arrayOfCompanies = _arrayOfCompanies;
@synthesize user_id, first_name, last_name, mobile_phone_number, alt_phone_number, alt_phone_type_id, email, created_at, updated_at, deleted_at;


- (id)initWithJsonDictionary:(NSDictionary *)dict {
	self = [super init];
	if (self) {
		NSLog(@"\n F I L E -> F U N C T I O N : \n %s \n", __FUNCTION__);
		self.user_id                = dict[@"id"];
		self.first_name             = dict[@"first_name"];
		self.last_name              = dict[@"last_name"];
		self.mobile_phone_number    = dict[@"mobile_phone_number"];
		self.alt_phone_number       = dict[@"alt_phone_number"];
		self.alt_phone_type_id      = dict[@"alt_phone_type_id"];
		self.email                  = dict[@"email"];
		self.created_at             = dict[@"created_at"];
		self.updated_at             = dict[@"updated_at"];
		self.deleted_at             = dict[@"deleted_at"];

		//Role
		NSArray *arrayOfRole  = dict[@"role"];
		NSDictionary *dictionaryOfRole = arrayOfRole[0];
		role  = [[Role alloc] initWithJsonDictionary:dictionaryOfRole];

		//Company
		NSArray *arrayOfCompany  = dict[@"companies"];
        _arrayOfCompanies = [[NSMutableArray alloc]init];
		//GET ALL COMPANIES OF A USER
		for (NSDictionary *dictionaryOfCompany in arrayOfCompany) {
            
            //view keys and values    /////////////
            for(id key in dictionaryOfCompany) {
                
                id value = [dictionaryOfCompany objectForKey:key];
                
                // NSLog(@"Value is NOT an Array");
                NSString *keyAsString = (NSString *)key;
                NSString *valueAsString = (NSString *)value;
               
                 NSLog(@"key: %@", keyAsString);
                NSLog(@"value: %@", valueAsString);
                
                // SUBCOMPANIES
                
                if([keyAsString isEqualToString:@"companies"]){
                    
                    NSLog(@"\n loop thru sub companies");
                    NSArray *arrayOfSubCompanies  = dict[@"companies"];
                    NSLog(@"\n arrayOfSubCompanies: %@",arrayOfSubCompanies);
                    
                    for (NSDictionary *dictionaryOfSubCompanies in arrayOfSubCompanies) {
                        
                        
                        
                        //NSLog(@"\n \n   SUBCOMPANIES:%@ \n \n ", dictionaryOfSubCompanies);
                        
                       // Company *subCompany  = [[Company alloc] initWithJsonDictionary:dictionaryOfSubCompany];
                        //[_arrayOfCompanies addObject:subCompany];
                        
                        
                        for(id key in dictionaryOfSubCompanies) {
                            id value = [dictionaryOfSubCompanies objectForKey:key];
                           BOOL valueIsArray = [value isKindOfClass:[NSArray class]];
                            
                            
                            
                            // NSLog(@"Value is NOT an Array");
                            NSString *keyAsString = (NSString *)key;
                            NSString *valueAsString = (NSString *)value;
                            
                            
                            if([keyAsString isEqualToString:@"companies"]){
                               
                            }
                            if(valueIsArray){
                                
                                
                                // companies or preference_settings
                                
                                
                                if([keyAsString isEqualToString:@"companies"]){
                                    
                                    NSLog(@"key: %@", keyAsString);
                                    NSLog(@"value: %@", valueAsString);
                                    // for each dictionary in value array
                                    for(NSDictionary *dict in value){
                                        NSLog(@"\n \n   SUBCOMPANY SINGULAR");
                                        /////////////////////////////////////////
                                        
                                        Company *subCompany  = [[Company alloc] initWithJsonDictionary:dict];
                                        [_arrayOfCompanies addObject:subCompany];
                                        
                                        
                                        ////////////////////////////////////////
                                    }
                                }
                                
                            }
                            
                            
                            // Company *subCompany  = [[Company alloc] initWithJsonDictionary:dictionaryOfSubCompany];
                            //[_arrayOfCompanies addObject:subCompany];
                            
                        }
                        
                        
                    }
                    
                    
                    
                }
                
            }
            
            /////////////
            
			Company *company  = [[Company alloc] initWithJsonDictionary:dictionaryOfCompany];
            [_arrayOfCompanies addObject:company];
		}


		//Preference
		NSArray *arrayOfPreference  = dict[@"preference"];
		NSDictionary *dictionaryOfPreference = arrayOfPreference[0];
		preference  = [[Preference alloc] initWithJsonDictionary:dictionaryOfPreference];

		//Status
		NSArray *arrayOfStatus  = dict[@"status"];
		NSDictionary *dictionaryOfStatus = arrayOfStatus[0];
		status  = [[Status alloc] initWithJsonDictionary:dictionaryOfStatus];
	}

	return self;
}


-(NSMutableArray *) getAllCompanies{
    NSLog(@"array of companies? %@",_arrayOfCompanies);
    return _arrayOfCompanies;
}


@end
