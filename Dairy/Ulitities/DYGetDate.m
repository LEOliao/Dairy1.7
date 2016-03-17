//
//  DYGetDate.m
//  Dairy
//
//  Created by tarena06 on 16/1/27.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYGetDate.h"

@interface DYGetDate()
//@property(nonatomic,strong)NSString *plistPath;
@end
@implementation DYGetDate

+(DYDate*)getDate
{
  NSArray * arrWeek=[NSArray arrayWithObjects: @"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT", nil];
   
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar= [NSCalendar currentCalendar];
    NSInteger unitFlags=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
   NSDateComponents *dateComponent =[calendar components:unitFlags fromDate:now];
    NSInteger year =[dateComponent year];
    NSInteger month=[dateComponent month];
    NSInteger day=[dateComponent day];
   NSInteger week=[dateComponent weekday];
    NSInteger currentWeek=(week-1+7)%7;
    NSInteger hour=[dateComponent hour];
    NSInteger minute=[dateComponent minute];
    NSInteger second=[dateComponent second];
    DYDate *date=[DYDate new];
    date.years=year;
    date.month=month;
    date.days=day;
    date.sevenDays=[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:currentWeek]];
    date.hour=hour;
    date.minute=minute;
    date.second=second;
    return date;
}
+(DYDairy*)getDairyFromDate:(DYDate*)date{
    DYDairy *dairy =[DYDairy new];
    dairy.sevenDays=date.sevenDays;
    dairy.days=[NSString stringWithFormat:@"%ld",date.days];
    dairy.content=@"请编辑你的日记";
    dairy.year=[NSString stringWithFormat:@"%ld",date.years];
    dairy.month=[NSString stringWithFormat:@"%ld",date.month];
;
    //dairy.content=[NSString stringWithFormat:@"现在的时间是:%ld:%ld:%ld",date.hour,date.minute,date.second];
    return dairy;
    
}
+(NSString *)getTargetDaySevenDays:(NSString *)nowSevenDays andDaysOfToday:(NSInteger)daysOfTodady andMonthOfToday:(NSInteger)monthOfToday andYearOfToday:(NSInteger)yearOfToday andDaysOfTargetDay:(NSString *)daysOfTargetDay andMonthOfTargetDay:(NSString *)monthOfTargetDay andYearOfTargetDay:(NSString *)yearOfTargetDay
{
    NSArray *sevenDayArray=@[@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT"];
    NSInteger dayDistance=0;
    NSInteger targetYear = [yearOfTargetDay integerValue];
   
    for(NSInteger i =0;targetYear<=yearOfToday;i++)
    {
       if(targetYear>[yearOfTargetDay integerValue])
       {
           if((targetYear%4==0&&targetYear%100!=0)||targetYear%400==0)
           {
               dayDistance+=366;
           }
           else dayDistance+=365;
       }
        else dayDistance+=[self getLeftDaysOfOldMonths:[self getNsintMonth:monthOfTargetDay]  andYear:[yearOfTargetDay integerValue] andDay:[daysOfTargetDay integerValue]];
        targetYear++;
    }
   
    dayDistance=dayDistance-[self getLeftDaysOfOldMonths:monthOfToday andYear:yearOfToday andDay:daysOfTodady];
    NSInteger indexOfNow = [sevenDayArray indexOfObject:nowSevenDays];
    NSInteger indexOfTargetDay = ((indexOfNow -dayDistance%7)+7)%7;
    return  sevenDayArray[indexOfTargetDay];
}
+(NSInteger)getNsintMonth:(NSString*)month
{
    NSDictionary *monthDic=@{@"JANUARY":@(1),@"FEBRUARY":@(2),@"MARCH":@(3),@"APRIL":@(4),@"MAY":@(5),@"JUNE":@(6),@"JULY":@(7),@"AUGUST":@(8),@"SEPTEMBER":@(9),@"OCTOBER":@(10),@"NOVEMBER":@(11),@"DECEMBER":@(12)};
  
    return [monthDic[month] integerValue];
}
+(NSString*)getStringMonth:(NSInteger)month
{
    NSDictionary *monthDic=@{@(1):@"JANUARY",@(2):@"FEBRUARY",@(3):@"MARCH",@(4):@"APRIL",@(5):@"MAY",@(6):@"JUNE",@(7):@"JULY",@(8):@"AUGUST",@(9):@"SEPTEMBER",@(10):@"OCTOBER",@(11):@"NOVEMBER",@(12):@"DECEMBER"};
    return monthDic[@(month)];
}
+(NSInteger)getTotalDaysOfOldMonths:(NSInteger)month andYear:(NSInteger)year
{
    //判断是不是闰年
    NSDictionary *dic=[NSDictionary dictionary];
    if((year%4==0&&year%100!=0)||year%400==0)
    dic=@{@(1):@"31",@(3):@"31",@(5):@"31",@(7):@"31",@(8):@"31",@(10):@"31",@(12):@"31",@(2):@"29",@(4):@"30",@(6):@"30",@(6):@"30",@(11):@"30"};
    else
    dic=@{@(1):@"31",@(3):@"31",@(5):@"31",@(7):@"31",@(8):@"31",@(10):@"31",@(12):@"31",@(2):@"28",@(4):@"30",@(6):@"30",@(6):@"30",@(11):@"30"};

    return [dic[@(month)] integerValue];
}
+(NSInteger)getLeftDaysOfOldMonths:(NSInteger)month andYear:(NSInteger)year andDay:(NSInteger)day
{
    NSInteger days = 0;
   
    switch (month) {
        case 1:
            days+=31;
            
        case 2:
            days+=[self getTotalDaysOfOldMonths:2 andYear:year];
        case 3:
            days+=31;
        case 4:
            days+=30;
        case 5:
            days+=31;
        case 6:
            days+=30;
        case 7:
            days+=31;
        case 8:
            days+=31;
        case 9:
            days+=30;
        case 10:
            days+=31;
        case 11:
            days+=30;
        case 12:
            days+=31;
        default:
            break;
    }
    days=days-day;
    return days;
}
@end
