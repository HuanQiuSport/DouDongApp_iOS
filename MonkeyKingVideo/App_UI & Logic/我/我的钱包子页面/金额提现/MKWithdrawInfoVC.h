//
//  MKWithdrawInfoVC.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/29.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKWithdrawInfoVC : BaseVC

@property(nonatomic,copy)NSString *balance;
@property(nonatomic,copy)NSString *time;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
      comingStyle:(ComingStyle)comingStyle
presentationStyle:(UIModalPresentationStyle)presentationStyle
    requestParams:(nullable id)requestParams
          success:(MKDataBlock)block
         animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
