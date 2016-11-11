//
//  MessageMainCell.m
//  RitaApp
//
//  Created by BBC on 16/7/11.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "MessageMainCell.h"

@interface MessageMainCell ()
@property(nonatomic,strong) UIImageView * avatar_imageView;
@property(nonatomic,strong) UILabel * name_lable;
@property(nonatomic,strong) UILabel * time_address_lable;
@property(nonatomic,strong) UIImageView * read_ImageView;
@property(nonatomic,strong) UILabel * count_lable;
@property(nonatomic,strong) UILabel * message_lable;



@end


@implementation MessageMainCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setMessageCell];
    }
    return self;
}


-(void)setMessageCell{

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

    //阅读
    self.read_ImageView = [UIImageView new];

    self.read_ImageView.backgroundColor = [UIColor colorWithRed:0.984 green:0.631 blue:0.722 alpha:1.000];;
    [self.contentView addSubview:self.read_ImageView];

    [self.read_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name_lable.mas_left);
        make.top.equalTo(self.name_lable.mas_bottom).offset(5);
        make.height.equalTo(@15);
        make.width.equalTo(@15);
    }];
 

    //消息内容
    self.message_lable = [UILabel new];
    self.message_lable.text = @"人间四月芳菲尽，山寺桃花始盛开！";
    self.message_lable.font = [UIFont systemFontOfSize:12];
    self.message_lable.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.message_lable];

    [self.message_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.read_ImageView.mas_right).offset(5);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.read_ImageView.mas_top);
        make.height.equalTo(@15);
        
    }];
    

    //未读消息
    self.count_lable = [UILabel new];
    self.count_lable.font = [UIFont systemFontOfSize:10];
//    self.count_lable.text = @" 143 ";
    self.count_lable.textColor = [UIColor whiteColor];
    self.count_lable.backgroundColor = [UIColor redColor];
    self.count_lable.layer.masksToBounds  = YES;
    self.count_lable.layer.cornerRadius = 8;
    self.count_lable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.count_lable];



    //未读消息
    [self.count_lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.time_address_lable.mas_bottom).offset(5);
            make.height.equalTo(@16);

        }];
}
 

-(void)updateMessageCellWithIndex:(NSIndexPath*)index
{

    self.count_lable.text = [NSString stringWithFormat:@"%ld",(long)index.row];

//    计算消息宽度，最小宽度16
        if ([HttpHelper getTextLengthWith:self.count_lable.text WithFont:10 WithWidth:50]<16) {
            [self.count_lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-10);
                make.top.equalTo(self.time_address_lable.mas_bottom).offset(5);
                make.height.equalTo(@16);
                make.width.equalTo(@16);
            }];
    
        }else{
            [self.count_lable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-10);
                make.top.equalTo(self.time_address_lable.mas_bottom).offset(5);
                make.height.equalTo(@16);
                
            }];
        }
}








 








@end
