//
//  HttpHelper.h
//  RitaApp
//
//  Created by BBC on 16/7/12.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHelper : NSObject

/**
 *  【计算长度】
 */

+(float)getTextLengthWith:(NSString *)text  WithFont:(float)textFont WithWidth:(float)maxwidth;

 
/**
 *  【计算高度】
 */
+(float)getTextHeightWith:(NSString *)text  WithFont:(float)textFont WithMaxWidth:(float)maxWidth;


/**
 *  计算高度带行距
 *
 *  @param text      <#text description#>
 *  @param width     <#width description#>
 *  @param fontSize  <#fontSize description#>
 *  @param linespace <#linespace description#>
 *
 *  @return <#return value description#>
 */
+ (CGFloat)getTextHeightWithText:(NSString *)text
                           width:(CGFloat)width
                        fontSize:(CGFloat)fontSize
                       linespace:(CGFloat)linespace;

/**
 *  发送通知更新动态列表数据
 */
+(void)refreshDynamicList;

/** 
 *  【一键登录】
 *
 *  @return <#return value description#>
 */
+(void)loginWithaccess_token:(NSString*)access_token  withOpenID:(NSString*)openid complate:(void(^)(BOOL success))complate;

/**
 *  【关注好友】
 */
+(void)requestFocusUserWithID:(NSString *)user_id complate:(void(^)(NSDictionary *responsedic))complate;

/**
 *  【获取个人信息】
 *
 *  @return <#return value description#>
 */
+(void)getPersonalInfoWithUser_id:(NSString *)user_id complate:(void(^)(NSDictionary * responseDic))complate;


/**
 *  动态列表
 *
 *  @param uid      <#uid description#>
 *  @param page     <#page description#>
 *  @param log      <#log description#>
 *  @param lat      <#lat description#>
 *  @param complate <#complate description#>
 */
+(void)requestNearDynamicListWithUid:(NSString *)uid withPage:(NSInteger)page witjLog:(NSString*)log withLat:(NSString *)lat complate:(void(^)(NSDictionary *responseDic))complate;


/**
 *  【动态详情】
 *
 *  @return <#return value description#>
 */
+(void)requestDynamicDetailWithdynamyc_id:(NSString*)dynamyc_id complate:(void(^)(NSDictionary * responseDic))complate;


/**
 *  【评论列表】
 *
 *  @return <#return value description#>
 */
+(void)requestCommentListWithDynamic_id:(NSString*)dynamic_id  withPage:(NSString *)page  complate:(void(^)(NSDictionary * responseDic))complate;


/**
 *  动态评论
 *
 *  @param content  <#content description#>
 *  @param complate <#complate description#>
 */
+(void)writeCommentWithContent:(NSString *)content withDynamic_id:(NSString *)dynamic_id complate:(void(^)(NSDictionary *responsedic))complate;

/**
 *  【给动态点赞】
 *
 *  @return <#return value description#>
 */

+(void)diantZanWithDynamic_id:(NSString*)dynamic_id  complate:(void(^)(NSDictionary * responseDic))complate;

/**
 *  【发布动态】
 *
 *  @return <#return value description#>
 */
+(void)writeDynamicWithContent:(NSString *)content WithImages:(NSArray *)images WithAddress:(NSString *)address withDelegate:(id)delegate complate:(void(^)(NSDictionary *responseDic))complate;


/**
 *  【删除动态】
 *
 *  @return <#return value description#>
 */
+(void)deleteDynamicWithDynamic_id:(NSString *)dynamic_id complate:(void(^)(NSDictionary *responseDic))complate;


/** 
 *  【在线配对人】
 */
+(void)getOnlineMatchtWithPage:(NSString *)page conplate:(void(^)(NSDictionary * responseDic))complate;
 
/**
 *  【随机交配】
 *
 *  @return <#return value description#>
 */
+(void)getRandomMatchComplate:(void(^)(NSDictionary * resposeDic))complate;

/**
 *  【用户间交配】 
 *
 *  @return <#return value description#>
 */
+(void)matchingToUserWithUser_id:(NSString *)user_id complate:(void(^)(NSDictionary *responseDic))complate;


/**
 *  【已经匹配人数】
 *
 *  @return <#return value description#>
 */
+(void)hadMatchCountComplate:(void(^)(NSDictionary * resposeDic))complate;



@end
