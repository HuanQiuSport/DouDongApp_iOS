//
//  LikeDidBackDelegate.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LikeDidBackDelegate <NSObject>
@optional;
#pragma mark - 点击回调
- (void)didClickLikeVC:(NSMutableDictionary*)tempDic currentPlayerIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
