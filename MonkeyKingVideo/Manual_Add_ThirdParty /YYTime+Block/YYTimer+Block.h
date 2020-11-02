//
//  YYTimer+Block.h
//  YYTimer+Block
//
//  Created by lzf on 2020/2/16.
//  Copyright © 2020 bnu. All rights reserved.
//

#include "YYTimer.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^YYTimerBlock)(YYTimer *timer);

@interface YYTimer (Block)

+ (YYTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                           repeats:(BOOL)repeats
                        usingBlock:(YYTimerBlock)block;

- (instancetype)initWithFireTime:(NSTimeInterval)start
                        interval:(NSTimeInterval)interval
                         repeats:(BOOL)repeats
                      usingBlock:(YYTimerBlock)block;

@end

NS_ASSUME_NONNULL_END
