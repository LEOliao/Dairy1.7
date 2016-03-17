//
//  DYCell.h
//  Dairy
//
//  Created by tarena06 on 16/1/26.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYDairy.h"
@interface DYCell : UITableViewCell
@property(nonatomic,strong) DYDairy *dairy;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIButton *sevenDays;
@property (weak, nonatomic) IBOutlet UIButton *days;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *PointView;
@property (weak, nonatomic) IBOutlet UIButton *blackPointBtn;

@end
