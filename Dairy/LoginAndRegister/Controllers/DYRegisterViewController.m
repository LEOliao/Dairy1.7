//
//  DYRegisterViewController.m
//  Dairy
//
//  Created by tarena06 on 16/2/19.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYRegisterViewController.h"
#import "DYUserInfo.h"
#import "DYXmppTool.h"
#import "MBProgressHUD+KR.h"

@interface DYRegisterViewController ()<DYRegisterProtocol>
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation DYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)registerSuccess{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)registerFaild{
    NSLog(@"注册失败");
}
-(void)netError{
    NSLog(@"网络错误");
}
- (IBAction)registerBtnClick:(id)sender {
    if(self.username.text.length==0||self.password.text.length==0)
    {
        [MBProgressHUD showError:@"用户名或密码不能为空!"];
        return;
    }
    [DYUserInfo sharedDYUserInfo].registerType=YES;
    [DYUserInfo sharedDYUserInfo].userRegisterName=self.username.text;
    [DYUserInfo sharedDYUserInfo].userRegisterPassword=self.password.text;
    [DYXmppTool sharedDYXmppTool].Rdelegte=self;
    [[DYXmppTool sharedDYXmppTool] userRegister];

}
- (IBAction)backToLoginVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
