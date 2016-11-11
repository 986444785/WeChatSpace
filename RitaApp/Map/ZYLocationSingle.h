//
//  ZYLocationSingle.h
//  RitaApp
//
//  Created by BBC on 16/7/22.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

@interface ZYLocationSingle : NSObject

/**
 *  第一次创建
 */
@property(nonatomic,assign) BOOL isInit;

/**
 *  经度 
 */
@property(nonatomic,copy) NSString * log;

/** 
 *  纬度
 */
@property(nonatomic,copy) NSString * lat;
/**
 *  城市
 */
@property(nonatomic,copy) NSString * city;
/**
 *  区
 */
@property(nonatomic,copy) NSString * district;
/**
 *  附近
 */
@property(nonatomic,copy) NSString * nearInfo;



/**
 *  第一次创建
 */



/**
 *  第一次创建
 */


/**
 *  创建单例
 */
+(ZYLocationSingle*)defaultSingleLocation;

/** 
 *  获取位置
 */
- (void)getLocationInfo;

@end
