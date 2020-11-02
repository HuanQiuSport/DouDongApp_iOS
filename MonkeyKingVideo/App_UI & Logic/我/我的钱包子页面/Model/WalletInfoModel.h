//
//  WalletInfoModel.h
//  MonkeyKingVideo
//
//  Created by kkk on 2020/10/31.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletInfoModel : NSObject
@property (nonatomic, assign) double balance;
@property (nonatomic, assign) double drawBalance;
@property (nonatomic, assign) int drawCount;
@property (nonatomic, assign) int friendCount;
@property (nonatomic, assign) int signCount;

@end

NS_ASSUME_NONNULL_END
