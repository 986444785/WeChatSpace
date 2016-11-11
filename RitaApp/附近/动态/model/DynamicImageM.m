//
//  DynamicImageM.m
//  RitaApp
//
//  Created by BBC on 16/7/16.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "DynamicImageM.h"

@implementation DynamicImageM
+(id)dymaicImageModelWithDictionary:(NSDictionary *)dic
{
    return [[self alloc]initWithDictionary:dic];
}


-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {

        //        self.cell_type = @"topic_Cell";

        self.image_url    = dic[@"imageUrl"];
//        self.image_type    = dic[@"type"];

        
    }
    return self; 
}

@end
