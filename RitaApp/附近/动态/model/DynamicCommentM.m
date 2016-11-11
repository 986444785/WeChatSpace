//
//  DynamicCommentM.m
//  RitaApp
//
//  Created by BBC on 16/7/16.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "DynamicCommentM.h"

@implementation DynamicCommentM
+(id)dymaicCommentModelWithDictionary:(NSDictionary *)dic
{
    return [[self alloc]initWithDictionary:dic];
}


-(id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
       
        self.comment_count = [NSString stringWithFormat:@"%@",dic[@"comment"]];
        self.zan_count     = [NSString stringWithFormat:@"%@",dic[@"good"]];
        self.read_cout     = [NSString stringWithFormat:@"%@",dic[@"read"]];

    }
    return self;
}
@end
