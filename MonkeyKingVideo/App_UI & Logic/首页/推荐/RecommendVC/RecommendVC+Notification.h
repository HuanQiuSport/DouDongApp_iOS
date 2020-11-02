//
//  RecommendVC+Notification.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RecommendVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC (Notification)
/// 添加监听
- (void)addNotification;
/// 页面消失也可以存在的通知
-(void)addDidDisappearNotification;
/// 移除监听
- (void)removeNotification;
@end

NS_ASSUME_NONNULL_END
