//
//  DYGetMonthOrYearBtn.m
//  Dairy
//
//  Created by tarena06 on 16/2/28.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYGetMonthOrYearBtn.h"
#import "DYDate.h"
#import "DYGetDate.h"
@implementation DYGetMonthOrYearBtn
singleton_implementation(DYGetMonthOrYearBtn)
+(NSArray*)getMonthBtn:(NSInteger)year
{
    NSMutableArray *allMonthBtnArray=[NSMutableArray array];
    DYDate *date=[DYGetDate getDate];
    for (NSInteger i=0; i<12; i++)
    {
        UIButton *button=[[UIButton alloc]init];
        button.frame = CGRectMake(i*50,5, 50, 30);
        NSString *imageName = [NSString stringWithFormat:@"%ld月_off",i+1];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        button.tag=i;
        
        if ((button.tag> date.month-1)&&year==date.years)
        {
            button.enabled=NO;
        }
        
        [allMonthBtnArray addObject:button];
    }
    return [allMonthBtnArray copy];
}
+(NSArray*)getYearBtn
{
   NSMutableArray *allYearsBtnArray=[NSMutableArray array];//储存年份button的数组
    DYDate *date = [DYGetDate getDate];
    NSInteger i = date.years-2012+1;
    for (NSInteger j=0; j<i;j++)
    {
        UIButton *button=[[UIButton alloc]init];
        button.frame = CGRectMake(j*55,5, 50, 30);
        button.titleLabel.backgroundColor=[UIColor blackColor];
        button.tag=j;
        // NSLog(@"%ld",date.years-(long)i+1);
     
        [button setTitle:[NSString stringWithFormat:@"%ld",date.years-(i-j)+1] forState:UIControlStateNormal];
        
        [allYearsBtnArray addObject:button];
    }
    return [allYearsBtnArray copy];
}
@end
