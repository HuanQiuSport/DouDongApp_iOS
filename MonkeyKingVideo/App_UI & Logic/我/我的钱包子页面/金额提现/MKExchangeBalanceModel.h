//
//  MKExchangeBalanceModel.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/16.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//
@class SelectBalanceModelVo;
#import <Foundation/Foundation.h>

@interface MKExchangeBalanceModel : NSObject
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *withDrawTips;
@property (nonatomic, assign) NSInteger lessCount;
@property (nonatomic, strong) NSMutableArray <SelectBalanceModelVo *> *selectVo;
@end

@interface SelectBalanceModelVo:NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *needDays;
@property (nonatomic, copy) NSString *needFriends;
@end

@interface SuccessBalanceModel:NSObject
@property (nonatomic, copy) NSString *arriveDate;
@property (nonatomic, copy) NSString *money;
@end
