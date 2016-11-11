//
//  NearCommentCell.h
//  RitaApp
//
//  Created by BBC on 16/7/18.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearDynamicModel.h"
@interface NearCommentCell : UICollectionViewCell

/**
 *  点击头像按钮事件
 */
@property(nonatomic,copy) void(^avatarAcction)(NSInteger index);
 
-(void)updateNearCommentWithModel:(NearDynamicModel *)model withIndex:(NSIndexPath*)index;
@end
