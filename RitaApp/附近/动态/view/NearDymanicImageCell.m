//
//  NearDymanicImageCell.m
//  RitaApp
//
//  Created by BBC on 16/7/15.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "NearDymanicImageCell.h"
#import "UIImageView+WebCache.h"


@interface NearDymanicImageCell ()

@property(nonatomic,strong)    NSArray * show_images;

@end  
 
@implementation NearDymanicImageCell
 

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setIamgeView];
    }
    return self;
}

 
        
-(void)setIamgeView
{
    _show_imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _show_imageView.backgroundColor = [UIColor whiteColor];
    _show_imageView.clipsToBounds  = YES;
    _show_imageView.userInteractionEnabled = YES;
    _show_imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_show_imageView];
} 
  
-(void)updateImageViewWithImageUrl:(NSString *)imageUrl withIndex:(NSIndexPath*)index{

    _show_imageView.frame = self.bounds;

    [_show_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"news_defualt.png"]];


}
 

@end
