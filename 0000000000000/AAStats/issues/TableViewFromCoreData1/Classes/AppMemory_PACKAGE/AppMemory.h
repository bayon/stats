//
//  AppMemory.h
//  jack
//
//  Created by frederick forte on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataObject.h"

@interface AppMemory : AppDataObject{
    NSString *mem_text1;
    NSString *mem_text2;
    NSMutableArray *mutableArray;
  
}
@property(nonatomic,copy)NSString *mem_text1;
@property(nonatomic,copy)NSString *mem_text2;
@property(nonatomic,retain)NSMutableArray *mutableArray;

@end