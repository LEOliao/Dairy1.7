//
//  DYEditDairyViewController.h
//  Dairy
//
//  Created by tarena06 on 16/2/19.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYEditDairyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
//@property (nonatomic,assign) NSInteger index;
@property(nonatomic ,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger day;
@end
