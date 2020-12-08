//
//  MKWithdrawInfoVC.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/29.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKWithdrawInfoVC : BaseViewController

@property(nonatomic,copy)NSString *balance;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *qq;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
      comingStyle:(ComingStyle)comingStyle
presentationStyle:(UIModalPresentationStyle)presentationStyle
    requestParams:(nullable id)requestParams
          success:(MKDataBlock)block
         animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
