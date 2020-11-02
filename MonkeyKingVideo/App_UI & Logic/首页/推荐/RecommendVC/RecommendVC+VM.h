//
//  RecommendVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RecommendVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC (VM)

#pragma mark - 推荐视频列表
/// 数据请求🚀 推荐视频列表
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize Block:(MKDataBlock)block;
#pragma mark - 点赞
///  数据请求🚀 点赞
- (void)requestZanWith:(NSString*)videoID WithPraise:(NSString*)isPraise WithBlock:(TwoDataBlock)block;
#pragma mark - 关注
///  数据请求🚀 关注
- (void)requestAttentionWith:(NSString*)userID WithBlock:(MKDataBlock)block;
#pragma mark - 广告
///  数据请求🚀 广告
- (void)requestAdBlock:(MKDataBlock)block;
#pragma mark - 查询单个视频的接口
///  数据请求🚀 查询单个视频的接口
- (void)requestVideoWithID:(NSString *)videoID WithBackData:(TwoDataBlock)block;
///  分享数据请求
- (void)reuestShareData:(TwoDataBlock)block;
#pragma mark - 单日超过10分钟判定为活跃用户
- (void)sendActiveUser;
@end

NS_ASSUME_NONNULL_END
