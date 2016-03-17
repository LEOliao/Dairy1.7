//
//  DYLoginViewController.m
//  Dairy
//
//  Created by tarena06 on 16/2/19.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYLoginViewController.h"
#import "DYUserInfo.h"
#import "DYXmppTool.h"
#import "MBProgressHUD+KR.h"
@interface DYLoginViewController ()<DYLoginProtocol>
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *username;

@end

@implementation DYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    UIImageView *leftVN=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
    leftVN.frame = CGRectMake(0, 0, 55, 20);
    leftVN.contentMode=UIViewContentModeCenter;
    self.username.leftViewMode=UITextFieldViewModeAlways;
    self.username.leftView=leftVN;
    
    UIImageView *leftVP=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock"]];
    leftVP.frame = CGRectMake(0, 0, 55, 20);
    leftVP.contentMode=UIViewContentModeCenter;
    self.password.leftViewMode=UITextFieldViewModeAlways;
    self.password.leftView=leftVP;
}
-(void)loginFaild
{
    NSLog(@"login failed");
}
-(void)netError
{
    NSLog(@"login net error");
}
-(void)loginSuccess
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController=storyboard.instantiateInitialViewController;
}
- (IBAction)loginBtnClick:(id)sender {
    if(self.username.text.length==0||self.password.text.length==0)
    {
        [MBProgressHUD showError:@"用户名或密码不能为空!"];
        return;
    }
    [DYUserInfo sharedDYUserInfo].registerType=NO;
    DYUserInfo *user = [DYUserInfo sharedDYUserInfo];
    user.userName = self.username.text;
    user.userPassword=self.password.text;
    [DYXmppTool sharedDYXmppTool].delegate=self;
    [[DYXmppTool sharedDYXmppTool] userLogin];
}


@end
