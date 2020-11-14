//
//  MKSetingView.h
//  MonkeyKingVideo
//
//  Created by hansong on 6/26/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 设置cell 视图
@interface MKSetingView : UIView

/// 左边图片
@property (strong,nonatomic) UIImageView *mkLeftImageView;

/// 左边文字
@property (strong,nonatomic) UILabel *mkLeftLabel;

/// 右边文字
@property (strong,nonatomic) UILabel *mkRightLabel;

/// 右边图片
@property (strong,nonatomic) UIImageView *mkRightImageView;

-(void)refreshSkin;
@end

NS_ASSUME_NONNULL_END
