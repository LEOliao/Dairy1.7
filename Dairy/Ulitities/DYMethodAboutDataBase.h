//
//  DYMethodAboutDataBase.h
//  Dairy
//
//  Created by tarena06 on 16/2/22.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYDairy.h"
#import "DYImage.h"
@interface DYMethodAboutDataBase : NSObject
+(NSArray *)getDairyFromDairyDataBaseWithYear:(NSInteger)year andMonth:(NSInteger)month ;
+(NSArray*)getImageFromDairyDataBaseWithYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day;
+(void)writeDairyToDairyDataBase:(DYDairy*)dairy;
+(void)putImaegIntoDairyDataBase:(DYImage*)image;
+(void)updateDairyInDairyDataBase:(DYDairy*)dairy;
+(NSArray*)getAllDairyFromDataBase;
@end
