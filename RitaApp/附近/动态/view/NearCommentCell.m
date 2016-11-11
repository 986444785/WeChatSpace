//
//  NearCommentCell.m
//  RitaApp
//
//  Created by BBC on 16/7/18.
//  Copyright © 2016年 Chen. All rights reserved.
//
 
#import "NearCommentCell.h"
#import "UIImageView+WebCache.h"

@interface NearCommentCell ()
@property(nonatomic,strong) UIButton * avatar_button;
@property(nonatomic,strong) UILabel * name_lable;
@property(nonatomic,strong) UILabel * time_address_lable;
@property(nonatomic,strong) UILabel * message_lable;
@property(nonatomic,strong) UILabel * sex_lable;
@end


@implementation NearCommentCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setNearCommentCell];
    }
    return self;
}


-(void)setNearCommentCell{
    //头像
    self.avatar_button = [UIButton new];
    [self.avatar_button addTarget:self action:@selector(avatarButtonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.avatar_button];

    [self.avatar_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];

    //时间——地点
    self.time_address_lable = [UILabel new];
    self.time_address_lable.font = [UIFont systemFontOfSize:12];
    self.time_address_lable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.time_address_lable];


    [self.time_address_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.avatar_button.mas_top);
        make.height.equalTo(@25);
    }];

    //名字
    self.name_lable = [UILabel new];
    self.name_lable.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.name_lable];

    [self.name_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar_button.mas_right).offset(10);
        make.top.equalTo(self.avatar_button.mas_top);
        make.height.equalTo(@25);
        make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-85);

    }]; 
 
    //性别
    self.sex_lable = [UILabel new];
    self.sex_lable.font = [UIFont systemFontOfSize:10];
    self.sex_lable.textColor = [UIColor whiteColor];
    self.sex_lable.backgroundColor = [UIColor colorWithRed:0.984 green:0.631 blue:0.722 alpha:1.000];
    self.sex_lable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.sex_lable];


    [self.sex_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name_lable.mas_right).offset(5);
        make.centerY.equalTo(self.time_address_lable.mas_centerY);
        make.height.equalTo(@12);
    }];

    
    //消息内容
    self.message_lable = [UILabel new];
    self.message_lable.font = [UIFont systemFontOfSize:14];
    self.message_lable.textColor = [UIColor grayColor];
    self.message_lable.numberOfLines = 0;
    [self.contentView addSubview:self.message_lable];

    [self.message_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name_lable.mas_left);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.name_lable.mas_bottom);

    }];
}


-(void)updateNearCommentWithModel:(NearDynamicModel *)model withIndex:(NSIndexPath*)index{
    
//    [self.avatar_imageView sd_setImageWithURL:[NSURL URLWithString:model.avatarImage] placeholderImage:[UIImage imageNamed:@"news_defualt.png"]];
    [self.avatar_button sd_setImageWithURL:[NSURL URLWithString:model.avatarImage]  forState:UIControlStateNormal];
    self.name_lable.text = model.nickName;
    self.time_address_lable.text =  model.time;

    if ([model.sex isEqualToString:@"0"]) {
        _sex_lable.text = @" ♀女 ";
        _sex_lable.backgroundColor = [UIColor colorWithRed:0.984 green:0.635 blue:0.722 alpha:1.000];
    }else{
        _sex_lable.text = @" ♂男 ";
        _sex_lable.backgroundColor = [UIColor colorWithRed:0.275 green:0.761 blue:0.925 alpha:1.000];
    }

    _message_lable.text = model.content;

    self.avatar_button.tag = index.section;
/*
    if (model.content) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.content];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

        [paragraphStyle setLineSpacing:4];//调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.content length])];
        _message_lable.attributedText = attributedString;
        [_message_lable sizeToFit];
    }
 */
}
 
-(void)avatarButtonclick:(UIButton *)sender{

    _avatarAcction(sender.tag);
//    scds 
}



@end
