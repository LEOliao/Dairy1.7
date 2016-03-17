//
//  DYGetDate.h
//  Dairy
//
//  Created by tarena06 on 16/1/27.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYDate.h"
#import "DYDairy.h"
#import "Singleton.h"
@interface DYGetDate : NSObject

@property (nonatomic ,strong)NSMutableArray *allMonthBtns;
@property(nonatomic,strong)NSMutableArray *allYearBtns;
+(DYDate*)getDate;
+(DYDairy*)getDairyFromDate:(DYDate*)date;
+(NSString*)getTargetDaySevenDays:(NSString*)nowSevenDays andDaysOfToday:(NSInteger)daysOfTodady andMonthOfToday:(NSInteger)monthOfToday andYearOfToday:(NSInteger)yearOfToday andDaysOfTargetDay:(NSString*)daysOfTargetDay andMonthOfTargetDay:(NSString*)monthOfTargetDay andYearOfTargetDay:(NSString*)yearOfTargetDay;
+(NSString*)getStringMonth:(NSInteger)month;
//实现知道过去某年某月有几天，是星期几
+(NSInteger)getTotalDaysOfOldMonths:(NSInteger)month andYear:(NSInteger)year;
+(NSInteger)getLeftDaysOfOldMonths:(NSInteger)month andYear:(NSInteger)year andDay:(NSInteger)day;
@end
