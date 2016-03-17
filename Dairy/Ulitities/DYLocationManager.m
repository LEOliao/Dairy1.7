//
//  DYLocationManager.m
//  Dairy
//
//  Created by tarena06 on 16/2/24.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYLocationManager.h"
#import <UIKit/UIKit.h>
/*本类实现定位功能*/
@interface DYLocationManager()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *manager;
@property(nonatomic,copy)void (^saveLocation)(double lat,double lon);
@end
@implementation DYLocationManager
+(id)sharedLocationManager
{
    static DYLocationManager *locationManager=nil;
    if(!locationManager)
    {
        locationManager = [[DYLocationManager alloc]init];
        
    }
    return locationManager;
}
//重写init方法初始化manager对象/ 征求用户同意
-(instancetype)init{
    if(self=[super init])
    {
        self.manager = [CLLocationManager new];
        //判断IOS版本
        if([[UIDevice currentDevice].systemVersion floatValue]>=8.0){
            //Info.plist添加key
            [self.manager requestWhenInUseAuthorization];
        }
        self.manager.delegate=self;
    }
    return self;

}
+(void)getUserLocation:(void (^)(double, double))locationBlock
{
    DYLocationManager *locationManager = [DYLocationManager sharedLocationManager];
    [locationManager getUserLocations:locationBlock];
}
-(void)getUserLocations:(void (^)(double, double))locationBlock{
    //用户不同意授权，不开启定位功能
    if(![CLLocationManager locationServicesEnabled]){
        return;
    }
    //将saveLocationBlock赋值给locationBlock
    _saveLocation = [locationBlock copy];
    //设定精度（调用频率）
    self.manager.distanceFilter = 500;
    //同意/开启定位
    [self.manager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    _saveLocation(location.coordinate.latitude,location.coordinate.longitude);
}
@end
