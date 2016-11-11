//
//  PersonalheaderView.m
//  RitaApp
//
//  Created by BBC on 16/7/21.
//  Copyright © 2016年 Chen. All rights reserved.
//
 
#import "PersonalheaderView.h"

@interface PersonalheaderView ()

@property(nonatomic,strong) UIImageView * avatar_imageView;
@property(nonatomic,strong) UILabel * nick_lable;
@property(nonatomic,strong) UILabel * info_lable;

@end

@implementation PersonalheaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setPersonalheaderView];
    }
    return self;
}

-(void)setPersonalheaderView{

    _avatar_imageView = [UIImageView new];
    [self addSubview:_avatar_imageView];
    _avatar_imageView.layer.masksToBounds = YES;
    _avatar_imageView.layer.cornerRadius = 30;

    [_avatar_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-30);
        make.width.height.equalTo(@60);
    }];


    _nick_lable = [UILabel new];
    [self addSubview:_nick_lable];
    _nick_lable.textColor = [UIColor whiteColor];

    [_nick_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_avatar_imageView.mas_bottom).offset(10);
        make.height.equalTo(@20);
    }];


    _info_lable = [UILabel new];
    [self addSubview:_info_lable];
    _info_lable.font = [UIFont systemFontOfSize:14];
    _info_lable.textColor = [UIColor whiteColor];

    [_info_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_nick_lable.mas_bottom).offset(10);
        make.height.equalTo(@20);
    }];

}

-(void)updatePersonalheaderViewWithDict:(NSDictionary *)dict{
    _nick_lable.text = @"兔八哥&🌛";
    _info_lable.text = @"我本楚狂人，凤歌笑孔丘！";
    _avatar_imageView.image = [UIImage imageNamed:@"cover_avatar_3.png"];
}





@end
