//
//  DYSearchResultCell.m
//  Dairy
//
//  Created by tarena06 on 16/3/4.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYSearchResultCell.h"

@implementation DYSearchResultCell

-(void)setDairy:(DYDairy *)dairy
{
    _dairy=dairy;
    [self.sevenDays setTitle:dairy.sevenDays forState:UIControlStateNormal];
    [self.days setTitle:dairy.days forState:UIControlStateNormal];
    self.contentLabel.text=[NSString stringWithFormat:@"%@",dairy.content];
    
}
@end
