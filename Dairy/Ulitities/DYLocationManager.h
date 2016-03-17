//
//  DYLocationManager.h
//  Dairy
//
//  Created by tarena06 on 16/2/24.
//  Copyright © 2016年 tarena06. All rights reserved.
//
/*本类实现定位功能*/
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
typedef void (^saveLocationBlock)(double lat,double lon);
@interface DYLocationManager : NSObject
+(void)getUserLocation:(void(^)(double lat,double lon))locationBlock;
@end
