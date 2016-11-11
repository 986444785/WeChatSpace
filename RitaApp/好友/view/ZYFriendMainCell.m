//
//  ZYFriendMainCell.m
//  RitaApp
//
//  Created by BBC on 16/7/11.
//  Copyright © 2016年 Chen. All rights reserved.
//
 
#import "ZYFriendMainCell.h"
#import "UIImageView+WebCache.h"

@interface ZYFriendMainCell ()

@property(nonatomic,strong) UIImageView * avatar_imageView;
@property(nonatomic,strong) UILabel * name_lable;
@property(nonatomic,strong) UILabel * time_address_lable;
@property(nonatomic,strong) UILabel * sex_lable;
@property(nonatomic,strong) UILabel * level_lable;
@property(nonatomic,strong) UILabel *signature_lable;

@end

@implementation ZYFriendMainCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setFriendCell];
    }
    return self; 
}
    
-(void)setFriendCell
{
    //头像
    self.avatar_imageView = [UIImageView new];
    self.avatar_imageView.image = [UIImage imageNamed:@"example.jpg"];
    [self.contentView addSubview:self.avatar_imageView];

    [self.avatar_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-15);
        make.width.equalTo(self.avatar_imageView.mas_height);

    }];

    //时间——地点
    self.time_address_lable = [UILabel new];
    self.time_address_lable.font = [UIFont systemFontOfSize:12];
    self.time_address_lable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.time_address_lable];
    self.time_address_lable.text = @"0.11km 20秒前";

    [self.time_address_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.avatar_imageView.mas_top);
        make.height.equalTo(@25);
    }];
 
    //名字
    self.name_lable = [UILabel new];
    self.name_lable.font = [UIFont systemFontOfSize:16];
    self.name_lable.text = @"二次元的钢铁侠战士";
    [self.contentView addSubview:self.name_lable];

    [self.name_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar_imageView.mas_right).offset(10);
        make.right.equalTo(self.time_address_lable.mas_left).offset(-10);
        make.top.equalTo(self.avatar_imageView.mas_top);
        make.height.equalTo(@25);

    }];
 
    //性别
    self.sex_lable = [UILabel new];
    self.sex_lable.font = [UIFont systemFontOfSize:10];
    self.sex_lable.textColor = [UIColor whiteColor];
    self.sex_lable.backgroundColor = [UIColor colorWithRed:0.984 green:0.631 blue:0.722 alpha:1.000];
    self.sex_lable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.sex_lable];
    self.sex_lable.text = @" ♀19 ";

    [self.sex_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name_lable.mas_left);
        make.top.equalTo(self.name_lable.mas_bottom).offset(5);
        make.height.equalTo(@12);
    }];

    //等级
    self.level_lable = [UILabel new];
    self.level_lable.font = [UIFont systemFontOfSize:10];
    self.level_lable.textColor = [UIColor whiteColor];
    self.level_lable.backgroundColor = [UIColor colorWithRed:0.878 green:0.773 blue:0.718 alpha:1.000];
    self.level_lable.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.level_lable];
    self.level_lable.text = @" Lv.9 ";

    [self.level_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sex_lable.mas_right).offset(5);
        make.top.equalTo(self.sex_lable.mas_top);
        make.height.equalTo(self.sex_lable.mas_height);
    }];
  
    //签名
    self.signature_lable = [UILabel new];
    self.signature_lable.text = @"人间四月芳菲尽，山寺桃花始盛开！";
    self.signature_lable.font = [UIFont systemFontOfSize:12];
    self.signature_lable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.signature_lable];

    [self.signature_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name_lable.mas_left);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.avatar_imageView.mas_bottom);
        make.height.equalTo(@20);
        
    }];


}
 

-(void)updateZYFriendMainCell:(NSDictionary *)dic{

    self.name_lable.text = dic[@"nickname"];

    self.signature_lable.text = dic[@"signature"];

    [self.avatar_imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar"]]];
}

-(void)updateDateWithNmae:(NSString *)name
{
    self.name_lable.text = name;
}


  


@end
