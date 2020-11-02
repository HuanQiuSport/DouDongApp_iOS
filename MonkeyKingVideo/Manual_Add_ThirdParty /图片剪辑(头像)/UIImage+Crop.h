//
//  UIImage+Crop.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/14.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Crop)
/**
 缩放指定大小

 @param newSize 缩放后的尺寸
 @return UIImage
 */
- (UIImage *)resizeImageWithSize:(CGSize)newSize;

/**
 图片圆形裁剪

 @return UIImage
 */
- (UIImage *)ovalClip;
@end

NS_ASSUME_NONNULL_END
