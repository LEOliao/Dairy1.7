//
//  DYImage.h
//  Dairy
//
//  Created by tarena06 on 16/3/2.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYImage : NSObject
@property (atomic)NSInteger year;
@property (atomic)NSInteger month;
@property (atomic)NSInteger day;
@property (atomic)NSInteger order;
@property (nonatomic,strong) NSData* image;

@end
