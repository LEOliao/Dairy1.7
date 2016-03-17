//
//  DYDaily.m
//  Dairy
//
//  Created by tarena06 on 16/2/24.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYDaily.h"
#import "DYDataManager.h"
@implementation DYDaily
+(DYDaily *)parseDailyJson:(NSDictionary *)dic
{
    return [[self alloc] parseDailylJson:dic];
}
- (DYDaily *)parseDailylJson:(NSDictionary *)dic {
    self.date = dic[@"date"];
    self.maxtempC = dic[@"maxtempC"];
    self.mintempC = dic[@"mintempC"];
    
    //    self.iconUrl = dic[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
#warning 此处使用本地图片
    NSString *url = dic[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
    self.iconUrl = [DYDataManager imageMap][url];
    
    return self;
}

@end
