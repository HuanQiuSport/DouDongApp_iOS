//
//  LikeVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "MKPersonalLikeModel.h"
#import "LikeDidBackDelegate.h"
NS_ASSUME_NONNULL_BEGIN


@protocol LikeDidBackDelegate;

@interface LikeVC : BaseVC
@property (strong,nonatomic) MKPersonalLikeModel *mkLikeModel;
@property(nonatomic,strong)UICollectionView *collectionView;
/// 点击事件代理
@property (nonatomic, weak) id<LikeDidBackDelegate> mkLikeVCDelegate;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;
- (void)requestData:(MKDataBlock)block;
@end

NS_ASSUME_NONNULL_END
