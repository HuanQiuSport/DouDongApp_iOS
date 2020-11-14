//
//  MKPersonView.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/6/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKBtnLabelView.h"
#import "MKBorderView.h"
//#import "MKBanner.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKPersonView : UIView
/// 头像
@property (strong,nonatomic) UIImageView *mkUserImageView;

/// VIP
@property (strong,nonatomic) UIImageView *mkUserVIPImageView;

/// 用户
@property (strong,nonatomic) UILabel *mkUserLabel;

/// 用户签名
@property (strong,nonatomic) UILabel *mkDetailLabel;


/// 关注
@property (strong,nonatomic) UIButton *mkAttentionBtn;


/// 性别年龄
@property (strong,nonatomic) UIButton *mkSexAge;


/// 地区
@property (strong,nonatomic) UILabel *mkArea;

///  星座
@property (strong,nonatomic) UILabel *mkConstellationLab;

/// 关注数量
@property (strong,nonatomic) MKBtnLabelView *mkAttentionNumView;

/// 粉丝数量
@property (strong,nonatomic) MKBtnLabelView *mkFansNumView;

/// 点赞数量
@property (strong,nonatomic) MKBtnLabelView *mkZanNumView;


///
@property (strong,nonatomic) MKBorderView *mkMultiBtnView;

//@property (strong,nonatomic) MKBanner *mkBanerView;
@property (strong,nonatomic) UIButton   *mkBanerView; // 由于Banner出现BUG临时替换成BTN
@property (strong,nonatomic) UIButton   *mkEditorBtn;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UILabel *loginLab;
- (void)setAtttionStyle:(BOOL)isSelect;

- (void)taCenterRefresh;
#pragma mark - 我的个人中心重新布局 或者刷新UI
- (void)mkRefreshUILayout;

- (void)addOherView;
- (void)setNoLoginData;

-(void)refreshSkin;
@end

NS_ASSUME_NONNULL_END
