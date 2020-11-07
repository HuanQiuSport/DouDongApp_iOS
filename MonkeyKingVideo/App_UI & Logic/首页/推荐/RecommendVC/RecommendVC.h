//
//  RecommendVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "HomeVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC : BaseVC
@property(nonatomic, weak)HomeVC *homeVC;
@property(nonatomic,assign) bool isHome;
- (void)pullToRefresh;
- (void)playTheIndex:(NSInteger)index;
#pragma mark - player
- (void)initPlayer;
@end

NS_ASSUME_NONNULL_END
