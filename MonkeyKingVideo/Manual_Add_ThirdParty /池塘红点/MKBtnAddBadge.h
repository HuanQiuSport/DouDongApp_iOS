//
//  MKBtnAddBadge.h
//  AllOpenGL
//
//  Created by hansong on 8/26/20.
//  Copyright © 2020 hansong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MKBtnAddBadge : NSObject
+(MKBtnAddBadge *)shared;

/// 添加角标
/// @param targetView 将要添加的视图
/// @param size  大小
-(void)AddBadge:(UIView *)targetView SizeWith:(CGSize)size;
-(void)AddBadge:(UIView *)targetView SizeWith:(CGSize)size WithNumber:(NSInteger)number;
-(void)AddBadge:(UIView *)targetView SizeWith:(CGSize)size WithNumber:(NSInteger)number WithTargetViewRadius:(CGFloat)floats;

/// 颜色生成图片
/// @param color 颜色
+ (UIImage *)imageWithColor:(UIColor *)color;

/// 图片裁剪成圆形的
/// @param image 图片
/// @param inset 内边距
- (UIImage *)imageToHeadView:(UIImage*)image withParam:(CGFloat)inset;
@end

NS_ASSUME_NONNULL_END
