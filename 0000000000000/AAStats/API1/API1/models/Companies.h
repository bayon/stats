//
//  Companies.h
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface Companies : NSObject

@property (nonatomic, retain) NSString *company_id;
@property (nonatomic, retain) NSString *subdomain;
@property (nonatomic, retain) NSString *name;

-(Companies *)initWithJsonDictionary:(NSDictionary *)dict;

@end
