//
//  DynamicTopicM.m
//  RitaApp
//
//  Created by BBC on 16/7/16.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "DynamicTopicM.h"

@implementation DynamicTopicM
+(id)dymaicTopicModelWithDictionary:(NSDictionary *)dic
{
    return [[self alloc]initWithDictionary:dic];
}


-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {

        self.avatarImage = dic[@"avatar"];
        self.nickName    = dic[@"nickname"];
        self.user_id      = dic[@"id"];
        self.level       = dic[@"level"];
        self.age         = dic[@"age"];
        self.signature   = dic[@"signature"];
        self.sex         = [NSString stringWithFormat:@"%@",dic[@"sex"]] ;
    }
    return self; 
}
@end
