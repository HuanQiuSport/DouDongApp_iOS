//
//  MKLoginGetView.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/6/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKLoginGetView : UIView
/// backView
@property (strong,nonatomic) UIView *mkBackView;

/// 图片
@property (strong,nonatomic) UIImageView *mkImageView;


///  标题
@property (strong,nonatomic) UILabel *mkTitleLable;
@end

NS_ASSUME_NONNULL_END
