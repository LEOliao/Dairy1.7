//
//  DYMainViewController.m
//  Dairy
//
//  Created by tarena06 on 16/1/27.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYMainViewController.h"
#import "DYGetDate.h"
#import "DYDate.h"
#import "DYCell.h"
#import "DYEditDairyViewController.h"
#import "DYMethodAboutDataBase.h"
#import "MBProgressHUD+KR.h"
#import "DYGetMonthOrYearBtn.h"
@interface DYMainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//记录当前页日记数量
@property NSInteger count;
@property(nonatomic,strong)DYDate *date;
@property(nonatomic,strong)NSArray *dairyArray;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property(nonatomic,strong)NSArray *allMonthBtnArray;
@property(nonatomic,strong)NSArray *allYearBtnArray;
@end

@implementation DYMainViewController
-(NSArray*)dairyArray
{
    if(!_dairyArray){
    _dairyArray=[NSArray new];
    }
    return _dairyArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.date=  [DYGetDate getDate];
    [self.monthBtn setTitle:[DYGetDate getStringMonth:self.date.month] forState:UIControlStateNormal];
    [self.yearBtn setTitle:[NSString stringWithFormat:@"%ld",self.date.years] forState:UIControlStateNormal];
       self.monthBtn.tag=self.date.month;
    self.yearBtn.tag=self.date.years;
    }
-(void)viewWillAppear:(BOOL)animated
{
//    NSInteger month = [[self.monthBtn currentTitle]integerValue];
//    NSInteger year =[[self.yearBtn currentTitle]integerValue];
    self.allMonthBtnArray=[DYGetMonthOrYearBtn getMonthBtn:self.yearBtn.tag];
    self.allYearBtnArray=[DYGetMonthOrYearBtn getYearBtn];

    NSInteger month = self.monthBtn.tag ;
    NSInteger year = [self.yearBtn.titleLabel.text integerValue];
    self.dairyArray=[DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:year andMonth:month];
    
    if(self.dairyArray.count>0){
    DYDairy *theLastDairy =self.dairyArray[self.dairyArray.count-1];
    //如果今天的日记写过了
    if([theLastDairy.days integerValue]==self.date.days )
    {
        self.count=self.date.days;
    }
    else{
        self.count=self.date.days-1;
    }
    }else{
        self.count=self.date.days-1;
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    

}
#pragma mark -ButtonClick Method
/*进入方法显示MonthScroView,显示12个月，为12个button添加方法（隐藏scrollview,显示所选月份）*/
- (IBAction)clickMonthBtn:(UIButton *)sender {
    self.monthSelectedView.hidden=NO;

    [self selectMonthYouNeed];
   }
-(void)selectMonthYouNeed
{
    //生成12个按钮
    for(NSInteger i=0;i<12;i++)
    {
        
        UIButton *button=self.allMonthBtnArray[i];
        self.monthScrollView.contentSize=CGSizeMake(self.allMonthBtnArray.count*50, self.monthScrollView.bounds.size.height);
        [button addTarget:self action:@selector(WhenClickMonthBtnYouNeed:) forControlEvents:UIControlEventTouchUpInside];
        [self.monthScrollView addSubview:button];
    }
}
-(void)WhenClickMonthBtnYouNeed:(UIButton*)button
{
    self.monthSelectedView.hidden=YES;
    [self.monthBtn setTitle:[DYGetDate getStringMonth:button.tag+1] forState:UIControlStateNormal];
    self.monthBtn.tag=button.tag+1;
    NSInteger year=[self.yearBtn.titleLabel.text integerValue];
    self.dairyArray=[DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:year andMonth:self.monthBtn.tag];
    
    self.count=[DYGetDate getTotalDaysOfOldMonths:self.monthBtn.tag andYear:year];
    [self.tableView reloadData];
}
- (IBAction)clickYearBtn:(UIButton *)sender {
    
    self.yearSelectedView.hidden=NO;
    [self selectYearYouNeed];
}
-(void)selectYearYouNeed
{
    //生成5个按钮
    for(NSInteger i=0;i<self.allYearBtnArray.count;i++)
    {
        
        UIButton *button=self.allYearBtnArray[i];
        self.yearSelectedScrollView .contentSize=CGSizeMake(self.allYearBtnArray.count*55, self.yearSelectedScrollView.bounds.size.height);
        [button addTarget:self action:@selector(WhenClickYearBtnYouNeed:) forControlEvents:UIControlEventTouchUpInside];
        [self.yearSelectedScrollView addSubview:button];
    }
}
-(void)WhenClickYearBtnYouNeed:(UIButton*)button
{
    self.yearSelectedView.hidden=YES;
    [self.yearBtn setTitle:[NSString stringWithFormat:@"%ld",button.tag+2012] forState:UIControlStateNormal];
     NSInteger year=button.tag+2012;
    self.yearBtn.tag=year;
    self.dairyArray=[DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:year andMonth:self.monthBtn.tag];
    self.count=[DYGetDate getTotalDaysOfOldMonths:self.monthBtn.tag andYear:year];
    self.allMonthBtnArray=[DYGetMonthOrYearBtn getMonthBtn:self.yearBtn.tag];
    [self.tableView reloadData];
}

- (IBAction)clickAddButton:(id)sender {
    
    //从数据库中读取最后一天的日记，当日期不超过今天，就可以添加，否则显示提示
    NSArray *array = [DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:[self.yearBtn.titleLabel.text integerValue] andMonth:self.monthBtn.tag];
    if(self.dairyArray.count>0){
    DYDairy *theLastDairy = array[array.count-1];
    if([theLastDairy.days integerValue]<self.date.days &&[theLastDairy.month integerValue]<=self.date.month &&[theLastDairy.year integerValue]<=self.date.years )
    {
        DYDairy *dairy = [DYDairy new];
        dairy = [DYGetDate getDairyFromDate:self.date];
      
        [DYMethodAboutDataBase writeDairyToDairyDataBase:dairy];
        self.dairyArray =[DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:[self.yearBtn.titleLabel.text integerValue] andMonth:self.monthBtn.tag];
        self.count++;
        [self.tableView reloadData];
    }
    else{
         [MBProgressHUD showError:@"不能添加明天的日记"];
    }
    }else{//当月日记全为空
        DYDairy *dairy = [DYDairy new];
        dairy = [DYGetDate getDairyFromDate:self.date];
        
        [DYMethodAboutDataBase writeDairyToDairyDataBase:dairy];
        self.dairyArray =[DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:[self.yearBtn.titleLabel.text integerValue] andMonth:self.monthBtn.tag];
        self.count++;
        [self.tableView reloadData];
    }
}
- (IBAction)clickBlackPointBtn:(UIButton*)sender {
    //    NSDictionary *sevenDaysDic=@{@"7":@"SUNDAY",@"1":@"MONDAY",@"2":@"TUESDAY",@"3":@"WEDNESDAY",@"4":@"THURSDAY",@"5":@"FRIDAY",@"6":@"SATURDAY"};
    //点击原点后，添加数据库
    NSInteger flag=0;
    for(NSInteger i=0;i<self.dairyArray.count;i++)
    {
        DYDairy *dairy = self.dairyArray[i];
        if(sender.tag+1==[dairy.days integerValue]){
            flag=1;
            break;
        }
        
        
    }
    if(flag==0)//点击的是黑点
    {
        DYDairy *dairy = [DYDairy new];
        dairy.days=[NSString stringWithFormat:@"%ld",sender.tag+1];
        dairy.month=[DYGetDate getStringMonth:self.monthBtn.tag];
        dairy.year=[NSString stringWithFormat:@"%ld",self.yearBtn.tag];
        dairy.content=@"请编辑日记";
        dairy.sevenDays=[DYGetDate getTargetDaySevenDays:self.date.sevenDays andDaysOfToday:self.date.days andMonthOfToday:self.date.month andYearOfToday:self.date.years andDaysOfTargetDay:dairy.days andMonthOfTargetDay:dairy.month andYearOfTargetDay:dairy.year];
        dairy.month=[NSString stringWithFormat:@"%ld",self.monthBtn.tag];
        [DYMethodAboutDataBase writeDairyToDairyDataBase:dairy];
     //   NSInteger test=self.monthBtn.tag;
        self.dairyArray= [DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:[self.yearBtn.titleLabel.text integerValue] andMonth:self.monthBtn.tag];
        [self.tableView reloadData];
    }

    
}

#pragma mark -tableView有关方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    DYCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath ];
    //防止控件重用
    
    cell.dairy=nil;
    [cell.blackPointBtn setImage:nil forState:UIControlStateNormal];
    //从database中读日记
   //如果row=数据库中的day则从数据库拿数据，pointView隐藏
    //这里暂时只比较day
   
    for(NSInteger i=0;i<self.dairyArray.count;i++)
    {
        DYDairy *dairy = self.dairyArray[i];
        if(indexPath.row+1==[dairy.days integerValue]){
            cell.dairy = dairy;
            cell.PointView.hidden=YES;
            
            
        }
        
    }
    if(cell.dairy==nil)
    {
        cell.PointView.hidden=NO;
        
      //  cell.blackPointBtn.tag=indexPath.row;
        
        NSString *sevenDays=[DYGetDate getTargetDaySevenDays:self.date.sevenDays andDaysOfToday:self.date.days andMonthOfToday:self.date.month andYearOfToday:self.date.years andDaysOfTargetDay:[NSString stringWithFormat:@"%ld",indexPath.row+1] andMonthOfTargetDay:[DYGetDate getStringMonth:self.monthBtn.tag] andYearOfTargetDay:[NSString stringWithFormat:@"%ld",self.yearBtn.tag]];
        if([sevenDays isEqualToString:@"SUN"])
            [cell.blackPointBtn setImage:[UIImage imageNamed:@"passcode_dot_red"] forState:UIControlStateNormal];
        else
            [cell.blackPointBtn setImage:[UIImage imageNamed:@"passcode_dot_on"] forState:UIControlStateNormal];
    }
    cell.blackPointBtn.tag=indexPath.row;
   
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYEditDairyViewController *dairyVC=[self.storyboard instantiateViewControllerWithIdentifier:@"dairyContent"];
   // dairyVC.row=indexPath.row;
//     self.dairyArray=[DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:[self.yearBtn.titleLabel.text integerValue] andMonth:self.monthBtn.tag];
    dairyVC.year=[self.yearBtn.titleLabel.text integerValue];
    dairyVC.month=self.monthBtn.tag;
    //NSInteger test=self.dairyArray.count;
    for(NSInteger i=0;i<self.dairyArray.count;i++)
    {
          DYDairy *dairy = self.dairyArray[i];
          if([dairy.days integerValue]==indexPath.row+1)
              dairyVC.index=i;
    }
    dairyVC.day=indexPath.row+1;
    [self.navigationController pushViewController:dairyVC animated:YES];
}



@end

















