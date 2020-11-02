//
//  MKAttentionCell.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 我的关注
@interface MKAttentionCell : UITableViewCell

/// 消息图标
@property (strong,nonatomic) UIImageView *mKIMGageView;
/// 会员图标
@property (strong,nonatomic) UIImageView *vipImgage;
/// 消息标题
@property (strong,nonatomic) UILabel *mkTitleLable;

/// 消息简介
@property (strong,nonatomic) UILabel *mkDecripLabel;


/// 粉丝数量
@property (strong,nonatomic) UILabel *mkFansLabel;

/// 关注/取消关注
@property (strong,nonatomic) UIButton *mkOutListButton;

/// 底部分割线
@property (strong,nonatomic) UIView *mkLineView;
@end

NS_ASSUME_NONNULL_END
