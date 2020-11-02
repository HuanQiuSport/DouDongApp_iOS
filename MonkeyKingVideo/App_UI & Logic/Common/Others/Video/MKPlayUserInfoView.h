//
//  MKPlayUserInfoView.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/5/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKRightBtnView.h"
#import "MKLoginGetView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKPlayUserInfoView : UIView
///  说明
@property (strong,nonatomic) UILabel *mkDescribeLabel;
/// user image
@property (strong,nonatomic) UIImageView *mkUserImageView;


@property (strong,nonatomic) UIImageView *mkGouImageView;
/// 用户姓名
@property (strong,nonatomic) UILabel *mkUserNameLabel;
/// 关注按钮
@property (strong,nonatomic) UIButton *mkAttentionButton;
/// 右边按钮
@property (strong,nonatomic) MKRightBtnView *mkRightBtuttonView;
/// 登录的积分
@property (strong,nonatomic) MKLoginGetView *mkLoginView;
/// 视频播放状态视图
@property(nonatomic ,strong)UIImageView *mkStatusImage;

/// 广告背景图
@property(nonatomic,strong) UIView *mkAdView;

/// 广告引导语
@property (strong,nonatomic) UILabel *mkAdGuideLabel;

/// 广告logo 文本
@property (strong,nonatomic) UILabel *mkAdLogoLabel;
@end

NS_ASSUME_NONNULL_END
