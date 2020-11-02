//
//  LikeVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN
@class MKPersonalnfoModel;
@class MKPersonalLikeModel;
@interface LikedVC : BaseVC
/// 用户作品信息 model
@property (strong,nonatomic) MKPersonalLikeModel *mkLikeModel;
/// 用户信息model
@property (strong,nonatomic) MKPersonalnfoModel *mkPernalModel;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;
- (void)requestData;
@end

NS_ASSUME_NONNULL_END
