//
//  DYSearchViewController.m
//  Dairy
//
//  Created by tarena06 on 16/3/3.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYSearchViewController.h"
#import "DYMethodAboutDataBase.h"
#import "DYDairy.h"
#import "DYSearchResultCell.h"
#import "DYEditDairyViewController.h"
@interface DYSearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *keywordTextFild;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)NSArray *allDairy;
@property (strong,nonatomic)NSMutableArray *searchResultArray;
@property (strong,nonatomic)DYDairy *dairy;
@end

@implementation DYSearchViewController
#pragma mark - 所有懒加载
- (NSArray *)allDairy {
    if(_allDairy == nil) {
        _allDairy = [[NSArray alloc] init];
    }
    return _allDairy;
}

- (NSMutableArray *)searchResultArray {
    if(_searchResultArray == nil) {
        _searchResultArray = [[NSMutableArray alloc] init];
    }
    return _searchResultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
}
- (IBAction)searchBtnClick:(id)sende{
    /*点击按钮后先读取数据库*/
    self.allDairy=[DYMethodAboutDataBase getAllDairyFromDataBase];
    self.searchResultArray =nil;
    NSString *keyword=self.keywordTextFild.text;
    //判断内容与关键字相同的日记，添加进数组中
    for(NSInteger i=0;i<self.allDairy.count;i++){
        DYDairy *dairy = self.allDairy[i];
        if([dairy.content rangeOfString:keyword].location!=NSNotFound)
        {
            //匹配
            [self.searchResultArray addObject:dairy];
        }
    }
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYSearchResultCell *cell=[tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    cell.dairy=nil;
//    for(NSInteger i=0;i<self.searchResultArray.count;i++)
//    {
//        DYDairy *dairy = self.searchResultArray[i];
//        cell.dairy=dairy;
//    }
    cell.dairy=self.searchResultArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DYEditDairyViewController *dairyVC=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"dairyContent"];
    DYDairy *dairy = self.searchResultArray[indexPath.row];
    dairyVC.year=[dairy.year integerValue];
    dairyVC.month=[dairy.month integerValue];
    dairyVC.day=[dairy.days integerValue];
    [self.navigationController pushViewController:dairyVC animated:YES];
}
@end











