//
//  DYUserInfo.h
//  Dairy
//
//  Created by tarena06 on 16/2/19.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface DYUserInfo : NSObject
singleton_interface(DYUserInfo)
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userPassword;

@property(nonatomic,copy)NSString *userRegisterName;
@property (nonatomic,strong) NSString *userRegisterPassword;
@property (nonatomic,strong) NSString *jid;

//区分到底是登录还是注册
@property (nonatomic,assign,getter=isRegisterType) BOOL registerType;
@end
