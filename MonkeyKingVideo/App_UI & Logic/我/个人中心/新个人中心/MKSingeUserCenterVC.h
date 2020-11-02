//
//  MKSingeUserCenterVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

static const CGFloat JXTableHeaderViewHeight = 289;
static const CGFloat JXheightForHeaderInSection = 50;

@class MKPersonalnfoModel;
@class PagingViewTableHeaderView;
NS_ASSUME_NONNULL_BEGIN

// 个人中心 新的
@interface MKSingeUserCenterVC : BaseVC<JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, strong) JXPagerListRefreshView *pagerView;
@property (nonatomic, strong) PagingViewTableHeaderView *userHeaderView;
@property (nonatomic, strong, readonly) JXCategoryTitleView *categoryView;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
@property(nonatomic,strong)id requestParams;
/// 用户信息model
@property(strong,nonatomic) MKPersonalnfoModel *mkPernalModel;
@end

NS_ASSUME_NONNULL_END
