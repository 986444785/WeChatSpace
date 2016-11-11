//
//  ZYBusinseeVC.m
//  RitaApp
//
//  Created by BBC on 16/7/12.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ZYBusinseeVC.h"

@interface ZYBusinseeVC ()

@end

@implementation ZYBusinseeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    self.view.backgroundColor = [UIColor yellowColor];

 
    UILabel * lable  = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    lable.text = @"商家4";
    [self.view addSubview:lable];

       NSLog(@"开始摇摆     商家4");
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
