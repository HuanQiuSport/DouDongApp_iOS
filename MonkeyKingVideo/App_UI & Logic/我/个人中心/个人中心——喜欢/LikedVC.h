//
//  LikeVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class MKPersonalnfoModel;
@class MKPersonalLikeModel;
@interface LikedVC : BaseViewController
/// 用户作品信息 model
@property (strong,nonatomic) MKPersonalLikeModel *mkLikeModel;
/// 用户信息model
@property (strong,nonatomic) MKPersonalnfoModel *mkPernalModel;

- (void)requestData;
@end

NS_ASSUME_NONNULL_END
