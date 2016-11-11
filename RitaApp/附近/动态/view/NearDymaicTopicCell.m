//
//  NearDymaicTopicCell.m
//  RitaApp
//
//  Created by BBC on 16/7/15.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "NearDymaicTopicCell.h"

@interface NearDymaicTopicCell ()
//@property(nonatomic,strong) UIImageView * avatarImageview;
@property(nonatomic,strong) UIButton * avatar_button;
@property(nonatomic,strong) UILabel * nickLabel;
@property(nonatomic,strong) UILabel * timeLabel;
@property(nonatomic,strong) UILabel * age_lable;
@property(nonatomic,strong) UILabel * level_lable;
@property(nonatomic,strong) UIImageView * sexImageView;
@property(nonatomic,strong) UILabel * content_lable;
@end


@implementation NearDymaicTopicCell



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createTopContent];
    }
    return self;
}

-(void)createTopContent
{
    //头像
    _avatar_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_avatar_button];
    [_avatar_button addTarget:self action:@selector(avaterAvtion:) forControlEvents:UIControlEventTouchUpInside];
//    _avatar_button.layer.masksToBounds  = YES ;
//    _avatar_button.layer.cornerRadius = 4;

    [_avatar_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@40);
        make.left.and.top.equalTo(self.contentView).offset(15);
    }];
  
 
    //昵称
    _nickLabel = [UILabel new];
    _nickLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nickLabel];

    [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar_button.mas_right).offset(10);
        make.top.equalTo(_avatar_button);
        make.height.equalTo(@20);
    }];


    //时间
    _timeLabel           = [UILabel new];
    _timeLabel.font      = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];

    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_avatarImageview.mas_right).offset(10);
        make.top.equalTo(_nickLabel.mas_top).offset(5);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@15);
    }];
 


    //性别年龄
    _age_lable           = [UILabel new];
    _age_lable.font      = [UIFont systemFontOfSize:8];
    _age_lable.textColor = [UIColor whiteColor];
//    _age_lable.layer.masksToBounds = YES;
//    _age_lable.layer.cornerRadius = 5;
    [self.contentView addSubview:_age_lable];

    [_age_lable mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_avatar_button.mas_right).offset(10);
        make.top.equalTo(_nickLabel.mas_bottom).offset(5);
        make.height.equalTo(@12);
    }];

/* 
    //等级
    _level_lable           = [UILabel new];
    _level_lable.font      = [UIFont systemFontOfSize:10];
    _level_lable.backgroundColor = [UIColor colorWithRed:0.918 green:0.808 blue:0.757 alpha:1.000];
    _level_lable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_level_lable];

    [_level_lable mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(_age_lable.mas_right).offset(5);
        make.top.equalTo(_nickLabel.mas_bottom).offset(5);
        make.height.equalTo(@15);
    }];
*/ 
     
    //内容
    _content_lable           = [UILabel new];
    _content_lable.font      = [UIFont systemFontOfSize:14];
    _content_lable.textColor = [UIColor colorWithRed:78/255.0 green:78/255.0 blue:78/255.0 alpha:1.0];
    _content_lable.numberOfLines = 0;
    [self.contentView addSubview:_content_lable];

    [_content_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatar_button.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(_avatar_button.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];

}
 

-(void)avaterAvtion:(UIButton *)sender{

    _avatarImageViewAction(sender.tag);
    
}
    


#pragma mark - Public methods

-(void)updateTopciWithModel:(NearDynamicModel *)model withIndex:(NSIndexPath*)indexPath
{


    [_avatar_button sd_setImageWithURL:[NSURL URLWithString:model.avatarImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"news_defualt.png"]];

    _avatar_button.tag = indexPath.section;


    _timeLabel.text = model.time;
    _nickLabel.text =model.nickName;

    if ([model.sex isEqualToString:@"0"]) {

        _age_lable.text = @" ♀ 女 ";
        _age_lable.backgroundColor = [UIColor colorWithRed:0.984 green:0.635 blue:0.722 alpha:1.000];
    }else{
 
        _age_lable.text = @" ♂ 男 ";
        _age_lable.backgroundColor = [UIColor colorWithRed:0.275 green:0.761 blue:0.925 alpha:1.000]; 
    }

    //    _level_lable.text = [NSString stringWithFormat:@" LV.%@ ",model.level];

    _content_lable.text = model.content;

//    if (model.content) {
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.content];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//
//        [paragraphStyle setLineSpacing:4];//调整行间距
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.content length])];
//        _content_lable.attributedText = attributedString;
//        [_content_lable sizeToFit];
//    }





}

@end
 
