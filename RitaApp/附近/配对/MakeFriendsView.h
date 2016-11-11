//
//  MakeFriendsView.h
//  RitaApp
//
//  Created by BBC on 16/7/20.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeFriendsView : UIView


/**
 *  按钮事件
 */
@property(nonatomic,copy) void(^makeFriendAcction)(NSInteger index);

/**
 *  更新数据
 *
 *  @param dic <#dic description#> 
 */
-(void)updateMakeFriendsViewArray:(NSArray *)array;


@end
 