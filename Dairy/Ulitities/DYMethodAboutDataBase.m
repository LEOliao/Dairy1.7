//
//  DYMethodAboutDataBase.m
//  Dairy
//
//  Created by tarena06 on 16/2/22.
//  Copyright © 2016年 tarena06. All rights reserved.
//

#import "DYMethodAboutDataBase.h"
#import <sqlite3.h>

@implementation DYMethodAboutDataBase
+(sqlite3 *)openDataBase
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *databasePath = [documentsPath stringByAppendingPathComponent:@"dairy.sqlite"];
    sqlite3 *database;
    int ret = sqlite3_open([databasePath cStringUsingEncoding:NSUTF8StringEncoding], &database);
    //如果没有数据库文件，就创建；否则，就打开
    if (ret != SQLITE_OK) {
        NSLog(@"数据库文件创建失败");
        return nil;
    }
    //创建表格
    const char *createTableDairySql="create table if not exists dairy(dairyContent text,year integer,month integer,day integer,sevenDays text,weatherPic text,minTem integer,maxTem integer,cityName text)";
    char *errmsg;
    ret = sqlite3_exec(database, createTableDairySql, NULL, NULL, &errmsg);
    if (ret != SQLITE_OK) {
        NSLog(@"表创建失败 %s", sqlite3_errmsg(database));
        return nil;
    }
    const char *createTableImageSql="create table if not exists image(year integer,month integer,day integer,id integer,image text)";
    
    ret = sqlite3_exec(database, createTableImageSql, NULL, NULL, &errmsg);
    if (ret != SQLITE_OK) {
        NSLog(@"表创建失败 %s", sqlite3_errmsg(database));
        return nil;
    }

    return database;
}
//读数据库
+(NSArray *)getImageFromDairyDataBaseWithYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day
{
    sqlite3 *database = [self openDataBase];
    NSString *query = [NSString stringWithFormat:@"select image from image where year=%ld and month = %ld and day=%ld order by year ,month ,day,id",year,month,day];
    const char *querySql=[query UTF8String];
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare_v2(database, querySql, -1, &stmt, NULL);
    NSMutableArray *imageMutableArray = [NSMutableArray array];
    if(ret==SQLITE_OK){
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            DYImage *image = [DYImage new];
           const char* Image=(char*)sqlite3_column_text(stmt, 0);
            NSString *imageNSString = [NSString stringWithCString:Image encoding:NSUTF8StringEncoding];
            image.image=[[NSData alloc] initWithBase64EncodedString:imageNSString options:NSDataBase64DecodingIgnoreUnknownCharacters];
            [imageMutableArray addObject:image];
        }
    }
    sqlite3_close(database);
    return [imageMutableArray copy];
}
//读一个月的日记
+(NSArray *)getDairyFromDairyDataBaseWithYear:(NSInteger)year andMonth:(NSInteger)month
{
    
    sqlite3 *database=[self openDataBase];
    NSString *querySQL=[NSString stringWithFormat:@"select* from dairy where year=%ld and month=%ld order by year ,month,day",year,month];
    const char *querySql = [querySQL UTF8String];
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare_v2(database, querySql, -1, &stmt, NULL);
    
    
    //创建可变数组保存所有日记
    NSMutableArray *dairyMutableArray = [NSMutableArray array];
    if (ret == SQLITE_OK) {
        //从stmt变量中获取所有记录
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //有记录的(根据不同的字段类型选不同的函数)
            char *dairyContent = (char*)sqlite3_column_text(stmt, 0);
            int year = sqlite3_column_int(stmt, 1);
            int month = sqlite3_column_int(stmt, 2);
            int day = sqlite3_column_int(stmt, 3);
            char *sevendays = (char *)sqlite3_column_text(stmt, 4);
            char *weatherPic = (char *)sqlite3_column_text(stmt, 5);
            int minTem=sqlite3_column_int(stmt, 6);
            int maxTem=sqlite3_column_int(stmt, 7);
            char *cityName=(char *)sqlite3_column_text(stmt, 8);
            DYDairy *dairy=[DYDairy new];
            dairy.daily=[DYDaily new];
            dairy.content=[NSString stringWithCString:dairyContent encoding:NSUTF8StringEncoding];
            dairy.sevenDays=[NSString stringWithCString:sevendays encoding:NSUTF8StringEncoding];
            dairy.year = [NSString stringWithFormat:@"%d",year];
            dairy.month = [NSString stringWithFormat:@"%d",month];
            dairy.days = [NSString stringWithFormat:@"%d",day];
            
            dairy.daily.mintempC=[NSString stringWithFormat:@"%d",minTem];
            dairy.daily.maxtempC=[NSString stringWithFormat:@"%d",maxTem];
            if(strcmp(weatherPic, "(null)")==0)
                weatherPic="无天气记录";
            if(strcmp(cityName, "(null)")==0)
                cityName="城市名";
            dairy.daily.iconUrl=[NSString stringWithCString:weatherPic encoding:NSUTF8StringEncoding];
            dairy.daily.cityName=[NSString stringWithCString:cityName encoding:NSUTF8StringEncoding];
            [dairyMutableArray addObject:dairy];
        }
    }
    //关闭数据库
    sqlite3_close(database);
    return [dairyMutableArray copy];
}
//读取全部日记
+(NSArray *)getAllDairyFromDataBase
{
    sqlite3 *database=[self openDataBase];
    NSString *querySQL=[NSString stringWithFormat:@"select* from dairy order by year ,month,day"];
    const char *querySql = [querySQL UTF8String];
    sqlite3_stmt *stmt;
    int ret = sqlite3_prepare_v2(database, querySql, -1, &stmt, NULL);
    
    
    //创建可变数组保存所有日记
    NSMutableArray *dairyMutableArray = [NSMutableArray array];
    if (ret == SQLITE_OK) {
        //从stmt变量中获取所有记录
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //有记录的(根据不同的字段类型选不同的函数)
            char *dairyContent = (char*)sqlite3_column_text(stmt, 0);
            int year = sqlite3_column_int(stmt, 1);
            int month = sqlite3_column_int(stmt, 2);
            int day = sqlite3_column_int(stmt, 3);
            char *sevendays = (char *)sqlite3_column_text(stmt, 4);
            char *weatherPic = (char *)sqlite3_column_text(stmt, 5);
            int minTem=sqlite3_column_int(stmt, 6);
            int maxTem=sqlite3_column_int(stmt, 7);
            char *cityName=(char *)sqlite3_column_text(stmt, 8);
            DYDairy *dairy=[DYDairy new];
            dairy.daily=[DYDaily new];
            dairy.content=[NSString stringWithCString:dairyContent encoding:NSUTF8StringEncoding];
            dairy.sevenDays=[NSString stringWithCString:sevendays encoding:NSUTF8StringEncoding];
            dairy.year = [NSString stringWithFormat:@"%d",year];
            dairy.month = [NSString stringWithFormat:@"%d",month];
            dairy.days = [NSString stringWithFormat:@"%d",day];
            
            dairy.daily.mintempC=[NSString stringWithFormat:@"%d",minTem];
            dairy.daily.maxtempC=[NSString stringWithFormat:@"%d",maxTem];
            if(strcmp(weatherPic, "(null)")==0)
                weatherPic="无天气记录";
            if(strcmp(cityName, "(null)")==0)
                cityName="城市名";
            dairy.daily.iconUrl=[NSString stringWithCString:weatherPic encoding:NSUTF8StringEncoding];
            dairy.daily.cityName=[NSString stringWithCString:cityName encoding:NSUTF8StringEncoding];
            [dairyMutableArray addObject:dairy];
        }
    }
    //关闭数据库
    sqlite3_close(database);
    return [dairyMutableArray copy];

}
//插入日记到数据库
+(void)writeDairyToDairyDataBase:(DYDairy *)dairy
{
    sqlite3 *database = [self openDataBase];
    NSString *insertSQL=[NSString stringWithFormat:@"insert into dairy (dairyContent,year,month,day,sevenDays,weatherPic,minTem,maxTem,cityName) values('%@',%@,%@,%@,'%@','%@',%@,%@,'%@')",dairy.content,dairy.year,dairy.month,dairy.days,dairy.sevenDays,dairy.daily.iconUrl,dairy.daily.mintempC,dairy.daily.maxtempC,dairy.daily.cityName];
   //  const char *insertSql = [insertSQL cStringUsingEncoding:NSASCIIStringEncoding];
    const char *insertSql=[insertSQL UTF8String];
    char *errmsg;
    int ret = sqlite3_exec(database, insertSql, NULL, NULL, &errmsg);
    if(ret != SQLITE_OK)
    {
        NSLog(@"插入数据失败:%s",errmsg);
        return;
    }
    //插入数据后对数据库进行排序
NSLog(@"插入数据成功");
    sqlite3_close(database);
}
+(void)putImaegIntoDairyDataBase:(DYImage *)image1
{
    sqlite3 *database = [self openDataBase];
    NSString *imageString=[image1.image base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *insertSQL= [NSString stringWithFormat:@"insert into image(year,month,day,id,image) values(%ld,%ld,%ld,%ld,'%@')",image1.year,image1.month,image1.day,image1.order,imageString];
      const char *insertSql=[insertSQL UTF8String];
    char *errmsg;
    int ret = sqlite3_exec(database, insertSql, NULL, NULL, &errmsg);
    if(ret != SQLITE_OK)
    {
        NSLog(@"插入数据失败:%s",errmsg);
        return;
    }
    //插入数据后对数据库进行排序
    NSLog(@"插入数据成功");
    sqlite3_close(database);}
//更新数据库
+(void)updateDairyInDairyDataBase:(DYDairy *)dairy
{
    sqlite3 *database = [self openDataBase];
    NSString *updateSQL=[NSString stringWithFormat:@"update dairy set dairyContent='%@',weatherPic='%@' ,minTem=%@ ,maxTem=%@ , cityName='%@' where year=%@ and month=%@ and day=%@",dairy.content,dairy.daily.iconUrl,dairy.daily.mintempC,dairy.daily.maxtempC,dairy.daily.cityName,dairy.year,dairy.month,dairy.days];
    const char *updateSql = [updateSQL UTF8String];
    char *errmsg;
    int ret = sqlite3_exec(database, updateSql, NULL, NULL, &errmsg);
    if(ret != SQLITE_OK)
    {
        NSLog(@"更新数据失败:%s",errmsg);
        return;
    }
    sqlite3_close(database);

}
@end











