//
//  ZYLoginViewController.m
//  RitaApp
//
//  Created by BBC on 16/7/21.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ZYLoginViewController.h"
#import "MBProgressHUD.h"

@interface ZYLoginViewController ()
 
@end

@implementation ZYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    [self setZYLoginViewController];
}


-(void)setZYLoginViewController{


    UIImageView * logoImageview = [UIImageView new];
    logoImageview.image = [UIImage imageNamed:@"icon_share_weixin_selected.ong"];
    [self.view addSubview:logoImageview];

    [logoImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_centerY).offset(-80);
        make.height.width.equalTo(@80);
    }];


    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.masksToBounds  =YES;
    button.layer.cornerRadius = 8;
    [self.view addSubview:button];

    [button setTitle:@"微信授权登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_baseline).offset(-100);
        make.height.equalTo(@50);
        make.left.equalTo(self.view.mas_left).offset(44);
        make.right.equalTo(self.view.mas_right).offset(-50);
    }];
 
}   

-(void)loginButtonClick:(UIButton *)sender{
    NSLog(@"微信授权登录");


// token = 125Zc_zaiW9gDi9X7pthv7q7uUsZzOYTYxIF_vlzQbleoEJL3kudnchC_cYW6qOInvjQkEWr-_SXyK-JoUofOxQGQrDqvwFKbu6KYYXHwuQ

//openid = oFwInww4mICnq9GqkuJm6rHMm6rQ


    NSString * token = @"125Zc_zaiW9gDi9X7pthv7q7uUsZzOYTYxIF_vlzQbleoEJL3kudnchC_cYW6qOInvjQkEWr-_SXyK-JoUofOxQGQrDqvwFKbu6KYYXHwuQ";
    NSString * openid = @"oFwInww4mICnq9GqkuJm6rHMm6rQ";

    [HttpHelper loginWithaccess_token:token withOpenID:openid complate:^(BOOL success) {


        if (success) {

            NSLog(@"登录成功    去做其他事情");

        }else{

        }

    }];

    /*

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];

    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){

        if (response.responseCode == UMSResponseCodeSuccess) {
 

            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];

            NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);

            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeAnnularDeterminate;


           [HttpHelper loginWithaccess_token:snsAccount.accessToken withOpenID:snsAccount.openId complate:^(BOOL success) {

               hud.hidden = YES;

                if (success) {

                    NSLog(@"登录成功    去做其他事情");

                }else{
                    
                }

            }];




        }
         
    });
     */
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
