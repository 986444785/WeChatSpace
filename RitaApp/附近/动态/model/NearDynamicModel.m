//
//  NearDynamicModel.m
//  RitaApp
//
//  Created by BBC on 16/7/16.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "NearDynamicModel.h"
#import "DynamicCommentM.h"
#import "DynamicImageM.h"
#import "DynamicTopicM.h"
@implementation NearDynamicModel

 
+(NSMutableArray *)nearDynamicWithDict:(NSDictionary *)dict
{
   
    NSMutableArray * mutableArray = [NSMutableArray array];

        //信息cell数据

    NSDictionary * user        = dict[@"user"];
    if (user) {
        DynamicTopicM * topicModel = [DynamicTopicM dymaicTopicModelWithDictionary:user];
        topicModel.cell_type       = @"topc_cell";

        topicModel.content         = dict[@"content"]; 
        topicModel.dynamicID       = dict[@"id"];
        topicModel.owner           = [dict[@"owner"] boolValue];

        NSLog(@"拥有者  %d",topicModel.owner);
        //判断时间是否为<null>
        if ([dict[@"ago"] isKindOfClass:[NSNull class]]) {
            topicModel.time   = @"未知";
        }else{
            topicModel.time            = dict[@"ago"];
        }

        //判断是否评论列表数据
        int width = 40;
        if (dict[@"count"] == nil) {
            width = 70;  
        } 
        topicModel.cell_height     =  80 + [HttpHelper getTextHeightWithText: topicModel.content width:(KSCREEN_WIDTH-width) fontSize:14 linespace:0];

        [mutableArray  addObject:topicModel];
    }

         
    //图片cell数据
    NSArray * images = dict[@"gallery"];

    for (int i = 0; i<images.count; i++) {
        DynamicImageM * imageModel = [[DynamicImageM alloc]init];
        imageModel.image_url = images[i];
        imageModel.cell_type = @"image_cell";
        imageModel.show_images = images;
 
        float image_height = KSCREEN_WIDTH/3-5 ;
        if (images.count == 1) {

            image_height = KSCREEN_WIDTH-20;
        }else if (images.count == 2 || images.count == 4){

            image_height = KSCREEN_WIDTH/2-6;
        }

        imageModel.image_hight    = image_height;
        [mutableArray  addObject:imageModel];
    }
   
 
  

    //评论cell数据
    NSDictionary * countDic = dict[@"count"];
    if (countDic) {
        DynamicCommentM * commentModel = [DynamicCommentM dymaicCommentModelWithDictionary:dict[@"count"]];
        commentModel.cell_type         = @"comment_cell";
        commentModel.address           = dict[@"address"];
        commentModel.distance          = dict[@"km"];
        commentModel.dynamicID         = dict[@"id"];
        if ([commentModel.distance floatValue] == 0) {
            commentModel.distance = @"";
        }
 
//        if (commentModel.address.length > 1  || commentModel.distance.length > 1) {
            commentModel.cell_height = 60;
//        }else{
//            commentModel.cell_height = 40;
//        }
        [mutableArray addObject:commentModel];
    }

    return mutableArray;
    
}


@end
