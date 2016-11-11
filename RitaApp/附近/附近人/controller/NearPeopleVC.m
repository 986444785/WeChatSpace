//
//  NearPeopleVC.m
//  RitaApp
//
//  Created by BBC on 16/7/11.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "NearPeopleVC.h"
#import "ZYFriendMainCell.h"
#define Friend_Cell_Height  100   //cell高度
@interface NearPeopleVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray * peopleList;

@end

@implementation NearPeopleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;


    [self settableview];
}

-(void)settableview{
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HIGHT-64-49) style:UITableViewStylePlain];
    tableview.delegate =self;
    tableview.dataSource = self ;
    tableview.backgroundColor = TB_BGColor;
    tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableview];
    [tableview registerClass:[ZYFriendMainCell class] forCellReuseIdentifier:@"ZYFriendMainCell"];
}
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    return self.friends.count;
        return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Friend_Cell_Height;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    ZYFriendMainCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"ZYFriendMainCell" forIndexPath:indexPath];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
