//
//  MKCPlayVideoView.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/8/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKVideoPlayDelegate.h"
#import "MKVideoDemandModel.h"
#import "MKPlayUserInfoView.h"
@protocol MKVideoPlayDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface MKCPlayVideoView : UIScrollView

/// 播放器点击事件代理
@property (nonatomic, weak) id<MKVideoPlayDelegate> mkPlayerDelegate;

/// 序列号
@property (nonatomic, assign) NSInteger mkIndex;

/// 信息模型
@property (nonatomic, strong) MKVideoDemandModel *mkVideoInfoModel;


/// 状态
@property (nonatomic, assign) MKVideoStatus mkVideoStatus;


///
@property (strong,nonatomic) MKPlayUserInfoView *mkPlayUserInfoView;

- (void)updateForLives:(NSMutableArray *)livesArray withCurrentIndex:(NSInteger) index;


@end

NS_ASSUME_NONNULL_END
