//
//  NearDymanicImageCell.h
//  RitaApp
//
//  Created by BBC on 16/7/15.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearDymanicImageCell : UICollectionViewCell


@property(nonatomic,strong) UIImageView * show_imageView;
/**
 *  更新cell
 *
 *  @param imgUrl <#imgUrl description#>
 */
-(void)updateImageViewWithImageUrl:(NSString *)imageUrl withIndex:(NSIndexPath*)index;
 
@end   
      
