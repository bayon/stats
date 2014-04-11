//
//  Company.h
//  API1
//
//  Created by Bayon Forte on 4/11/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//
#import <Foundation/Foundation.h>


// L E F T   O F F   H E R E    get this class set up , check tehm all and then see if we can do a successful download and parse.


@interface Company : NSObject

@property (nonatomic, retain) NSString *company_id;
@property (nonatomic, retain) NSString *subdomain;
@property (nonatomic, retain) NSString *name;

-(Company *)initWithJsonDictionary:(NSDictionary *)dict;

@end


/*


 "id": "31",
 "subdomain": "bwebb-gemini",
 "name": "Schinner, Kulas and Upton",
 "parent_company_id": null,
 "company_status_id": "7",
 "company_type_id": "3",
 "website_url": "http://cummings.biz/",
 "physical_address": "031 Mariana Plaza",
 "physical_city": "Jewesstown",
 "physical_state": "NM",
 "physical_postal_code": "38194",
 "office_phone": "549-281-9392",
 "office_fax": "038.925.3423",
 "unit_count": "213",
 "corporate_contact_name": "Rosemary Howe",
 "corporate_contact_title": "Quis iusto est.",
 "primary_contact_name": "Elza Fadel",
 "primary_contact_title": "Soluta officiis eum.",
 "primary_contact_phone": "01683501476",
 "primary_contact_email": "vicenta.langworth@example.com",
 "sales_rep_id": "3",
 "billing_id_number": "6b3ca340-02b8-3592-a8b7-3b3454b50078",
 "billing_address": "62246 Berry Port Apt. 530",
 "billing_city": "South Maxie",
 "billing_state": "FL",
 "billing_postal_code": "77127-2997",
 "billing_contact_name": "Chadrick Kshlerin",
 "billing_contact_title": "Cum officiis praesentium",
 "billing_contact_phone": "073-164-9809",
 "billing_contact_email": "zpollich@example.org",
 "property_software_type_id": "1",
 "created_at": "2014-02-21 23:04:56",
 "updated_at": "2014-02-21 23:04:56",
 "deleted_at": null,
 "pivot": {
 "user_id": "31",
 "company_id": "31"
 },
 "companies": [],
 "preference_settings": [],
 "parent_company": null
*/