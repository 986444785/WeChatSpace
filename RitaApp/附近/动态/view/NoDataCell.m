//
//  NoDataCell.m
//  RitaApp
//
//  Created by BBC on 16/7/20.
//  Copyright © 2016年 Chen. All rights reserved.
//
 
#import "NoDataCell.h"


@implementation NoDataCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        [self setNoDataCell];
    }
    return self;
}


-(void)setNoDataCell{
    UILabel * lable = [UILabel new];
    [self.contentView addSubview:lable];
    lable.text = @"还没有任何动态！";
    lable.textColor = [UIColor grayColor];

    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}


@end
