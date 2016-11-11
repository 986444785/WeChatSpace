//
//  OnLineFriendCell.m
//  RitaApp
//
//  Created by BBC on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "OnLineFriendCell.h"

@interface OnLineFriendCell ()
@property(nonatomic,strong) UIButton * avatar_button;
@property(nonatomic,strong) UILabel * name_lable;
@property(nonatomic,strong) UILabel * time_address_lable;
@property(nonatomic,strong) UILabel * sex_lable;
@property(nonatomic,strong) UIButton * make_button;
//@property(nonatomic,strong) UILabel *signature_lable;
@end

@implementation OnLineFriendCell



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
    self.avatar_button = [UIButton new];
    self.avatar_button.layer.masksToBounds = YES;
    self.avatar_button.layer.cornerRadius = 5;
    [self.contentView addSubview:self.avatar_button];

    [self.avatar_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(10);
        make.height.equalTo(@50);
        make.width.equalTo(@50);

    }];


    //名字
    self.name_lable = [UILabel new];
    self.name_lable.font = [UIFont systemFontOfSize:16];
    self.name_lable.text = @"二次元的钢铁侠战士";
    [self.contentView addSubview:self.name_lable];

    [self.name_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatar_button.mas_right).offset(10);
        make.top.equalTo(self.avatar_button.mas_top);
        make.height.equalTo(@25);
        make.right.lessThanOrEqualTo(self.contentView.mas_right).offset(-80);
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
        make.top.equalTo(self.name_lable.mas_bottom);
        make.height.equalTo(@12);
    }];

    //时间——地点
    self.time_address_lable = [UILabel new];
    self.time_address_lable.font = [UIFont systemFontOfSize:12];
    self.time_address_lable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.time_address_lable];
    self.time_address_lable.text = @"0.11km 20秒前";

    [self.time_address_lable mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.sex_lable.mas_bottom);
        make.left.equalTo(_sex_lable.mas_left);
        make.height.equalTo(@20);
    }];



    self.make_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.make_button addTarget:self action:@selector(onLineFriendCellAcction:) forControlEvents:UIControlEventTouchUpInside];
    self.make_button.layer.masksToBounds = YES;
    self.make_button.layer.cornerRadius = 5;
    self.make_button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.make_button];

    [self.make_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.width.equalTo(@50);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];

    self.make_button.backgroundColor = [UIColor colorWithRed:0.973 green:0.267 blue:0.298 alpha:1.000];


}   
 

-(void)updateZYFriendMainCell:(MakeFriendModel *)model withIndex:(NSInteger)index{

    self.name_lable.text = model.user_dic[@"nickname"];

    self.avatar_button.tag = 10000+index;

    self.make_button.tag = 20000+index;

    [self.avatar_button sd_setImageWithURL:[NSURL URLWithString:model.user_dic[@"avatar"]] forState:UIControlStateNormal];

    if (model.isMake == YES) {
        [self.make_button setTitle:@"已交配" forState:UIControlStateNormal];
    }else{
        [self.make_button setTitle:@"交配" forState:UIControlStateNormal];
    }
} 
 
-(void)onLineFriendCellAcction:(UIButton *)sender{

     NSLog(@"哈哈  %ld",(long)sender.tag);
    _OnLineFriendCellAcction(sender.tag);
}

@end
