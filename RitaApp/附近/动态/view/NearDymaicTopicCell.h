//
//  NearDymaicTopicCell.h
//  RitaApp
//
//  Created by BBC on 16/7/15.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearDynamicModel.h"
@interface NearDymaicTopicCell : UICollectionViewCell

/**
 *  更新数据
 *
 *  @param model <#model description#>
 */
//-(void)updateTopciWithModel:(NearDynamicModel *)model;
-(void)updateTopciWithModel:(NearDynamicModel *)model withIndex:(NSIndexPath*)indexPath;

@property(nonatomic,copy) void(^avatarImageViewAction)(NSInteger index);
   
@end  
  
