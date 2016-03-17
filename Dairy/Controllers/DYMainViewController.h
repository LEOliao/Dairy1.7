//
//  DYMainViewController.h
//  Dairy
//
//  Created by tarena06 on 16/1/27.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYMainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *monthSelectedView;
@property (weak, nonatomic) IBOutlet UIScrollView *monthScrollView;
@property (weak, nonatomic) IBOutlet UIView *yearSelectedView;
@property (weak, nonatomic) IBOutlet UIScrollView *yearSelectedScrollView;

@end
