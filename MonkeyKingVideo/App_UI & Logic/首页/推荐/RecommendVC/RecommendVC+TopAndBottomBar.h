//
//  RecommendVC+TopAndBottomBar.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RecommendVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC (TopAndBottomBar)
/// 是否显示顶部导航条
- (void)mkSetNavi;

/// 发送到最前面的视图   由于是自定义的navi bar 相当于一个view ，它先添加到self.view 上，后面的播放器视图添加再navi bar 之上，所以navi bar view 就看不到了，需要通过调整视图的Z 值来达到显示的目的
- (void)sendNavibarToFront;
- (NSInteger)isHomeVCInRecommendVC;
// 是否可以获取金币
-  (BOOL)mkIsCanGetCoin;
@end

NS_ASSUME_NONNULL_END
