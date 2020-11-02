//
//  MKKeyAndSecreetTool.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/8/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKKeyAndSecreetTool.h"
////        btime-->1599534482171
////        etime-->15 99 53 48 42 17 1
////        编码：MTU5OTUzNDQ4MjE3MQ==
////        加盐编码：MTU5OTUzNDQ4MjE3MW5pR01ZYXFWNnI=
////        解码：1599534482171niGMYaqV6r
//        NSString *string = @"1599534482171";//niGMYaqV6r
//        NSData *base64 = string.dataValue;
//        base64 = [base64 base64EncodedDataWithOptions:0];
//        NSString *encode = [[NSString alloc] initWithData:base64
//                                                 encoding:NSUTF8StringEncoding];
//        NSLog(@"%@", encode);
//        
//        NSData *data = [[NSData alloc] initWithBase64EncodedString:encode
//                                                           options:NSDataBase64DecodingIgnoreUnknownCharacters];
//         
//        NSString *decode = data.utf8String;
//        
//        NSLog(@"%@", decode);
//        MKKeyAndSecreetTool *tool = [[MKKeyAndSecreetTool alloc]init];
//        NSLog(@"1 毫秒-%@",[tool getNowTimeTimestamp3]);
////        NSMutableString *dt = [[tool getNowTimeTimestamp3]mutableCopy];
////        NSLog(@"%@",[tool getTimeWithChangeStr:dt]);
//       NSLog(@" 2 秒-%@",[tool getNowTimeTimestamp]);
@implementation MKKeyAndSecreetTool
+ (NSString *)encodeString:(NSString *)str{
    
    NSData *base64 = str.dataValue;
    
    base64 = [base64 base64EncodedDataWithOptions:0];
    
    return [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
}

+ (NSString *)decodeString:(NSString *)str{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str
                                                       options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSLog(@"%@", data.utf8String);
    return data.utf8String;
}
//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestamp3
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}
//时间戳转 换为时间
+ (NSString *)getTimeWithChangeStr:(NSString *)dateStr
{
    //   @"/Date(1553132137409+0800)/"
//    if (dateStr) {
//        NSString *headStr = [dateStr substringFromIndex:6];
//        NSString *timeChuoStr = [headStr substringToIndex:10];
//        NSDate *timeNew = [NSDate dateWithTimeIntervalSince1970:[timeChuoStr doubleValue]];
//        NSDateFormatter *farmatter = [[NSDateFormatter alloc] init];
//        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//        [farmatter setTimeZone:timeZone];
//        [farmatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//        NSString *newTime = [farmatter stringFromDate:timeNew];
//        return newTime;
//    }
    
    NSString * timeStampString = dateStr;
    NSTimeInterval _interval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
//    NSLog(@"%@", [objDateformat stringFromDate: date]);
    return [objDateformat stringFromDate: date];
    
    return @"";
}
//获取当前时间戳(以秒为单位)
+(NSString *)getNowTimeTimestamp{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    return timeSp;

}
///时间戳->时间  (以毫秒为单位)
+ (NSString*)dateWithString:(NSString*)str Format:(NSString*)format

{
    NSTimeInterval  time = [str doubleValue];
    
    NSDate * detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString * currentDateStr = [dateFormatter stringFromDate:detaildate];

    return currentDateStr;
}
///时间戳->时间  (以毫秒为单位)
+(NSString*)dateMSWithString:(NSString*)str Format:(NSString*)format
{

    NSTimeInterval time = [str doubleValue]/1000;
    
    NSDate * detaildate = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString * currentDateStr = [dateFormatter stringFromDate:detaildate];
    
    return currentDateStr;
}
+ (NSDictionary *)getRecord{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PlayInfoRecord"ofType:@"plist"];
    
    NSDictionary *dictionary = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    return dictionary;
}
+ (Boolean)handerOpenTime:(NSString *)time{
    NSString* deCode = [self decodeString:time];
    
    NSMutableArray *dara = [NSMutableArray array];
  
    
    NSUserDefaults *defaultDic =    [NSUserDefaults standardUserDefaults];
    
    NSArray *array = [defaultDic objectForKey:@"playvideoplays"];
    BOOL isbool = [(NSArray *)defaultDic containsObject: time];
    if (isbool) {
        return YES;
    }
   
    dara = [NSMutableArray arrayWithArray:array];
    
//    if (dara) {
//        <#statements#>
//    }
    
    
    
    long  timeLong1 = [[deCode substringToIndex:13] longLongValue];
    
    
    long  timeLong2  = [[self getNowTimeTimestamp3] longLongValue];
    
    
    long  timelong3 =  timeLong2 - timeLong1  ;
    
    if (timeLong1 < 50) {
        return YES;
    }else{
        return NO;
    }
    
    
}
@end
