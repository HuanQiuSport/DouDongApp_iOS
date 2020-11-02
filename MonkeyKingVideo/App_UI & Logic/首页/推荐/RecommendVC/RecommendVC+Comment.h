//
//  RecommendVC+Comment.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RecommendVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC (Comment)
- (void)keyboard;
- (void)willClose_vertical;
- (void)willOpen;
- (void)GiveUpComment;
@end

NS_ASSUME_NONNULL_END
