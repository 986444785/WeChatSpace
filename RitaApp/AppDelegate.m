//
//  AppDelegate.m
//  RitaApp
//
//  Created by BBC on 16/7/8.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYMainVC.h"
#import "LLTabBar.h"
#import "MakeFriendsViewController.h"


@interface AppDelegate ()<LLTabBarDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//  [[RRFPSBar sharedInstance] setHidden:NO];

    [ZYMainVC goMainViewControllerWithDelegate:self];
   


    ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];
    [single getLocationInfo];

//    MakeFriendsViewController * makeFriendVC = [[MakeFriendsViewController alloc]init];
//    self.window.rootViewController = makeFriendVC;


#ifdef REDPACKET_AVALABLE
    /**
     *  TODO: 通过环信的AppKey注册红包
     */
//    [[RedPacketUserConfig sharedConfig] configWithAppKey:EaseMobAppKey];
#endif
/*
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"easemob-demo#chatdemoui"];


    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"chatdemoui_dev";
#else
    apnsCertName = @"chatdemoui";
#endif 

    options.apnsCertName = apnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];

    // 应该先判断是否设置了自动登录，如果设置了，则不需要您再调用。

    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
         [self loginWithUsername:User1 withPassword:Password1];
    }else{
        NSLog(@"登录成功   去其他页面");

        [ZYMainVC goMainViewControllerWithDelegate:self];
 
    }

    */

//    [self UMSetting];

    return YES;
} 

#pragma mark 【友盟注册】 
-(void)UMSetting{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

//        [UMSocialQQHandler setQQWithAppId:@"wx3191770c8fb1eea6" appKey:@"bb98233df7325b64eee708272a68d45b" url:@"http://www.baidu.com"];


    });

}

#pragma mark - LLTabBarDelegate

- (void)tabBarDidSelectedRiseButton {

    NSLog(@"wo在这 a   ");
    
    MakeFriendsViewController * makeFriendVC = [[MakeFriendsViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:makeFriendVC];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];

}

#pragma mark  【登录】

-(void)loginWithUsername:(NSString *)userName withPassword:(NSString *)password
{
//    EMError *error = [[EMClient sharedClient] loginWithUsername:userName password:password];
//    if (!error) {
//
//        [[EMClient sharedClient].options setIsAutoLogin:YES];
//
//        NSLog(@"登录成功");
//    }else{
//
//        NSLog(@"登录bu成功");
//    }
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {

//    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {

//    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"执行1");
//    if (_mainController) {
//        [_mainController jumpToChatList];
//    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
        NSLog(@"执行2");
//    if (_mainController) {
//        [_mainController didReceiveLocalNotification:notification];
//    }
}


//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL result = [UMSocialSnsService handleOpenURL:url];
//    if (result == FALSE) {
//        //调用其他SDK，例如支付宝SDK等
//    }
//    return result;
//}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
