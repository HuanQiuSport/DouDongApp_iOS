//
//  MKVideoPlayDelegate.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKVideoPlayDelegate <NSObject>
///必须实现的接口
@required
///可选实现的接口
@optional
#pragma mark - 1.分享
/// 分享
/// @param superview  父级视图
/// @param index 序列号
-(void)didClickPlayShare:(UIView *)superview WithPlayID:(NSInteger)index;


#pragma mark - 2.评论
/// 评论
/// @param superview  父级视图
/// @param index 序列号
-(void)didClickPlayReplay:(UIView *)superview WithPlayID:(NSInteger)index;


#pragma mark - 3.点赞
/// 点赞
/// @param superview  父级视图
/// @param index 序列号
-(void)didClickPlayZan:(UIView *)superview WithPlayID:(NSInteger)index;

#pragma mark - 4.关注
/// 关注
/// @param superview  父级视图
/// @param index 序列号
-(void)didClickPlayAttention:(UIView *)superview WithPlayID:(NSInteger)index;

#pragma mark - 5.头像
/// 头像
/// @param superview  父级视图
/// @param index 序列号
-(void)didClickPlayUserInfo:(UIView *)superview WithPlayID:(NSInteger)index;

#pragma mark - 6.登录
/// 登录
/// @param superview  父级视图
/// @param index 序列号
-(void)didClickPlayLogin:(UIView *)superview WithPlayID:(NSInteger)index;

#pragma mark - 7.切换视频播放
/// 切换视频播放
/// @param playerScrollView
/// @param index index
- (void)didClickPlayChange:(UIView *)playerScrollView currentPlayerIndex:(NSInteger)index;

#pragma mark - 8.点击暂停视频｜视频播放
/// 点击暂停视频｜视频播放
/// @param playerScrollView
/// @param index index
- (void)didClickPlayOrStop:(UIView *)playerScrollView currentPlayerStatu:(MKVideoStatus)videoStatus;

#pragma mark - 9.双击点赞｜视频播放
/// 双击点赞｜视频播放
/// @param playerScrollView
/// @param index index
- (void)didTwoClickPlayZan:(UIView *)playerScrollView currentPlayerIndex:(NSInteger)index;

#pragma mark - 10.双击点赞｜视频播放
- (void)didTwoClickPlaySpecialZan:(UIView *)playerScrollView touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

#pragma mark - 11.观看广告
- (void)didTwoClickPlayAD:(UIView *)playerScrollView currentPlayerIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
