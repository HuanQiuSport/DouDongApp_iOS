//
//  RecommendVC+MKMoney.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/4/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RecommendVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC (MKMoney)
///  添加刷币
-(void)mkAddShuaCoin;


/// 设置刷币时间
- (void)mkSettingShuaCoin:(CGFloat)time;

///  移除刷币
- (void)mkRemoveShuaCoin;
@end

NS_ASSUME_NONNULL_END
