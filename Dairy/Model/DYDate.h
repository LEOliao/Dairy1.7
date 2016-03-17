//
//  DYDate.h
//  Dairy
//
//  Created by tarena06 on 16/1/27.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYDate : NSObject
@property NSInteger month;
@property NSInteger days;
@property (nonatomic,strong) NSString *sevenDays;
@property NSInteger years;
@property NSInteger hour;
@property NSInteger minute;
@property NSInteger second;
@end
