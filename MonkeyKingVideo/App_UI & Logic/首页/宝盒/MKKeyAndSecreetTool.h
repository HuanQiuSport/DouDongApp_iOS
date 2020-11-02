//
//  MKKeyAndSecreetTool.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/8/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 基本加密处理方式
@interface MKKeyAndSecreetTool : NSObject
//btime-->1599534482171
//etime-->1599534842171
//编码：MTU5OTUzNDQ4MjE3MQ==
//加盐编码：MTU5OTUzNDQ4MjE3MW5pR01ZYXFWNnI=
//解码：1599534482171niGMYaqV6r
//
///// 加密 base64
/// @param str 传入字符串 返回字符串
+ (NSString *)encodeString:(NSString *)str;

/// 解密 base64
/// @param str 传入字符串 返回字符串
+ (NSString *)decodeString:(NSString *)str;

//获取当前时间戳(以毫秒为单位)
+ (NSString *)getNowTimeTimestamp3;
//获取当前时间戳(以秒为单位)
+ (NSString *)getNowTimeTimestamp;
+ (NSString *)getTimeWithChangeStr:(NSString *)dateStr;


/// 时间戳->时间  (以毫秒为单位)
+ (NSString*)dateWithString:(NSString*)str Format:(NSString*)format;
/// 时间戳->时间  (以秒为单位)
+ (NSString*)dateMSWithString:(NSString*)str Format:(NSString*)format;
+ (NSDictionary *)getRecord;
+ (Boolean)handerOpenTime:(NSString *)time;
@end

NS_ASSUME_NONNULL_END
