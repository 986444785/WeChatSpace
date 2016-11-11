//
//  MakeFriendModel.h
//  RitaApp
//
//  Created by BBC on 16/7/29.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MakeFriendModel : NSObject

@property(nonatomic,strong) NSDictionary * user_dic;
@property(nonatomic,copy)   NSString * hash_Str;
@property(nonatomic,assign) BOOL isMake;


+(id)makeFriendModelWithDictionary:(NSDictionary *)dic;


@end
