//
//  DYCell.m
//  Dairy
//
//  Created by tarena06 on 16/1/26.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYCell.h"

@interface DYCell ()



@end
@implementation DYCell
-(void)setDairy:(DYDairy *)dairy
{
    _dairy=dairy;
    [self.sevenDays setTitle:dairy.sevenDays forState:UIControlStateNormal];
    [self.days setTitle:dairy.days forState:UIControlStateNormal];
    self.contentLabel.text=[NSString stringWithFormat:@"%@",dairy.content];
   
}
@end
