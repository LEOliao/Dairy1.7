//
//  DYXmppTool.h
//  Dairy
//
//  Created by tarena06 on 16/2/19.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "Singleton.h"
#import "DYUserInfo.h"
@protocol DYLoginProtocol<NSObject>
-(void)loginSuccess;
-(void)loginFaild;
-(void)netError;
@end
@protocol DYRegisterProtocol <NSObject>

-(void)registerSuccess;
-(void)registerFaild;
-(void)netError;

@end

@interface DYXmppTool : NSObject
singleton_interface(DYXmppTool)
@property (nonatomic,strong) XMPPStream *xmppStream;
-(void)userLogin;
-(void)userRegister;
@property(nonatomic,weak)id<DYLoginProtocol>delegate;
@property(nonatomic,weak)id<DYRegisterProtocol>Rdelegte;
@end
