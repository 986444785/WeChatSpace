//
//  HttpHelper.m
//  RitaApp
//
//  Created by BBC on 16/7/12.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "HttpHelper.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#define  login_url            @"user/oauth-weixin"           //登录
#define  focus_on             @"user/follow"                 //关注
#define user_info             @"user/profile"                //个人信息

#define  dynamic_list         @"social/feed/list"            //动态列表
#define  dynamic_detail       @"social/feed/detail"          //动态详情
#define  dynamic_comment_list @"social/feed/comments"        //评论列表
#define  write_comment        @"social/feed/do-comment"      //评论
#define  give_zan             @"social/feed/do-good"         //点赞
#define  write_dynamic        @"social/feed/create"          //发布动态
#define  delete_dinamic       @"social/feed/delete"   //删除动态
#define  online_list          @"social/pair/online"     //在线配对列表
#define random_match          @"social/pair/rand"   //随机配
#define matching_user         @"social/pair/do-fetch"   //匹配
#define match_count           @"social/pair/now-list"//已匹配的数量
@implementation HttpHelper

#pragma mark  【一键登录】 
+(void)loginWithaccess_token:(NSString*)access_token  withOpenID:(NSString*)openid complate:(void(^)(BOOL success))complate{ 


    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:access_token,@"access_token",openid,@"openid", nil];
    NSString * URL = [NSString stringWithFormat:@"%@%@",BASE_URL,login_url];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSDictionary * dataDic = responseObject[@"data"];
        //存储用户id    token
        [[NSUserDefaults standardUserDefaults]setObject:dataDic[@"token"] forKey:USER_TOKEN];
        NSDictionary * user = dataDic[@"user"];
        [[NSUserDefaults standardUserDefaults]setObject:user[@"id"] forKey:USER_ID];
        [[NSUserDefaults standardUserDefaults]synchronize];

        complate(YES);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [LSFMessageHint showToolMessage:[NSString stringWithFormat:@"%@",error] hideAfter:1.5 yOffset:0];
        complate(NO);
    }];


}

/**
 *  用户id
 */
+(NSString *)getUer_id{
    NSString * user_id = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    if (!user_id) {
        [LSFMessageHint showToolMessage:@"需要微信登录 --- 待处理" hideAfter:1.0 yOffset:0];
    }
    return user_id;
}
 
/**
 *   用户Token
 *
 *  @return <#return value description#>
 */
+(NSString *)getUser_token{

    NSString * user_token = [[NSUserDefaults standardUserDefaults]objectForKey:USER_TOKEN];

    if (!user_token) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [LSFMessageHint showToolMessage:@"需要微信登录 -token-- 待处理" hideAfter:2.0 yOffset:0];
        });
    }

    return [NSString stringWithFormat:@"Bearer %@",user_token];
}
 
#pragma mark 【关注用户】
+(void)requestFocusUserWithID:(NSString *)user_id complate:(void(^)(NSDictionary *responsedic))complate{

    NSString * URL = [NSString stringWithFormat:@"%@%@",BASE_URL,focus_on];
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user_id,@"id",nil];

    AFHTTPSessionManager * manager  = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];

    [manager POST:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LSFMessageHint showToolMessage:[NSString stringWithFormat:@"%@",error] hideAfter:1.5 yOffset:0];
        complate(nil);
    }];


}

 

#pragma mark 【动态列表】

+(void)requestNearDynamicListWithUid:(NSString *)uid withPage:(NSInteger)page witjLog:(NSString*)log withLat:(NSString *)lat complate:(void(^)(NSDictionary *responseDic))complate{

    NSString * URL = [NSString stringWithFormat:@"%@%@",BASE_URL,dynamic_list];

    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)page],@"page",uid,@"uid", log,@"lng",lat,@"lat",nil];

    AFHTTPSessionManager * manager  = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];
    
    [manager POST:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LSFMessageHint showToolMessage:[NSString stringWithFormat:@"%@",error] hideAfter:1.5 yOffset:0];
        complate(nil);
    }];

}

 

#pragma mark  【动态详情】
+(void)requestDynamicDetailWithdynamyc_id:(NSString*)dynamyc_id  complate:(void(^)(NSDictionary * responseDic))complate{

    NSString * URL = [NSString stringWithFormat:@"%@%@",BASE_URL,dynamic_detail];

    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:dynamyc_id,@"id", nil];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LSFMessageHint showToolMessage:[NSString stringWithFormat:@"%@",error] hideAfter:1.5 yOffset:0];
        complate(nil);
    }];


} 
 
#pragma mark 【评论列表】
+(void)requestCommentListWithDynamic_id:(NSString*)dynamic_id  withPage:(NSString *)page  complate:(void(^)(NSDictionary * responseDic))complate{

    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:dynamic_id,@"id",page,@"page", nil];

    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,dynamic_comment_list];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LSFMessageHint showToolMessage:[NSString stringWithFormat:@"%@",error] hideAfter:1.5 yOffset:0];
        complate(nil);
    }];


} 
 
#pragma mark 【给评论】
+(void)writeCommentWithContent:(NSString *)content withDynamic_id:(NSString *)dynamic_id complate:(void(^)(NSDictionary * responsedic))complate{

    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,write_comment];

    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:dynamic_id,@"id",content,@"content", nil];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];

    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];
}


#pragma mark 【给动态点赞】
+(void)diantZanWithDynamic_id:(NSString*)dynamic_id  complate:(void(^)(NSDictionary * responseDic))complate {

    ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];
    //获取用户id
    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,give_zan];
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:dynamic_id,@"id",single.lat,@"lat",single.log,@"lng",nil];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];

    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];
}


#pragma mark 【发布动态】
+(void)writeDynamicWithContent:(NSString *)content WithImages:(NSArray *)images WithAddress:(NSString *)address withDelegate:(id)delegate complate:(void(^)(NSDictionary *responseDic))complate{
    ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];

    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:content,@"content",address,@"address",single.lat,@"lat",single.log,@"lng", nil];

    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,write_dynamic];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];


    UIViewController * vc = delegate;
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:vc.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.label.text = @"Loading";

    [manager POST:URL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (int i = 0; i< images.count; i++) {
            NSData * imageData = UIImageJPEGRepresentation(images[i], 1.0);
            [formData appendPartWithFileData:imageData name:@"showImage" fileName:@"gallery[]" mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {

        NSProgress *progress = (NSProgress *)uploadProgress;

        hud.progress = progress.fractionCompleted;

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

         hud.hidden = YES;
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        hud.hidden = YES;
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];


} 
 

#pragma mark  【删除动态】
+(void)deleteDynamicWithDynamic_id:(NSString *)dynamic_id complate:(void(^)(NSDictionary *responseDic))complate{

    //获取用户id
    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,delete_dinamic];
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:dynamic_id,@"id",nil];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];

    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];


}


#pragma mark 【获取个人信息】
+(void)getPersonalInfoWithUser_id:(NSString *)user_id complate:(void(^)(NSDictionary * responseDic))complate{

    //获取用户id
    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,user_info];
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user_id,@"id",nil];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];

    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];
}




#pragma mark 【用户间交配】
+(void)matchingToUserWithUser_id:(NSString *)user_id complate:(void(^)(NSDictionary *responseDic))complate{
    //获取用户id
    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,matching_user];
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:user_id,@"id", nil];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];


    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];
}
  
#pragma mark 【在线配对人】
+(void)getOnlineMatchtWithPage:(NSString *)page conplate:(void(^)(NSDictionary * responseDic))complate{

    //获取用户id
    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,online_list];
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:page,@"page",nil];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];

    [manager POST:URL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];
}
 
#pragma mark  【随机交配】
+(void)getRandomMatchComplate:(void(^)(NSDictionary * resposeDic))complate{
    //获取用户id
    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,random_match];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];

    [manager POST:URL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];
}

 
#pragma mark  【已经匹配人数】
+(void)hadMatchCountComplate:(void(^)(NSDictionary * resposeDic))complate{
    //获取用户id
    NSString * URL =[NSString stringWithFormat:@"%@%@",BASE_URL,match_count];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //自定义参数
    [manager.requestSerializer setValue:[self getUser_token] forHTTPHeaderField:@"Authorization"];

    [manager POST:URL parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        complate(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了   %@",error);
        complate(nil);
    }];
}



#pragma mark 【计算长度】 
+(float)getTextLengthWith:(NSString *)text  WithFont:(float)textFont WithWidth:(float)maxwidth
{
    float Width = [text boundingRectWithSize:CGSizeMake(10000, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil].size.width;
    if (Width>maxwidth) {
        return maxwidth;
    }
    return Width;
} 

#pragma mark 发送通知更新动态列表数据
+(void)refreshDynamicList{
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    NSNotification * notify = [[NSNotification alloc]initWithName:@"REFRESH_DYNAMIC" object:self userInfo:nil];
    [center postNotification:notify];
} 

#pragma mark 【计算高度】
+(float)getTextHeightWith:(NSString *)text  WithFont:(float)textFont WithMaxWidth:(float)maxWidth
{
    float height = [text boundingRectWithSize:CGSizeMake(maxWidth, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont]} context:nil].size.height;

    return height;
}

  
 
#pragma mark --- 计算文字高度
+ (CGFloat)getTextHeightWithText:(NSString *)text
                           width:(CGFloat)width
                        fontSize:(CGFloat)fontSize
                       linespace:(CGFloat)linespace{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:linespace];
    NSDictionary *attributes  = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:fontSize],
                                  NSParagraphStyleAttributeName : paragraphStyle
                                  };
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];

    return rect.size.height;
}





@end
