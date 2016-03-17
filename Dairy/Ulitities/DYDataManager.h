//
//  DYDataManager.h
//  Dairy
//
//  Created by tarena06 on 16/2/24.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYDaily.h"
@interface DYDataManager : NSObject
+(DYDaily*)getDailyData:(id)responseObject;
+ (NSDictionary *)imageMap;
@end
