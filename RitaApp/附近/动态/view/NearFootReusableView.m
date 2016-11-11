//
//  NearFootReusableView.m
//  RitaApp
//
//  Created by BBC on 16/7/17.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "NearFootReusableView.h"

@interface NearFootReusableView ()
@property(nonatomic,strong) UIButton    * comment_button;
@property(nonatomic,strong) UIButton    * zan_button;
@property(nonatomic,strong) UILabel     * comment_lable;
@property(nonatomic,strong) UIImageView * comment_imageView;
@property(nonatomic,strong) UILabel     * zan_lable;
@property(nonatomic,strong) UIImageView * zan_imageView;

@property(nonatomic,strong) UIImageView * locaton_imageView;
@property(nonatomic,strong) UILabel     * location_lable;

@property(nonatomic,strong)    UIButton * moreButton;
@end
    

@implementation NearFootReusableView

-(id)initWithFrame:(CGRect)frame
{
    self  =[super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        [self setNearDymaincCommentCell];
    }
    return self;
}
 

-(void)setNearDymaincCommentCell{
 
    //地址

//    if (self.frame.size.height > 40) {
        _locaton_imageView = [UIImageView new];
        [self addSubview:_locaton_imageView];


        [_locaton_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(5);
            make.height.equalTo(@15);
            make.width.equalTo(@15);
        }];


        _location_lable = [UILabel new];
        [self addSubview:_location_lable];


        _location_lable.font = [UIFont systemFontOfSize:12];
        _location_lable.textColor = [UIColor grayColor];

        [_location_lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_locaton_imageView.mas_right).offset(5);
            make.top.equalTo(_locaton_imageView.mas_top);
            make.right.equalTo(self.mas_right).offset(-30);
            make.height.equalTo(@15);
        }];
//    }


     //更多操作
     _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_moreButton];

    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.height.equalTo(@20);
        make.width.equalTo(@30);
    }];
    [_moreButton setImage:[UIImage imageNamed:@"more_action"] forState:UIControlStateNormal];
    

    //评论
    _comment_lable = [UILabel new];
    [self addSubview:_comment_lable];
    _comment_lable.font = [UIFont systemFontOfSize:12];
    _comment_lable.textColor = [UIColor grayColor];

    [_comment_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-50);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.height.equalTo(@20);
    }];

    _comment_imageView = [UIImageView new];
    [self addSubview:_comment_imageView];

    [_comment_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_comment_lable.mas_left).offset(-5);
        make.top.equalTo(_comment_lable.mas_top).offset(3);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];


    _comment_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_comment_button];
    [_comment_button addTarget:self action:@selector(commentButtonclick:) forControlEvents:UIControlEventTouchUpInside];

    [_comment_button mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(self.mas_right).offset(-45);
        make.left.equalTo(_comment_imageView.mas_left);
        make.top.equalTo(_comment_lable.mas_top);
        make.bottom.equalTo(self.mas_bottom);

    }];



    //赞

    _zan_lable = [UILabel new];
    [self addSubview:_zan_lable];
    _zan_lable.font = [UIFont systemFontOfSize:12];
    _zan_lable.textColor = [UIColor grayColor];

    [_zan_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_comment_imageView.mas_left).offset(-15);
        make.top.equalTo(_comment_lable.mas_top);
        make.height.equalTo(@20);
    }];

    _zan_imageView = [UIImageView new];
//    _zan_imageView.backgroundColor = [UIColor redColor];
    [self addSubview:_zan_imageView];

    [_zan_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_zan_lable.mas_left).offset(-5);
        make.top.equalTo(_comment_lable.mas_top).offset(3);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
 
     

    _zan_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_zan_button];
    [_zan_button addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [_zan_button mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(self.comment_imageView.mas_left).offset(-2);
        make.left.equalTo(_zan_imageView.mas_left);
        make.top.equalTo(_comment_lable.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];

//    _zan_button.backgroundColor = [UIColor orangeColor];

    //底部颜色线条
    UILabel * line_lable = [UILabel new];
    [self addSubview:line_lable];
    line_lable.backgroundColor = TB_BGColor;

    [line_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@10);
        make.bottom.equalTo(self.mas_bottom);
    }];


    _locaton_imageView.image = [UIImage imageNamed:@"com_location.png"];

    _comment_imageView.image = [UIImage imageNamed:@"icon-comment.png"];

    _zan_imageView.image = [UIImage imageNamed:@"icon-heart.png"];
    

} 
   
 
-(void)updateNearFootReusableViewWithModel:(NearDynamicModel *)model withIndex:(NSIndexPath*)indexPath {

    _location_lable.text = [NSString stringWithFormat:@"%@ %@",model.distance,model.address];

    _comment_button.tag = indexPath.section;

    _zan_button.tag = indexPath.section;

    _moreButton.tag = indexPath.section;

    _comment_lable.text =  [NSString stringWithFormat:@"评论(%@)",model.comment_count] ;

    _zan_lable.text =[NSString stringWithFormat:@"赞(%@)",model.zan_count] ;

}

 

-(void)moreButtonClick:(UIButton *)sender{
    _moreAction(sender.tag);
}


-(void)commentButtonclick:(UIButton*)sender
{
    _commentAction(sender.tag);
}

-(void)zanButtonClick:(UIButton *)sender{

    _zanAction(sender.tag);
}


@end
