//
//  DYXmppTool.m
//  Dairy
//
//  Created by tarena06 on 16/2/19.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYXmppTool.h"
@interface DYUserInfo()<XMPPStreamDelegate>
//设置流
-(void)setupXmppStream;
//连接到服务器
-(void)connectToServer;
//发送密码 请求授权
-(void)sendPassword;
//发送在线消息
-(void)sendOnLine;
@end
@implementation DYXmppTool
singleton_implementation(DYXmppTool)
//设置流
-(void)setupXmppStream
{
    self.xmppStream=[[XMPPStream alloc]init];
    [self.xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
-(void)connectToServer
{
    /*断开之前连接*/
    [self.xmppStream disconnect];
    if(self.xmppStream==nil)
    {
        [self setupXmppStream];
    }
    self.xmppStream.hostName=DYXMPPHOSTNAME;
    self.xmppStream.hostPort=DYXMPPPORT;
    //构建一个JID
    NSString *userName = nil;
    if([DYUserInfo sharedDYUserInfo].isRegisterType)
    {
        userName =[DYUserInfo sharedDYUserInfo].userRegisterName;
    }else{
        userName=[DYUserInfo sharedDYUserInfo].userName;
    }
    
    
    NSString *jidStr = [NSString stringWithFormat:@"%@@%@",userName,DYXMPPDOMAIN];
    self.xmppStream.myJID=[XMPPJID jidWithString:jidStr];
    NSError *error=nil;
    [self.xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error];
    if(error)
    {
        NSLog(@"%@",error.userInfo);
    }

}
//发送密码 请求授权
-(void)sendPassword
{
    NSString *userPassword=nil;
    NSError *error=nil;
    userPassword =[DYUserInfo sharedDYUserInfo].userPassword;
    
    if([DYUserInfo sharedDYUserInfo].isRegisterType)
    {
        userPassword = [DYUserInfo sharedDYUserInfo].userRegisterPassword;
        [self.xmppStream registerWithPassword:userPassword error:&error];
    }else{
        userPassword=[DYUserInfo sharedDYUserInfo].userPassword;
        [self.xmppStream authenticateWithPassword:userPassword error:&error];
    }
    
    if(error)
    {
        NSLog(@"%@",error);
    }
}
//发送在线消息
-(void)sendOnLine
{
    XMPPPresence *presence =[XMPPPresence presence];
    [self.xmppStream sendElement:presence];
}
//连接成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender
{
    [self sendPassword];
}
//连接失败
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    if(error)
    {
       
                if([self.delegate respondsToSelector:@selector(netError)]){
                    [self.delegate netError];
                }
        
        NSLog(@"%@",error);
    }
}
//授权成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
        [self sendOnLine];
    
        if([self.delegate respondsToSelector:@selector(loginSuccess)]){
            [self.delegate loginSuccess];
        }
}
//授权失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    
     [self.delegate loginFaild];
        if([self.delegate respondsToSelector:@selector(loginFaild)]){
    
        }
    
    NSLog(@"%@",error);
}
-(void)userLogin
{
    
    
    [self connectToServer];
}
-(void)userRegister
{
    [self connectToServer];
}
//注册成功或失败
-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    [self.Rdelegte registerSuccess];
}
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    NSLog(@"%@",error);
    [self.Rdelegte registerFaild];
}


@end
