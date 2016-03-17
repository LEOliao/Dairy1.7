//
//  DYDairy.h
//  Dairy
//
//  Created by tarena06 on 16/1/27.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYDaily.h"
@interface DYDairy : NSObject
@property(nonatomic,strong)NSString *year;
@property(nonatomic,strong)NSString *month;
@property (nonatomic,strong) NSString *sevenDays;
@property (nonatomic,strong) NSString *days;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) DYDaily *daily;
@end
