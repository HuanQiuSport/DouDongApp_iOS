//
//  MKInfoListCell.h
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKInfoListCell : UITableViewCell
/// 消息图标
@property (strong,nonatomic) UIImageView *mKIMGageView;

/// 消息标题
@property (strong,nonatomic) UILabel *mkTitleLable;

/// 消息简介
@property (strong,nonatomic) UILabel *mkDecripLabel;

/// 底部分割线
@property (strong,nonatomic) UIView *mkLineView;

/// 消息时间
@property (strong,nonatomic) UILabel *mkTimeLable;


///
@property (strong,nonatomic) UILabel *mkNumberLabel;

@end

NS_ASSUME_NONNULL_END
