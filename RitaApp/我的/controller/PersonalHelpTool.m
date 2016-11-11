//
//  PersonalHelpTool.m
//  RitaApp
//
//  Created by BBC on 16/7/20.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "PersonalHelpTool.h"

@implementation PersonalHelpTool

-(instancetype)initWithFrame:(CGRect)frame{
    self=  [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor blackColor];
        [self setPersonalHelpTool];

    }
    return self;
}

-(void)setPersonalHelpTool{


    NSArray * titles = @[@"  对话",@"  送礼",@"  关注"];

    float btn_width  = KSCREEN_WIDTH/3;

    for (int i = 0; i < titles.count; i++) {

        UIButton *action_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:action_button];
        [action_button setImage:[UIImage imageNamed:@"icon-comment"] forState:UIControlStateNormal];
        action_button.titleLabel.font = [UIFont systemFontOfSize:14];

        action_button.tag = 10000+i;
        [action_button addTarget:self action:@selector(actionButtonClikck:) forControlEvents:UIControlEventTouchUpInside];
        [action_button setTitle:titles[i] forState:UIControlStateNormal];

        [action_button mas_makeConstraints:^(MASConstraintMaker *make) {

            //设置高度
            make.height.offset(40);
            make.width.offset(btn_width);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            //当是 左边一列的时候 都是 距离父视图 向左边 20的间隔

            if (i == 0) {
                make.left.equalTo(self.mas_left);
            }else if (i==1){

                make.centerX.equalTo(self);
            }else{

                make.right.equalTo(self.mas_right);
            }
        }];
    }
    
}
 
 
-(void)actionButtonClikck:(UIButton *)sender
{

    _personToolAction(sender.tag);
}


@end
