//
//  VideoPlayCountUtil.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/11.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "VideoPlayCountUtil.h"
static VideoPlayCountUtil *util=nil; //放入外部
@implementation VideoPlayCountUtil
+(instancetype)util
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[VideoPlayCountUtil alloc] init];
        util.playCount = 0;
    });
    return util;
}

-(void)increase {
    self.playCount += 1;
}

-(BOOL)needLogin {
    return self.playCount > 3;
}

@end
