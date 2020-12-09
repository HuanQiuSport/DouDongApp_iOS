//
//  MKImageBtnVIew.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/5/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKImageBtnVIew : UIView
/// 图片
@property(strong,nonatomic)UIImageView *mkImageView;
/// 文本
@property(strong,nonatomic)UILabel *mkTitleLable;
/// 按钮
@property(strong,nonatomic)UIButton *mkButton;

@end

NS_ASSUME_NONNULL_END
