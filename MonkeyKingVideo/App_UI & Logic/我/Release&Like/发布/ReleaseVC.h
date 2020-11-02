//
//  ReleaseVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "MKPersonMadeVideoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReleaseVC : BaseVC
/// 用户作品信息 model
@property (strong,nonatomic) MKPersonMadeVideoModel *mkMadeModel;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
