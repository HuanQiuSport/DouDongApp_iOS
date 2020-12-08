//
//  MKMineVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
///   头部高度
//static const CGFloat MKMineVC_JXTableHeaderViewHeight = 310;
static const CGFloat MKMineVC_JXTableHeaderViewHeight = 414;
///   section高度
static const CGFloat MKMineVC_JXheightForHeaderInSection = 50;


@class MKPersonalnfoModel;
@class PagingViewTableHeaderView;

/// 新版我的中心 页面  
@interface MKMineVC : BaseViewController
<JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, strong) JXPagerListRefreshView *pagerView;
@property (nonatomic, strong) PagingViewTableHeaderView *userHeaderView;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
@property(nonatomic,strong)id requestParams;
/// 用户信息model
@property(strong,nonatomic) MKPersonalnfoModel *mkPernalModel;
@end

NS_ASSUME_NONNULL_END
