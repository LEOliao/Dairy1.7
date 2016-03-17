//
//  DYDaily.h
//  Dairy
//
//  Created by tarena06 on 16/2/24.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYDaily : NSObject
//日期
@property (nonatomic, strong) NSString *date;
//最高温度
@property (nonatomic, strong) NSString *maxtempC;
//最低温度
@property (nonatomic, strong) NSString *mintempC;
//图片url
@property (nonatomic, strong) NSString *iconUrl;
@property(nonatomic,strong)NSString *cityName;

//给定每天字典，返回TRDaily
+ (DYDaily *)parseDailyJson:(NSDictionary *)dic;

@end
