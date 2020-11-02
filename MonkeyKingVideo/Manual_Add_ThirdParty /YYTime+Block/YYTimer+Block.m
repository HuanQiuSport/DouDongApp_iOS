//
//  YYTimer+Block.m
//  YYTimer+Block
//
//  Created by lzf on 2020/2/16.
//  Copyright © 2020 bnu. All rights reserved.
//

#import "YYTimer+Block.h"
#import <objc/runtime.h>

@implementation YYTimer (Block)

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (YYTimerBlock)block {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBlock:(YYTimerBlock)block {
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (instancetype)initWithFireTime:(NSTimeInterval)start
                        interval:(NSTimeInterval)interval
                         repeats:(BOOL)repeats
                      usingBlock:(YYTimerBlock)block {
    YYTimer *timer = [self initWithFireTime:0 interval:interval target:self selector:@selector(_execBlock:) repeats:repeats];
    timer.block = block;
    return timer;
}

+ (YYTimer *)timerWithTimeInterval:(NSTimeInterval)interval
                           repeats:(BOOL)repeats
                        usingBlock:(YYTimerBlock)block {
    return [[self alloc] initWithFireTime:0 interval:interval repeats:repeats usingBlock:block];
}

- (void)_execBlock:(YYTimer *)timer {
    if (timer.block) {
        timer.block(timer);
    }
}

@end
