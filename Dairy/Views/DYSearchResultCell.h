//
//  DYSearchResultCell.h
//  Dairy
//
//  Created by tarena06 on 16/3/4.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYDairy.h"
@interface DYSearchResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *sevenDays;
@property (weak, nonatomic) IBOutlet UIButton *days;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(nonatomic,strong) DYDairy *dairy;
@end
