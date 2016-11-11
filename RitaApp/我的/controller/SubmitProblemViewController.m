//
//  SubmitProblemViewController.m
//  RitaApp
//
//  Created by BBC on 16/7/21.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "SubmitProblemViewController.h"

@interface SubmitProblemViewController ()

@end

@implementation SubmitProblemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.title = @"反馈";

    [self setTextView];
}

-(void)setTextView{

    UITextView * textView = [UITextView new];
    [self.view addSubview:textView];

    textView.backgroundColor = TB_BGColor;

//    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.top.equalTo
//    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
