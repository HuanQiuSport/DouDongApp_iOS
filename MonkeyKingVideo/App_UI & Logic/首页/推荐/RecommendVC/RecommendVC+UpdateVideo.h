//
//  RecommendVC+UpdateVideo.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RecommendVC.h"
//我是这样想的：
//1.进R页面播放，出R页面暂停，
//2.其他进页面播放，出R页面暂停，
//3.进R页面没加载完成，不播放，加载完成再播放，
//4.进R页面没加载完成，退出去了，加载完成也不播放，（这就是串音所在）
//5.进前台播放，进后台停止，
//6.像来电，视频聊天，打断不播放，回来之后继续播放，这时时间久了就要刷新
NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC (UpdateVideo)


// 刷新单个视频的数据 是否关注 点赞 评论 签名 头像 必须调用外部不要操作之后进行传值
- (void)refreshVideoList;

/// 更新数据源
- (void)updateModel;


#pragma mark - 拉取数据
- (void)getData;

/// 更新播放视频的地址
- (void)reloadPlayerWithLive:(MKVideoDemandModel *)live   playerScrollView:(MKCPlayVideoView *)playerScrollView;
/// NO 不播放  YES 播放
- (BOOL)isPlayVideo;

- (void)addDataToArray:(NSMutableArray <MKVideoDemandModel *>*)array;


@end

NS_ASSUME_NONNULL_END
