//
//  NearFootReusableView.h
//  RitaApp
//
//  Created by BBC on 16/7/17.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearDynamicModel.h"
@interface NearFootReusableView : UICollectionReusableView

/**
 *  点赞按钮事件
 */
@property(nonatomic,copy) void(^zanAction)(NSInteger index);
/**
 *  评论按钮事件
 */
@property(nonatomic,copy) void(^commentAction)(NSInteger index);
/**
 *  更多按钮事件
 */      
@property(nonatomic,copy) void(^moreAction)(NSInteger index);


-(void)updateNearFootReusableViewWithModel:(NearDynamicModel *)model withIndex:(NSIndexPath*)indexPath ;
@end
   