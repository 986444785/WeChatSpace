//
//  ZYProfileViewController.m
//  RitaApp
//
//  Created by BBC on 16/7/21.
//  Copyright © 2016年 Chen. All rights reserved.
//
 
#import "ZYProfileViewController.h"

#import "PersonalheaderView.h"

@interface ZYProfileViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ZYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TB_BGColor;

    [self setZYProfileViewController];
}

-(void)setZYProfileViewController{

    UITableView * tabeview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tabeview.backgroundColor = [UIColor whiteColor];
    tabeview.delegate = self;
    tabeview.dataSource = self;
    [self.view addSubview:tabeview];


    PersonalheaderView * view = [[PersonalheaderView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 180)];
    tabeview.tableHeaderView = view;

    [view updatePersonalheaderViewWithDict:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array = @[@"好友",@"关注",@"粉丝"];
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@         (%ld)",array[indexPath.row],(long)indexPath.row];
    return cell;
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
