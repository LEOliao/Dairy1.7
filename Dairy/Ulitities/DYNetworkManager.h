//
//  DYNetworkManager.h
//  Dairy
//
//  Created by tarena06 on 16/2/24.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYNetworkManager : NSObject

//有传参没有返回值
typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);
+(void)sendGetRequestWithUrl:(NSString*)urlStr parameters:(NSDictionary*)paramDic success:(successBlock)success failure:(failureBlock)failure;

@end
