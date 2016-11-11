//
//  HGTitleView.m
//  HiGo
//
//  Created by Think_lion on 15/7/25.
//  Copyright (c) 2015年 Think_lion. All rights reserved.
//

#import "HGTitleView.h"

@interface HGTitleView ()
@property (nonatomic,weak) UIButton *button;
@property(nonatomic,strong) UILabel * lineLable;
@end

@implementation HGTitleView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        //添加 3 个按钮

    }
    return self;
}

//设置标题
-(void)setupButtonWithTitles:(NSArray *)titles
{
    
    for(NSString * title in titles){
        [self addButton:title];
    }

    [self addLineLableWithIndex:0];
}

-(void)addButton:(NSString*)title
{
    UIButton *btn=[[UIButton alloc]init];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}


-(void)titleButtonClick:(UIButton*)sender
{
    if([self.delegate respondsToSelector:@selector(titleView:scrollToIndex:)]){
        [self.delegate titleView:self scrollToIndex:sender.tag];
    } 

    self.button.selected=NO;
//    self.button.titleLabel.font = [UIFont systemFontOfSize:15];
    sender.selected=YES;
//    sender.titleLabel.font = [UIFont systemFontOfSize:18];
    self.button=sender;
} 
 
-(void)wanerSelected:(NSInteger)tagIndex
{
    self.button.selected=NO;
//    self.button.titleLabel.font=[UIFont systemFontOfSize:15];
    UIButton *btn=self.subviews[tagIndex];
    btn.selected=YES;
//    btn.titleLabel.font=[UIFont systemFontOfSize:18];
    self.button=btn;


    [UIView animateWithDuration:0.2 animations:^{
//        _lineLable.frame = CGRectMake(btn.frame.origin.x+5, self.frame.size.height-1.5,50, 1.5);

        _lineLable.center = CGPointMake(btn.center.x, self.frame.size.height-2);
    } completion:^(BOOL finished) {

    }];


}


#pragma mark -- 【添加下划线】
-(void)addLineLableWithIndex:(NSInteger)index{

    if (!_lineLable) {
        _lineLable = [[UILabel alloc]init];
        _lineLable.backgroundColor = [UIColor redColor];
//        UIButton *btn=self.subviews[0];
//        _lineLable.bounds = CGRectMake(0, 0,50, 1.5);
//
//        _lineLable.center = CGPointMake(btn.center.x, self.frame.size.height-2);

        [self addSubview:_lineLable];
    }

}




-(void)layoutSubviews 
{
    CGFloat btnY=0;
    int count=(int)self.subviews.count - 1;
    CGFloat btnX=0;
    CGFloat btnW = self.frame.size.width/count;
    CGFloat btnH = self.frame.size.height;
    for(int i=0;i<count;i++){
        btnX=btnW*i;
        UIButton *btn=self.subviews[i];
        btn.tag=i;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);

//        if (i==0) {
//            _lineLable.bounds = CGRectMake(0, 0,50, 1.5);
//
//            _lineLable.center = CGPointMake(btn.center.x, self.frame.size.height-2);
//
//        }
    }





}

@end
