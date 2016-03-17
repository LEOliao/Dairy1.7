//
//  DYEditDairyViewController.m
//  Dairy
//
//  Created by tarena06 on 16/2/19.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYEditDairyViewController.h"
#import "DYDairy.h"
#import "DYMethodAboutDataBase.h"
#import "DYLocationManager.h"
#import "DYNetworkManager.h"
#import "DYDaily.h"
#import "DYDataManager.h"
#import "DYDate.h"
#import "DYGetDate.h"
#import "MBProgressHUD+KR.h"
#import "DYImage.h"
@interface DYEditDairyViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *sevenDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *WeatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *weatherDetail;

@property(nonatomic,strong)CLLocation *userLocation;
//地理编码
@property(nonatomic,strong)CLGeocoder *geocoder;
@property(nonatomic,strong)DYDaily *daily;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *doneBtnClickConstraint;
@property (weak, nonatomic) IBOutlet UIView *savingImageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *hiddenButton;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property (nonatomic,assign)NSInteger previousImageCount;
@end

@implementation DYEditDairyViewController
- (CLGeocoder *)geocoder {
    if (!_geocoder) {
        _geocoder = [CLGeocoder new];
    }
    return _geocoder;
}
-(NSMutableArray*)imageArray
{
    if(!_imageArray)
    {
        _imageArray=[NSMutableArray array];
    }
    return _imageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView=[UIScrollView new];
    
    self.scrollView.frame=CGRectMake(0, 0,self.savingImageView.bounds.size.width, self.savingImageView.bounds.size.height);
    self.scrollView.contentSize=CGSizeMake(10*self.scrollView.bounds.size.width/4.0, self.scrollView.bounds.size.height);
    
    self.scrollView.pagingEnabled=YES;
    self.scrollView.bounces=NO;
    [self.savingImageView addSubview:self.scrollView];
    NSLog(@"%lf",self.savingImageView.bounds.size.width);
    
    self.previousImageCount=self.imageArray.count;
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getDataFromFile ];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyboard:) name:UIKeyboardWillHideNotification object:nil];

    
    
}
-(void)getDataFromFile
{
    NSDictionary *sevenDaysDic=@{@"SUN":@"SUNDAY",@"MON":@"MONDAY",@"TUE":@"TUESDAY",@"WED":@"WEDNESDAY",@"THU":@"THURSDAY",@"FRI":@"FRIDAY",@"SAT":@"SATURDAY"};
    NSDictionary *monthDic=@{@"1":@"JANUARY",@"2":@"FEBRUARY",@"3":@"MARCH",@"4":@"APRIL",@"5":@"MAY",@"6":@"JUNE",@"7":@"JULY",@"8":@"AUGUST",@"9":@"SEPTEMBER",@"10":@"OCTOBER",@"11":@"NOVEMBER",@"12":@"DECEMBER"};
    DYDairy *dairy = [DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:self.year andMonth:self.month][self.index];
    //将数据转成所需要的格式
    self.textView.text=dairy.content;
    self.sevenDaysLabel.text=sevenDaysDic[dairy.sevenDays];
    self.yearLabel.text=dairy.year;
    self.monthLabel.text=monthDic[dairy.month ];
    self.daysLabel.text=dairy.days;
    self.cityNameLabel.text=dairy.daily.cityName;
    self.daily=dairy.daily;
    NSLog(@"%@",self.cityNameLabel.text);
    if([self.cityNameLabel.text isEqualToString: @"城市名"])
    {
        self.cityNameLabel.text=@"";
    }else{
    self.cityNameLabel.text=dairy.daily.cityName;
    }
    self.WeatherImageView.image=[UIImage imageNamed:dairy.daily.iconUrl];
    
    if([self.daily.mintempC isEqualToString:@"0"]||[self.daily.maxtempC isEqualToString:@"0"])
        self.weatherDetail.text=@"";
    else
        self.weatherDetail.text=[NSString stringWithFormat:@"%@ / %@",dairy.daily.mintempC,dairy.daily.maxtempC];
    
    
    
    /*和读图片有关方法*/
    //如果是从imagePickerController过来
    if(self.imageArray.count>self.previousImageCount){
         self.previousImageCount=self.imageArray.count;
        return;
    }
    else{
   
    
    self.imageArray=[[DYMethodAboutDataBase getImageFromDairyDataBaseWithYear:[self.yearLabel.text integerValue] andMonth:self.month andDay:[self.daysLabel.text integerValue] ] mutableCopy];
         self.previousImageCount=self.imageArray.count;
    for(NSInteger i=0;i<self.previousImageCount;i++){
        DYImage *image =self.imageArray[i];
        UIImage *Image = [UIImage imageWithData:image.image];
       UIImageView *iv=[[UIImageView alloc]init];
    
    iv.frame=CGRectMake(i*self.scrollView.bounds.size.width/4.0, 0, self.scrollView.bounds.size
                        .width/4.0, self.scrollView.bounds.size.height);
    iv.image=Image;
    //NSLog(@"%f",iv.image.size.width);
        [self.scrollView addSubview:iv];
        
      }
    }

}

- (IBAction)clickFinishBtn:(id)sender {
    //添加日记内容到数据库
    DYDairy *dairy = [DYMethodAboutDataBase getDairyFromDairyDataBaseWithYear:self.year andMonth:self.month][self.index];
    dairy.content=self.textView.text;
    dairy.daily.mintempC=self.daily.mintempC;
    dairy.daily.maxtempC=self.daily.maxtempC;
    dairy.daily.iconUrl=self.daily.iconUrl;
    dairy.daily.cityName=self.daily.cityName;
    [DYMethodAboutDataBase updateDairyInDairyDataBase:dairy];
    //添加图片
    for(NSInteger i=0;i<self.imageArray.count;i++)
    {
        DYImage *image=self.imageArray[i];
        
        [DYMethodAboutDataBase putImaegIntoDairyDataBase:image];
    }
    [self.textView resignFirstResponder];
  //  [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - 请求相关的方法
-(void)getLocationAndSendRequest{
    [DYLocationManager getUserLocation:^(double lat, double lon) {
        CLLocation *location = [[CLLocation alloc]initWithLatitude:lat longitude:lon];
        //赋值
        self.userLocation =location;
        [self sendRequestToServer];
    }];
}
-(void)sendRequestToServer{
    NSString *url = [NSString stringWithFormat:@"http://api.worldweatheronline.com/free/v2/weather.ashx?q=%f,%f&num_of_days=5&format=json&tp=4&key=951890d3645e24947a7bfb29cee04", self.userLocation.coordinate.latitude, self.userLocation.coordinate.longitude];
    [DYNetworkManager sendGetRequestWithUrl:url parameters:nil success:^(id responseObject) {
        NSLog(@"返回的json数据:%@",responseObject);
        [self parseAndUpdateHeaderView:responseObject];
        //解析json数据获取当日天气
        self.daily=[DYDataManager getDailyData:responseObject];
        self.WeatherImageView.image =[UIImage imageNamed:self.daily.iconUrl];
                self.weatherDetail.text=[NSString stringWithFormat:@"%@ / %@",self.daily.mintempC,self.daily.maxtempC];
    } failure:^(NSError *error) {
        NSLog(@"服务器请求失败:%@",error.userInfo);
        
    }];
}
#pragma mark -界面相关方法
-(void)parseAndUpdateHeaderView:(id)responseObject{
    if(self.userLocation)
    {
        [self.geocoder reverseGeocodeLocation:self.userLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            if (!error) {
                //反地理编码成功
                CLPlacemark *placemark = [placemarks firstObject];
                //城市名称
                self.cityNameLabel.text = placemark.addressDictionary[@"City"];
                self.daily.cityName=self.cityNameLabel.text;
            }
        }];

    }
}
- (IBAction)clickAddWeatherBtn:(id)sender {
    //判断是不是今天点击的，如果不是，提示不能添加
    DYDate *date = [DYGetDate getDate];
    if([self.daysLabel.text integerValue]==date.days && self.month==date.month &&[self.yearLabel.text integerValue]==date.years)
    {
        [self getLocationAndSendRequest];
    }
    else{
        [MBProgressHUD showError:@"只能添加当日天气"];
    }
}
//开关键盘约束
-(void)openKeyboard:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.doneBtnClickConstraint.constant = keyboardFrame.size.height;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:^{
                         [self.view layoutIfNeeded];
                      
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}
-(void)closeKeyboard:(NSNotification *)notification
{
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    self.doneBtnClickConstraint.constant = 0;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:options
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
}
- (IBAction)addPicBtnClick:(id)sender {
    DYDate *date = [DYGetDate getDate];
    if([self.daysLabel.text integerValue]==date.days && self.month==date.month &&[self.yearLabel.text integerValue]==date.years)
    {
        
   
    self.savingImageView.hidden=NO;
    UIImagePickerController *picVC=[UIImagePickerController new];
    picVC.delegate=self;
    picVC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picVC animated:YES completion:nil];
    }
    else{
        [MBProgressHUD showError:@"只能添加当日的图片"];
    }

}
- (IBAction)hiddenPicBtnClick:(id)sender {
    self.savingImageView.hidden=!self.savingImageView.hidden;
    self.hiddenButton.selected=!self.hiddenButton.selected;
    
}
//UIImagePickController 代理方法

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSInteger i = self.imageArray.count;
    if(i<=10){
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    UIImage * newImage=[self thumbnailWithImage:image size:CGSizeMake(100, 100)];
    NSData *data =UIImageJPEGRepresentation(newImage, 0.05);
   
    UIImageView *iv=[[UIImageView alloc]init];
    
    iv.frame=CGRectMake(i*self.scrollView.bounds.size.width/4.0, 0, self.scrollView.bounds.size
                        .width/4.0, self.scrollView.bounds.size.height);
    iv.image=[UIImage imageWithData:data];
    //NSLog(@"%f",iv.image.size.width);
    [self.scrollView addSubview:iv];
    
    //self.imageView.image=[UIImage imageWithData:data];
    NSLog(@"%lf",iv.bounds.size.width);
    DYImage *imageModel = [DYImage new];
    imageModel.image=data;
    imageModel.year=self.year;
    imageModel.month=self.month;
    imageModel.day=[self.daysLabel.text integerValue];
    imageModel.order=i;
    [self.imageArray addObject:imageModel];
    }else{
        [MBProgressHUD showError:@"只能添加10张图片"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize

{
    
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }else{
        UIGraphicsBeginImageContext(asize);
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
@end
