//
//  DYNetworkManager.m
//  Dairy
//
//  Created by tarena06 on 16/2/24.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYNetworkManager.h"
#import "AFNetworking.h"
@implementation DYNetworkManager
+(void)sendGetRequestWithUrl:(NSString *)urlStr parameters:(NSDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure
{
    //和AFNetworking相关的调用
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
        //服务器成功返回；responseObject回传控制器
        //相当于函数
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
@end
