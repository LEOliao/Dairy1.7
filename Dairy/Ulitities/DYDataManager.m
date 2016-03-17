//
//  DYDataManager.m
//  Dairy
//
//  Created by tarena06 on 16/2/24.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYDataManager.h"

@implementation DYDataManager
static DYDataManager *_dataManager =nil;
+(DYDataManager*)sharedDataManager
{
    if(!_dataManager){
        _dataManager=[DYDataManager new];
    }
    return _dataManager;
}
+(DYDaily *)getDailyData:(id)responseObject
{
    NSArray *weatherArray = responseObject[@"data"][@"weather"];
    NSDictionary *dic = weatherArray[0];
    DYDaily *daily = [DYDaily parseDailyJson:dic];
    return daily;
}
//天气图标url前缀
static NSString * const iconURLString = @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_";
// 图片名 - iconCode的映射
+ (NSDictionary *)imageMap {
 //  	http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_0033_cloudy_with_light_rain_night.png
    return @{
             [NSString stringWithFormat:@"%@0001_sunny.png",iconURLString]:@"weather-clear.png",
             [NSString stringWithFormat:@"%@0033_cloudy_with_light_rain_night.png",iconURLString]:@"weather_cloudy_with_light_rain_night.png",
             [NSString stringWithFormat:@"%@0003_white_cloud.png",iconURLString]:@"weather-few.png",
             [NSString stringWithFormat:@"%@0004_black_low_cloud.png",iconURLString]:@"weather-scattered.png",
             [NSString stringWithFormat:@"%@0004_black_low_cloud.png",iconURLString]:@"weather-broken",
             [NSString stringWithFormat:@"%@0009_light_rain_showers.png",iconURLString]:@"weather-shower",
             [NSString stringWithFormat:@"%@0025_light_rain_showers_night.png",iconURLString]:@"weather-rain",
             @"11d":@"weather-tstorm",
             @"13d":@"weather-snow",
             [NSString stringWithFormat:@"%@0006_mist.png",iconURLString]
             :@"weather-mist",
             [NSString stringWithFormat:@"%@0008_clear_sky_night.png",iconURLString]:@"weather-moon",
             @"02n":@"weather-few-night",
             @"03n":@"weather-few-night",
             [NSString stringWithFormat:@"%@0002_sunny_intervals.png",iconURLString]:@"weather-broken",
             @"09n":@"weather-shoer",
             [NSString stringWithFormat:@"%@0025_light_rain_showers_night.png",iconURLString]:@"weather-rain-night",
             @"11n":@"weather-tstorm",
             @"13n":@"weather-snow",
             @"50n":@"weather-mist"
             };
}

@end
