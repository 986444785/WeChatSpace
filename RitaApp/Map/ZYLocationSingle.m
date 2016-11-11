//
//  ZYLocationSingle.m
//  RitaApp
//
//  Created by BBC on 16/7/22.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ZYLocationSingle.h" 

#define DefaultLocationTimeout  6
#define DefaultReGeocodeTimeout 3

static ZYLocationSingle * __singleLocation;

@interface ZYLocationSingle () <AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
    
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;



@end

@implementation ZYLocationSingle

/**
 *  构建单例
 *
 *  @return
 */
 
+(ZYLocationSingle*)defaultSingleLocation{

        //为了防止多个线程同时判断单例是否存在，从而导致同时创建单例。判断的时候必须加线程同步。
    @synchronized(self) {
        if (!__singleLocation) {
            __singleLocation = [[ZYLocationSingle alloc]init];

        }
    }
    return __singleLocation;
}

 //为了防止人为创建单例类，重写alloc方法
+(id)alloc{
    //dispatch_once 的block中的代码当程序运行后只会被执行一次。

    //单例类的创建最好用dispatch_once。
    //使用dispatch_once就不需要再进行判断，也不需要关心线程同步。
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singleLocation = [super alloc];
    });
    //    NSLog(@"dispatch_once 的block中的代码当程序运行后只会被执行一次。");


    return __singleLocation ;
}
 
 
- (void)getLocationInfo{


    if( !__singleLocation.isInit){
        //创建
        __singleLocation.isInit = YES;

        NSLog(@"单例类的方法执行了");

        [self initCompleteBlock];
    
        [self configLocationManager];

    }

    [self reGeocodeAction];

}



#pragma mark - Action Handle

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];

    [self.locationManager setDelegate:self];

    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];

    [self.locationManager setPausesLocationUpdatesAutomatically:NO];

    [self.locationManager setAllowsBackgroundLocationUpdates:YES];

    [self.locationManager setLocationTimeout:DefaultLocationTimeout];

    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}

- (void)cleanUpAction
{
    [self.locationManager stopUpdatingLocation];

    [self.locationManager setDelegate:nil];
}

- (void)reGeocodeAction
{
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

   
#pragma mark - Initialization

- (void)initCompleteBlock
{
    __weak ZYLocationSingle * weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);

            if (error.code == AMapLocationErrorLocateFailed)
            {
                weakSelf.isInit = NO;
//                 ALERT_MSG(@"请打开定位");
                return;
            }
        }

        if (location)
        {

            weakSelf.log = [NSString stringWithFormat:@"%f",location.coordinate.longitude];

            weakSelf.lat =  [NSString stringWithFormat:@"%f",location.coordinate.latitude];

            weakSelf.city = regeocode.city;

            weakSelf.district = regeocode.district;

            weakSelf.nearInfo = [NSString stringWithFormat:@"%@%@",regeocode.street,regeocode.number];

 
//            NSLog(@"地址 :%@   门牌号:%@",regeocode.street,regeocode.number);
//
//            NSLog(@"经度%f    纬度%f  \n 城市:%@  \n  区:%@  街道:%@ \n 兴趣点名称: %@ \n 详情:%@",location.coordinate.latitude,location.coordinate.longitude,regeocode.city,regeocode.district,regeocode.neighborhood,regeocode.POIName,regeocode.formattedAddress);
        }
    };
}

@end
