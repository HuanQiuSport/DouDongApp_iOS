//
//  MKDouYinControlView.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayerMediaControl.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^MKDouYinControlViewBLOCK)(NSString *str);
@interface MKDouYinControlView : UIView
<ZFPlayerMediaControl>
@property (nonatomic,copy) MKDouYinControlViewBLOCK playerLoadStateChangedBlock; // 播放回调
@property (nonatomic, strong) ZFSliderView *sliderView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, assign) BOOL effectViewShow;
@property (nonatomic, strong, readonly) UIImageView *coverImageView;
- (void)resetControlView;

- (void)showCoverViewWithUrl:(NSString *)coverUrl;

@end

NS_ASSUME_NONNULL_END
