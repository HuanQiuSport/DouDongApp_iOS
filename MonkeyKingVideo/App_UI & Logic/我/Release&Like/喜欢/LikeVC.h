//
//  LikeVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "MKPersonalLikeModel.h"
#import "LikeDidBackDelegate.h"
NS_ASSUME_NONNULL_BEGIN


@protocol LikeDidBackDelegate;

@interface LikeVC : BaseViewController
@property (strong,nonatomic) MKPersonalLikeModel *mkLikeModel;
@property(nonatomic,strong)UICollectionView *collectionView;
/// 点击事件代理
@property (nonatomic, weak) id<LikeDidBackDelegate> mkLikeVCDelegate;

- (void)requestData:(MKDataBlock)block;
@end

NS_ASSUME_NONNULL_END
