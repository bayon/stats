//
//  User.h
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString *user_id;
@property (nonatomic, retain) NSString *first_name;
@property (nonatomic, retain) NSString *last_name;

-(User *)initWithJsonDictionary:(NSDictionary *)dict;



// NOTE: probably want an array of company objects... each user.

@end



/*
 
 "id": "31",
 "first_name": "Brian",
 "last_name": "Webb",
 "mobile_phone_number": "5552987961",
 "alt_phone_number": "",
 "alt_phone_type_id": null,
 "email": "bwebb@indatus.com",
 "created_at": "2014-02-21 23:04:56",
 "updated_at": "2014-02-21 23:04:56",
 "deleted_at": null,
 "companies": [] ARRAY OF COMPANIES ---------------
 
 ,
 "user_statuses": [],
 "preference_settings": []
 */
