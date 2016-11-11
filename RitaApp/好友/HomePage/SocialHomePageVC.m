//
//  SocialHomePageVC.m
//  RitaApp
//
//  Created by BBC on 16/7/29.
//  Copyright © 2016年 Chen. All rights reserved.
//
 
#import "SocialHomePageVC.h"
#import "HGTitleView.h"
#import "ZYFriendVC.h"
#import "ZYMessageVC.h"
@interface SocialHomePageVC ()<UIScrollViewDelegate,HGTitleViewDelegate>
@property(nonatomic,weak) HGTitleView * titleView;
@property (nonatomic ,strong) UIScrollView * scrollview;
@property(nonatomic,strong) NSArray * titles;
@end

@implementation SocialHomePageVC

- (void)viewDidLoad { 
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    //2.添加titleView
    [self setTitleView];

    //添加姿势图
    [self addChilderView];

    //设置默认状态控制器
    UIViewController *mvc = [self.childViewControllers firstObject];
    mvc.view.frame = self.scrollview.bounds;
    [self.scrollview addSubview:mvc.view];

}
  

-(void)setTitleView
{
    self.titles  = @[@"消息",@"好友"];

    HGTitleView * tv =  [[HGTitleView alloc]init];
    tv.delegate = self;
    [tv setupButtonWithTitles:self.titles];
    tv.frame = CGRectMake(0, 0, 180 , 44);
    self.navigationItem.titleView = tv ;
    self.titleView = tv;

    [self.titleView wanerSelected:0];//选中第一个
}

#pragma mark 添加titleView的代理方法
-(void)titleView:(HGTitleView *)titleView scrollToIndex:(NSInteger)tagIndex
{
    [self.scrollview scrollRectToVisible:CGRectMake(tagIndex * KSCREEN_WIDTH, 0, KSCREEN_WIDTH, KSCREEN_HIGHT) animated:YES];
}

/**
 *  子视图
 */
-(void)addChilderView{

    ZYMessageVC * message = [[ZYMessageVC alloc]init];
    [self addChildViewController:message];

    ZYFriendVC * firend = [[ZYFriendVC alloc]init];
    [self addChildViewController:firend];

    UIScrollView * scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HIGHT)];
    scrollview.delegate = self;
    [self.view addSubview:scrollview];

    //设置滚动属性
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.bounces = NO;
    //    scrollview.userInteractionEnabled = NO;
    scrollview.scrollEnabled = YES;
    scrollview.contentSize = CGSizeMake(self.titles.count*KSCREEN_WIDTH,KSCREEN_HIGHT);
    self.scrollview = scrollview;

}

#pragma mark - UIScrollView Delegat Methods
//滚动结束后调用（setContentOffset代码导致）
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    [self addOtherChileViewWith:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addOtherChileViewWith:scrollView]; 
}


-(void)addOtherChileViewWith:(UIScrollView *)scrollView{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.scrollview.frame.size.width;

    [self.titleView wanerSelected:index];

    // 添加控制器
    UIViewController * NAV = self.childViewControllers[index];

    //如果nvc已经存在了，不作处理
    if (NAV.view.superview) return;
    NAV.view.frame = scrollView.bounds;
    [self.scrollview addSubview:NAV.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
