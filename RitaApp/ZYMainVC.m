//
//  ZYMainVC.m
//  RitaApp
//
//  Created by BBC on 16/7/8.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ZYMainVC.h"
#import "AppDelegate.h"
#import "LLTabBar.h"
#import "LLTabBarItem.h"

#import "ZYLoginViewController.h"     //登录界面
#import "SocialHomePageVC.h"
#import "ZYNearHomaPageVC.h"

#import "CJNavigationController.h"
//#import "ConversationListController.h"  //聊天列表
//#import "ContactListViewController.h"   //好友列表
#import "NearDymanicVC.h"               //动态

#import "ZYProfileViewController.h"    //个人中心
@interface UIViewController ()
{
//    ConversationListController *_chatListVC;
//    ContactListViewController *_contactsVC;
}
@end
 
@implementation ZYMainVC

+(void)goMainViewControllerWithDelegate:(id)delegate
{
    ZYLoginViewController * loginVC      = [[ZYLoginViewController alloc]init];
    NearDymanicVC * nearVC               = [[NearDymanicVC alloc]init];
    SocialHomePageVC   * socialVC        = [[SocialHomePageVC alloc]init];
    ZYProfileViewController * profilevc3 = [[ZYProfileViewController alloc]init];

    CJNavigationController * nav1        = [[CJNavigationController alloc]initWithRootViewController:loginVC];
    CJNavigationController * nav2        = [[CJNavigationController alloc]initWithRootViewController:nearVC];
    CJNavigationController * nav3        = [[CJNavigationController alloc]initWithRootViewController:socialVC];
    CJNavigationController * nav4        = [[CJNavigationController alloc]initWithRootViewController:profilevc3];


    UITabBarController * tabbarcon = [[UITabBarController alloc]init];
    tabbarcon.viewControllers = @[nav1,nav2,nav3,nav4];


    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];


    LLTabBar * tabbar = [[LLTabBar alloc]initWithFrame:tabbarcon.tabBar.bounds];

    CGFloat normalButtonWidth = (KSCREEN_WIDTH*3/4)/4;
    CGFloat tabBarHeight = CGRectGetHeight(tabbar.frame);
    CGFloat publishItemWidth = (KSCREEN_WIDTH / 4);


    LLTabBarItem *homeItem = [self tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"首页"
                                       normalImageName:@"home_tabbar_topic"
                                     selectedImageName:@"home_tabbar_topic_selected" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *sameCityItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight)
                                                     title:@"同城"
                                           normalImageName:@"home_tabbar_discover"
                                         selectedImageName:@"home_tabbar_discover_selected" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *publishItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
                                                    title:nil
                                          normalImageName:@"home_tabbar_camera"
                                        selectedImageName:@"home_tabbar_camera" tabBarItemType:LLTabBarItemRise];
    LLTabBarItem *messageItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                    title:@"消息"
                                          normalImageName:@"home_tabbar_chat"
                                        selectedImageName:@"home_tabbar_chat_selected" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *mineItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 3 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"我的"
                                       normalImageName:@"home_tabbar_me"
                                     selectedImageName:@"home_tabbar_me_selected" tabBarItemType:LLTabBarItemNormal];

    tabbar.tabBarItems = @[homeItem, sameCityItem, publishItem, messageItem, mineItem];
    tabbar.delegate = delegate;

    [tabbarcon.tabBar addSubview:tabbar];

    tabbarcon.selectedIndex = 1;

    AppDelegate * app                     = delegate;
    app.window.rootViewController = tabbarcon;
}
  


+ (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
    LLTabBarItem *item = [[LLTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:8];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setImage:selectedImage forState:UIControlStateHighlighted];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;

    [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithRed:0.973 green:0.227 blue:0.392 alpha:1.000] forState:UIControlStateSelected];
    return item;
}


#pragma mark --- 获取消息数
+(void)MessageCount
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUntreatedApplyCount) name:@"setupUntreatedApplyCount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];

    [self setupUnreadMessageCount];


} 



// 统计未读消息数
+(void)setupUnreadMessageCount
{
//    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
//    NSInteger unreadCount = 0;
//    for (EMConversation *conversation in conversations) {
//        unreadCount += conversation.unreadMessagesCount;
//    }
//    if (_chatListVC) {
//        if (unreadCount > 0) {
//            _chatListVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
//        }else{
//            _chatListVC.tabBarItem.badgeValue = nil;
//        }
//    }
   
//    UIApplication *application = [UIApplication sharedApplication];
//    [application setApplicationIconBadgeNumber:unreadCount];
}


 


+(void)initialize
{

    [[UINavigationBar appearance]setTintColor:[UIColor grayColor]];
    //设置整体导航栏颜色
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];


    //设置导航颜色
    [[UINavigationBar appearance]setBarTintColor:SUBJECT_COLOR];

    //返回按钮
    UIImage * backButtonImage2 = [[UIImage imageNamed:@""] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 30, 0, 0)];

    [[UIBarButtonItem appearance]setBackgroundImage:backButtonImage2 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];


}



@end
