//
//  MakeFriendsView.m
//  RitaApp
//
//  Created by BBC on 16/7/20.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "MakeFriendsView.h"

@implementation MakeFriendsView

 
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = TB_BGColor;
        [self setMakeFriendsView];
    }
    return self;
} 
 
-(void)setMakeFriendsView{


    NSArray * titleArrays = @[@" 大房 ",@" 二房 ",@" 三房 ",@" 四房 "];

    float avatar_width = 80.00*KSCREEN_WIDTH/320;

    //中间的按钮
    for (int i = 0; i < titleArrays.count; i++) {

        UIButton *avatar_button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [avatar_button setTitle:@"空" forState:UIControlStateNormal];
        avatar_button.backgroundColor = [UIColor colorWithRed:0.329 green:0.322 blue:0.333 alpha:1.000];
        avatar_button.titleLabel.font = [UIFont systemFontOfSize:30];
        avatar_button.layer.masksToBounds = YES;
        avatar_button.layer.cornerRadius  = avatar_width/2;
        avatar_button.tag  = 10000+ i;

        [avatar_button addTarget:self action:@selector(makeFriendAcctionButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:avatar_button];

        [avatar_button mas_makeConstraints:^(MASConstraintMaker *make) {

            make.height.offset(avatar_width);

            make.width.offset(avatar_width);

            //计算距离顶部的公式 80 = 上一个距离顶部的高度 + UIlabel的高度
            float colTop = (KSCREEN_WIDTH/2 + avatar_width - 50*BiLv + i/2 * (avatar_width+20*BiLv));
 
            make.top.offset(colTop);

            if (i%2 == 0) {

                make.left.offset(KSCREEN_WIDTH/2-10*BiLv-avatar_width);
            }else{
                make.left.offset(KSCREEN_WIDTH/2+10*BiLv);
            }
        }];

        UILabel * title_Lable = [UILabel new];
        title_Lable.textColor = [UIColor whiteColor];
        title_Lable.backgroundColor = [UIColor colorWithRed:0.945 green:0.243 blue:0.427 alpha:1.000];
        title_Lable.font = [UIFont systemFontOfSize:10];
        [self addSubview:title_Lable];

        title_Lable.text = titleArrays[i];

        [title_Lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(avatar_button.mas_bottom).offset(-7);
            make.centerX.equalTo(avatar_button);
            make.height.equalTo(@14);
        }];

    }



    //底部的按钮
    NSArray * images = @[@"btn_randomMatch.png",@"btn_lineMatch.png",@"btn_nearMatch.png"];
    float btn_width = 55.000*KSCREEN_WIDTH/320;

    for (int i = 0; i < images.count; i++) {

        UIButton *action_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [action_button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [self addSubview:action_button];

        action_button.tag  = 20000+ i;

        [action_button addTarget:self action:@selector(makeFriendAcctionButton:) forControlEvents:UIControlEventTouchUpInside];
        [action_button mas_makeConstraints:^(MASConstraintMaker *make) {

            //设置高度
            make.height.offset(btn_width);
            make.width.offset(btn_width);
            make.bottom.equalTo(self.mas_bottom).offset(-50);
            //当是 左边一列的时候 都是 距离父视图 向左边 20的间隔

            if (i == 0) {
                       make.right.equalTo(self.mas_centerX).offset(-btn_width);
            }else if (i==1){

                make.centerX.equalTo(self);
            }else{

                make.left.equalTo(self.mas_centerX).offset(btn_width);
            }
        }];
    }
        
}

 
-(void)makeFriendAcctionButton:(UIButton *)sender{

    _makeFriendAcction(sender.tag);
}
 
#pragma mark 【更新数据】
-(void)updateMakeFriendsViewArray:(NSArray *)array{

    for (int i = 0; i< 4; i++) {
        UIButton * button = [self viewWithTag:10000+i];
        [button setTitle:@"空" forState:UIControlStateNormal];

        if (i<array.count) {
            [button setTitle:nil forState:UIControlStateNormal];

            NSDictionary * dic = array[i];
            NSDictionary * userDic = dic[@"user"];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:userDic[@"avatar"]] forState:UIControlStateNormal];

        }
    }


}



@end
