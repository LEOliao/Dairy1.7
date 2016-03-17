//
//  DYGetMonthOrYearBtn.h
//  Dairy
//
//  Created by tarena06 on 16/2/28.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface DYGetMonthOrYearBtn : NSObject
singleton_interface(DYGetMonthOrYearBtn)
@property (nonatomic, getter=isSelected) BOOL Selecetd;
@property (nonatomic, getter=isEnable) BOOL Enable;
+(NSArray*)getMonthBtn:(NSInteger)year;
+(NSArray*)getYearBtn;


@end
