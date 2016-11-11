//
//  DynamicDetailVC.h
//  RitaApp
//
//  Created by BBC on 16/7/17.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearDynamicModel.h"
@interface DynamicDetailVC : UIViewController

/**
 *  来自哪个section
 */
@property(nonatomic,assign) NSInteger fromSection;

/**
 *  动态id
 */
@property(nonatomic,copy) NSString * dynamic_id;

/**
 *  isKeyBoard 为YES  进入编辑状态
 */
@property(nonatomic,assign) BOOL isEdit;


/**
 *  记录来自个人中心还是动态列表
 */ 
@property(nonatomic,assign) BOOL isFrom_personal;


@property(nonatomic,strong) NSArray * topArrays;

@end
