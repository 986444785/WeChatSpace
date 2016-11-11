//
//  NearDynamicModel.h
//  RitaApp
//
//  Created by BBC on 16/7/16.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearDynamicModel : NSObject

@property(nonatomic,copy) NSString * cell_type;

@property(nonatomic,assign) float cell_height;
   
//topic    
@property(nonatomic,copy) NSString * nickName;
@property(nonatomic,copy) NSString * user_id;         //用户
@property(nonatomic,copy) NSString * avatarImage;
@property(nonatomic,copy) NSString * level;
@property(nonatomic,copy) NSString * time; 
@property(nonatomic,copy) NSString * sex; 
@property(nonatomic,copy) NSString * signature;
@property(nonatomic,copy) NSString * fans_count; 
@property(nonatomic,assign) NSInteger  vip; 
@property(nonatomic,copy) NSString * age;
@property(nonatomic,assign) BOOL owner;
 

@property(nonatomic,copy) NSString * dynamicID;     //评论
 

@property(nonatomic,copy) NSString * content;

@property(nonatomic,strong)NSArray * show_images;
  
//iameg 
@property(nonatomic,copy) NSString * image_url; 
@property(nonatomic,assign) float image_hight;
 
//comment 
@property(nonatomic,copy) NSString * comment_count;
@property(nonatomic,copy) NSString * zan_count;
@property(nonatomic,copy) NSString * read_cout;

@property(nonatomic,copy) NSString * address;
@property(nonatomic,copy) NSString * distance;

   
/**
 *  解析数据
 *
 *  @param dic <#dic description#>
 *
 *  @return <#return value description#>
 */
+(NSMutableArray *)nearDynamicWithDict:(NSDictionary *)dict;
@end
  