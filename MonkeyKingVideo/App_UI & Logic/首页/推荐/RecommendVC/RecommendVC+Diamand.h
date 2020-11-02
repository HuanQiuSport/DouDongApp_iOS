//
//  RecommendVC+Diamand.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RecommendVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC (Diamand)

///  添加宝盒
-(void)mkAddLauchBaoHe;


/// 设置宝盒时间
- (void)mkSettingBaeHe:(NSInteger)time;

///  移除宝盒
- (void)mkRemoveBaoHe;
@end

NS_ASSUME_NONNULL_END
