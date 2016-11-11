//
//  HGTitleView.h
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Header.h"
@class HGTitleView;
@protocol HGTitleViewDelegate <NSObject>

@optional
-(void)titleView:(HGTitleView*)titleView scrollToIndex:(NSInteger)tagIndex;

@end   
    
@interface HGTitleView : UIView

@property (nonatomic,weak) id<HGTitleViewDelegate>delegate;
 
//设置默认选择
-(void)wanerSelected:(NSInteger)tagIndex;
 
//设置标题
-(void)setupButtonWithTitles:(NSArray *)titles;

@end
     
