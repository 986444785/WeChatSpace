//
//  OnLineFriendViewController.m
//  RitaApp
//
//  Created by BBC on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "OnLineFriendViewController.h"
#import "OnLineFriendCell.h"
#import "NearDynamicModel.h"
#import "MakeFriendModel.h"
@interface OnLineFriendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView * tableview  ;
@property(nonatomic,strong) NSMutableArray * dataList;
@property(nonatomic,assign) NSInteger listPage;
@end
 
@implementation OnLineFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TB_BGColor;

    self.title = @"在线匹配";

    _dataList = [NSMutableArray array];

    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableview];

    [_tableview registerClass:[OnLineFriendCell class] forCellReuseIdentifier:@"OnLineFriendCell"];

    __unsafe_unretained typeof(self) vc = self ;
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [vc requestFriendListWithUpdate:YES];
    }];
    [_tableview.mj_header beginRefreshing];

    _tableview.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [vc requestFriendListWithUpdate:NO];
    }];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OnLineFriendCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OnLineFriendCell" forIndexPath:indexPath];

    __block OnLineFriendViewController * vc = self;
    cell.OnLineFriendCellAcction = ^(NSInteger index){
        [vc matchCellActionWithIndex:index];
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    OnLineFriendCell * friendCell  = (OnLineFriendCell*)cell;
    MakeFriendModel * model = self.dataList[indexPath.row];
    [friendCell updateZYFriendMainCell:model withIndex:indexPath.row];

}
 
      
#pragma mark [列表数据]
-(void)requestFriendListWithUpdate:(BOOL)update{
    __unsafe_unretained typeof(self) vc = self;

    if(update){
        self.listPage = 1;
    }

    [HttpHelper getOnlineMatchtWithPage:[NSString stringWithFormat:@"%ld",(long)self.listPage] conplate:^(NSDictionary *responseDic) {

        NSLog(@"response   %@",responseDic);
        if (update) {
            [vc.tableview.mj_header endRefreshing];
            [vc.dataList removeAllObjects];
        }else{
            [vc.tableview.mj_footer endRefreshing];
        }

        [vc jiexiWithDic:responseDic];
    }];
}


-(void)jiexiWithDic:(NSDictionary *)dic{

    if ([dic[@"success"] intValue] ==1) {

        self.listPage ++ ;

        NSDictionary * datadic = dic[@"data"];

        NSArray * items = datadic[@"items"];
        for (int i = 0; i<items.count; i++) {
            [self.dataList addObject:[MakeFriendModel makeFriendModelWithDictionary:items[i]]];
        }
        [_tableview reloadData];

    }else{
        [LSFMessageHint showToolMessage:dic[@"messsage"] hideAfter:2.0 yOffset:0];
    }
}
 

-(void)matchCellActionWithIndex:(NSInteger)index{

    if (index>=20000) {
        [self mactToUserWithIndex:index-20000];
    }else{
        [self personalDetailpageWithIndex:index-10000];
    }
  
}

#pragma mark 【用户配对】
-(void)mactToUserWithIndex:(NSInteger)index{
    // 1、 判断已经有几个人在
    //    [HttpHelper hadMatchCountComplate:^(NSDictionary *resposeDic) {
    //        NSLog(@"");
    //    }];

    MakeFriendModel * model = self.dataList[index];

    [HttpHelper matchingToUserWithUser_id:model.user_dic[@"id"] complate:^(NSDictionary *responseDic) {

        [LSFMessageHint showToolMessage:responseDic[@"message"] hideAfter:2.0 yOffset:0];

        NSLog(@"【用户配对】   %@",responseDic);

        model.isMake = YES;
        //去改变这个按钮
        
    }];
}

#pragma mark 【去个人中心页面】
-(void)personalDetailpageWithIndex:(NSInteger)index{

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
