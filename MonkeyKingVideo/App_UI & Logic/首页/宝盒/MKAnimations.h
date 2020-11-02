//
//  MKAnimations.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAnimations : UIViewController
+ (void)moveDownScaleSmall:(UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length;
+ (void)moveUpSCaleBig:(UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length;
+ (void) moveUp: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length;
+ (void) moveDown: (UIView *)view andAnimationDuration: (float) duration andWait:(BOOL) wait andLength:(float) length;
@end

NS_ASSUME_NONNULL_END
