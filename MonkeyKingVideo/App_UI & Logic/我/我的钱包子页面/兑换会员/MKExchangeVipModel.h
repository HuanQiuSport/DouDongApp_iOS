//
//  MKExchangeVipModel.h
//  MonkeyKingVideo
//
//  Created by blank blank on 2020/9/8.
//  Copyright © 2020 Jobs. All rights reserved.
//
@class SelectVo;
#import <Foundation/Foundation.h>

@interface MKExchangeVipModel : NSObject
@property (nonatomic, assign) BOOL isVip;
@property (nonatomic, copy) NSString *validDate;
@property (nonatomic, strong) NSMutableArray <SelectVo *> *selectVo;

@end

@interface SelectVo:NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@end
