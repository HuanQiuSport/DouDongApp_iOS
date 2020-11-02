//
//  SceneDelegate+LaunchingAd.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SceneDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface SceneDelegate (LaunchingAd)
///如果需要网络请求得到URL
-(void)netWorkingAd;
///如果直接是固定的图片Url
-(void)fixedAdPicsUrl;
///如果是本地图片
-(void)localAdPic;
///本地图片
-(void)localAd;
///GET 查询开屏或视频广告
-(void)netWorking_MKadInfoAdInfoGET;

#pragma mark -  活跃时长
//开始
- (void)userTimeStart;
//结束
- (void)userTimeEnd;

@end

NS_ASSUME_NONNULL_END
