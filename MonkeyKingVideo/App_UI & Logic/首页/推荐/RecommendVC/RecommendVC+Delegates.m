//
//  RecommendVC+Delegates.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+Delegates.h"
#import "RecommendVC+Comment.h"
#import "DMHeartFlyView.h"
#import "WJMarkAnimationView.h"
@implementation RecommendVC (Delegates)
#pragma mark - 代理回调
#pragma mark - 登录领取积分
-(void)didClickPlayLogin:(UIView *)superview WithPlayID:(NSInteger)index{}

#pragma mark - 分享
- (void)didClickPlayShare:(UIView *)superview WithPlayID:(NSInteger)index{}
#pragma mark - 评论
-(void)didClickPlayReplay:(UIView *)superview WithPlayID:(NSInteger)index{}
#pragma mark - 关注
- (void)didClickPlayAttention:(UIView *)superview WithPlayID:(NSInteger)index {}
#pragma mark - 点赞
- (void)didClickPlayZan:(UIView *)superview WithPlayID:(NSInteger)index{}
#pragma mark - 暂停 | 播放
- (void)didClickPlayOrStop:(UIView *)playerScrollView currentPlayerStatu:(MKVideoStatus)videoStatus{}
#pragma mark - 切换视频
- (void)didClickPlayChange:(UIView *)playerScrollView currentPlayerIndex:(NSInteger)index{}
#pragma mark - 跳转个人信息
- (void)didClickPlayUserInfo:(UIView *)superview WithPlayID:(NSInteger)index{}
#pragma mark - 点击玩一下 广告
- (void)didTwoClickPlayZan:(UIView *)playerScrollView currentPlayerIndex:(NSInteger)index{}
- (void)didTwoClickPlaySpecialZan:(UIView *)playerScrollView touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}


@end
