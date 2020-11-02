//
//  MKUserInfoModel.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKUserInfoModel.h"

@implementation MKUserInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id"
    };
}

@end
