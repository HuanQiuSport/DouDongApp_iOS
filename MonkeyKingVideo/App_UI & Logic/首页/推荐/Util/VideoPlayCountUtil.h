//
//  VideoPlayCountUtil.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/11.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
// 记录刷视频的个数，在未登录的时候当视频刷到一定数量的时候，就弹出登陆弹框，让用户去登陆

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoPlayCountUtil : NSObject

@property(nonatomic,assign) int playCount;

+(VideoPlayCountUtil *)util;
-(void)increase;
-(BOOL)needLogin;

@end

NS_ASSUME_NONNULL_END
