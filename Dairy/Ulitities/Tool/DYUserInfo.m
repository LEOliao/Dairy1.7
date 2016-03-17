//
//  DYUserInfo.m
//  Dairy
//
//  Created by tarena06 on 16/2/19.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYUserInfo.h"

@implementation DYUserInfo
singleton_implementation(DYUserInfo)
-(NSString*)jid
{
    return [NSString stringWithFormat:@"%@@%@",self.userName,DYXMPPDOMAIN];
}
@end
