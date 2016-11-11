//
//  ZYProfileVC.m
//  RitaApp
//
//  Created by BBC on 16/7/8.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ZYProfileVC.h"
//#import "EMSDK.h"
#import "SDPhotoBrowser.h"
#import "PersonDetailViewController.h"

@interface ZYProfileVC ()<SDPhotoBrowserDelegate>
@property(nonatomic,strong) NSArray * dataSource;
@end

@implementation ZYProfileVC
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =[UIColor orangeColor];
     
    NSArray * array = @[@"添加好友13271617512",@"其他"];

    for (int i = 0; i<array.count; i++) {

        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];

        button.backgroundColor = [UIColor grayColor];

        button.tag = i+100;

        button.frame = CGRectMake(100, 100+60*i, 200, 40);

        [button setTitle:array[i] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:button];
    }

     __block ZYProfileVC * vc  = self;
    //注册好友回调
//    [[EMClient sharedClient].contactManager addDelegate:vc delegateQueue:nil];
//
//   
//    self.dataSource = @[@"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg"];
//
//
//    UIImageView * imageView  = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
//    [self.view addSubview:imageView];
//    imageView.userInteractionEnabled  =YES ;
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg"]];
//    imageView.backgroundColor = [UIColor redColor];
//

//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(testtapImageAction:)];
//
//    [imageView addGestureRecognizer:singleTap];

}


-(void)testtapImageAction:(UITapGestureRecognizer *)tap{
//    UIImageView *tapView = (UIImageView *)tap.view;

    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = 0;
    photoBrowser.imageCount = _dataSource.count;
    photoBrowser.sourceImagesContainerView = self.view;
    [photoBrowser show];

}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlString = self.dataSource[index];
    return [NSURL URLWithString:urlString];
}
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.view.subviews[index];
    return imageView.image;
}

/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage
{
    self.title = [NSString stringWithFormat:@"监听加好友请求    %@",aUsername];

//    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
//    if (!error) {
//        NSLog(@"发送同意成功");
//
//        NSLog(@"发送同意成功     %@     %@",aUsername,aMessage);
//
//    }else{
//        NSLog(@"发送同意 bu 成功");
//
//        NSLog(@"发送同意 bu 成功     %@     %@",aUsername,aMessage);
//    }
}




-(void)buttonClick:(UIButton *)sender
{
    NSLog(@"-------  send   %@",sender.titleLabel.text);

 
    if (sender.tag == 100) {

//        EMError *error = [[EMClient sharedClient].contactManager addContact:User2 message:@"我想加您为好友"];
//        if (!error) {
//            NSLog(@"添加成功   ");
//        }else{
//            NSLog(@"添加bu成功   %@",error.errorDescription);
//        }
    
        ZYLocationSingle * single = [ZYLocationSingle defaultSingleLocation];
//        [single getLocationInfo];

        NSLog(@"城市:%@    附近:%@  经度:%f   纬度:%f  ",single.city,single.nearInfo,single.log,single.lat);




    }else{
//        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:User2];
//        if (!error) {
//            NSLog(@"发送同意成功");
//        }else{
//            NSLog(@"发送同意 bu 成功");
//        }

        PersonDetailViewController * vc = [[PersonDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];

    }

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
