//
//  MyCoinVC.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCoinVC : BaseVC

@property(nonatomic,strong)UILabel *showNumLab;
@property(nonatomic,strong)NSString *TipsStr;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
      comingStyle:(ComingStyle)comingStyle
presentationStyle:(UIModalPresentationStyle)presentationStyle
    requestParams:(nullable id)requestParams
          success:(MKDataBlock)block
         animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
