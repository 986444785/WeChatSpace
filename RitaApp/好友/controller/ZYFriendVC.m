//
//  ZYFriendVC.m
//  RitaApp
//
//  Created by BBC on 16/7/8.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ZYFriendVC.h"
#import "ZYFriendMainCell.h"
#define Friend_Cell_Height  100   //cell高度
@interface ZYFriendVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray * friends;

@end
  

@implementation ZYFriendVC
- (void)viewDidLoad {
    [super viewDidLoad];
 
   
    self.view.backgroundColor =[UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;

    [self getFriendList];

    [self settableview];
}

-(void)settableview{
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HIGHT-64) style:UITableViewStylePlain];
    tableview.delegate =self;
    tableview.dataSource = self ;
    tableview.backgroundColor = TB_BGColor;
    tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableview];
    [tableview registerClass:[ZYFriendMainCell class] forCellReuseIdentifier:@"ZYFriendMainCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    return self.friends.count;
    return 2;
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
  

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYFriendMainCell * friendCell  = (ZYFriendMainCell*)cell;
    [friendCell updateDateWithNmae:self.friends[indexPath.row]];

}


#pragma mark 【获取好友列表】
-(void)getFriendList
{ 
//    EMError *error = nil;
//
//    NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
//    if (!error) {
//
//        self.friends = userlist;
//        NSLog(@"获取成功 -- %@  userlist2  ",userlist);
//    }else{
//        NSLog(@"获取好友失败");
//    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
