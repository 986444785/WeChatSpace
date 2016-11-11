//
//  MakeFriendModel.m
//  RitaApp
//
//  Created by BBC on 16/7/29.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "MakeFriendModel.h"

@implementation MakeFriendModel
 
+(id)makeFriendModelWithDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDictionary:dic];
}

-(id)initWithDictionary:(NSDictionary *)dic{

    self = [super init];
    if (self) {

        self.user_dic = dic[@"user"];
        self.hash_Str = dic[@"hash"];
        self.isMake = NO;

    }
    return self;

}


@end
