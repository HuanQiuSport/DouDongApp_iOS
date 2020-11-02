//
//  MKCircularProgressView.h
//  AllOpenGL
//
//  Created by hansong on 9/10/20.
//  Copyright © 2020 hansong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol MKCircularProgressViewDelegate <NSObject>
@optional
- (void)updateProgressViewWithPlayer:(AVAudioPlayer *)player;
- (void)updatePlayOrPauseButton;
- (void)playerDidFinishPlaying;
@end
@interface MKCircularProgressView : UIView
@property (nonatomic) UIColor *backColor;
@property (nonatomic) UIColor *progressColor;
@property (nonatomic) NSURL *audioURL;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic) float progress;
@property (nonatomic) BOOL playOrPauseButtonIsPlaying;
@property (nonatomic) id <MKCircularProgressViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth;
- (instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
