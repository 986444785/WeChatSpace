//
//  MakeFriendsViewController.m
//  RitaApp
//
//  Created by BBC on 16/7/20.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "MakeFriendsViewController.h"
#import "UIBarButtonItem+CH.h"
#import "MakeFriendsView.h"
#import "OnLineFriendViewController.h"
@interface MakeFriendsViewController ()
@property(nonatomic,strong)  MakeFriendsView * makeFriendsView;
@property(nonatomic,assign) BOOL isMatching;
@property(nonatomic,strong) NSMutableArray * friendArray;

@end

@implementation MakeFriendsViewController

- (void)viewDidLoad {    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];

    self.navigationItem.title = @"配对游戏";

    self.friendArray = [NSMutableArray array];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"离开" WithTitleColor:[UIColor grayColor] withFont:14 target:self action:@selector(goOut)];

    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    _makeFriendsView = [[MakeFriendsView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_makeFriendsView];

    __weak   MakeFriendsViewController * vc  = self ;

    _makeFriendsView.makeFriendAcction = ^(NSInteger index){

        [vc makeFriendsViewActionWithIndex:index];
    };

    [self hadMatchCount];

}

#pragma make  【MakeFriendsView界面事件】
-(void)makeFriendsViewActionWithIndex:(NSInteger)index{

    switch (index) {
        case 0:
                 [self dismissViewControllerAnimated:YES completion:nil];
            break;

        case 10000:
            NSLog(@"和  大房  聊天");
            break;
        case 10001:
             NSLog(@"和  二房  聊天");
            break;
        case 10002:
             NSLog(@"和  三房  聊天");
            break;
        case 10003:
             NSLog(@"和  四房  聊天");
            break;
        case 20000:
             NSLog(@"和  随机  匹配");
            [self randomMatching];
            break;
        case 20001:
             NSLog(@"和  在线  匹配");
            [self goOnLineMatching];
            break;
        case 20002:
             NSLog(@"和  条件  匹配");
            break;
        default:
            break;
    }
} 

-(void)goOut
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark 【已交配数量】
-(void)hadMatchCount{

    __unsafe_unretained typeof(self) vc  = self ;

    [HttpHelper hadMatchCountComplate:^(NSDictionary *resposeDic) {
        NSLog(@"");
        NSDictionary * dataDic = resposeDic[@"data"];
        NSArray * items = dataDic[@"items"];

        
        [vc.makeFriendsView updateMakeFriendsViewArray:items];
    }];

} 



#pragma mark 【在线交配列表】
-(void)goOnLineMatching{

    OnLineFriendViewController * vc  = [[OnLineFriendViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 【随机交配】
-(void)randomMatching{

    __unsafe_unretained typeof(self) vc = self ;
    if (!_isMatching) {
          vc.isMatching = !vc.isMatching;
        [HttpHelper getRandomMatchComplate:^(NSDictionary *resposeDic) {

            vc.isMatching = !vc.isMatching;
            NSLog(@"randomMatching  %@",resposeDic);

            [vc randomMatchingAcction:resposeDic];

        }];
    }


}
     
-(void)randomMatchingAcction:(NSDictionary *)dic{

    [LSFMessageHint showToolMessage:dic[@"message"] hideAfter:1.5 yOffset:0];

    if (dic[@"success"]) {

    }
}




-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication]setStatusBarHidden:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
