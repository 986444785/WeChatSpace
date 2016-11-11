//
//  ZYMessageVC.m
//  RitaApp
//
//  Created by BBC on 16/7/8.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ZYMessageVC.h"
#import "MessageMainCell.h"


#define MessageCell_height 85

@interface ZYMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSArray * conversations;

@end
  

@implementation ZYMessageVC
- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor =[UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;

//    [self getMessageList];

    [self settableview];
    
} 
  
-(void)settableview{
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREEN_HIGHT-64) style:UITableViewStylePlain];
    tableview.delegate =self;
    tableview.dataSource = self ;
    tableview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableview];
    [tableview registerClass:[MessageMainCell class] forCellReuseIdentifier:@"MessageMainCell"]
    ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    return self.conversations.count;
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MessageCell_height;
}

 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageMainCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageMainCell" forIndexPath:indexPath];
    [cell updateMessageCellWithIndex:indexPath];
    return cell;
}

  

#pragma mark   【获取会话列表】
-(void)getMessageList
{

//    EMConversation *conversation = [[EMClient sharedClient].chatManager getConversation:@"8001" type:EMConversationTypeChat createIfNotExist:YES];

    NSLog(@"【获取会话列表】");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
