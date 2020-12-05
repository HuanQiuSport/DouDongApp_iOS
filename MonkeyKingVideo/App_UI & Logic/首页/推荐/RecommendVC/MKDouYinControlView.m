//
//  MKDouYinControlView.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKDouYinControlView.h"
#import "UIView+ZFFrame.h"
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"
#import "ZFLoadingView.h"
#import "ZFSliderView.h"
#import "ZFPlayerController.h"
#import <YYKit/YYKit.h>

@interface MKDouYinControlView()<ZFSliderViewDelegate>
///
@property (assign,nonatomic) ZFReachabilityStatus status ;

@property (assign,nonatomic) NSInteger loadState;

@property(nonatomic,strong) NSMutableArray  *dataSource;

@property(nonatomic,strong) CADisplayLink *displayLink;

@property(nonatomic,assign) NSTimeInterval lastPlayTime;

@end
@implementation MKDouYinControlView
@synthesize player = _player;
- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.playBtn];
        [self addSubview:self.sliderView];
        [self resetControlView];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        _displayLink = [CADisplayLink displayLinkWithTarget:[YYWeakProxy proxyWithTarget:self] selector:@selector(updateLodaing)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
    }
    return self;
}

-(void)updateLodaing {
    if(self.sliderView.isdragging) {
        return;
    }
    NSTimeInterval curentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval loadingTime = curentTime - self.lastPlayTime;
    if(self.playBtn.isHidden && loadingTime > 0.2) {
        NSLog(@"startAnimating------%f",loadingTime);
        [self.sliderView startAnimating];
    } else {
        NSLog(@"stopAnimating------%f",loadingTime);
        [self.sliderView stopAnimating];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.zf_width;
    CGFloat min_view_h = self.zf_height;
    
    min_w = 100;
    min_h = 100;
    self.playBtn.frame = CGRectMake(min_x, min_y, min_w, min_h);
    self.playBtn.center = self.center;
    
    min_x = 0;
    min_y = min_view_h - 5;
    min_w = min_view_w;
    min_h = 20;
    self.sliderView.frame = CGRectMake(min_x, min_y - 20, min_w, min_h);
}

- (void)reachabilityChanged:(NSNotification *)notify{
    [self.player.currentPlayerManager reloadPlayer];
}
- (void)updateLayout{
    [super updateLayout];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.zf_width;
    CGFloat min_view_h = self.zf_height;
    min_x = 0;
    min_y = min_view_h - 5;
    min_w = min_view_w;
    min_h = 1;
    self.sliderView.frame = CGRectMake(min_x, min_y-KBottomHeight-kTabBarHeight, min_w, min_h);
}
- (void)resetControlView {
    self.playBtn.hidden = YES;
    self.sliderView.value = 0;
    self.sliderView.bufferValue = 0;
}

#pragma mark - KVO 监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
}

/// 播放进度改变回调
- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    NSLog(@"currentTime---%.2f",currentTime);
    self.sliderView.value = videoPlayer.progress;
    self.lastPlayTime = [[NSDate date] timeIntervalSince1970];
    [self.sliderView stopAnimating];
}

- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl {
    if (self.player.currentPlayerManager.isPlaying) {
        [self.player.currentPlayerManager pause];
        self.playBtn.hidden = NO;
        self.playBtn.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        [UIView animateWithDuration:0.2f delay:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.playBtn.transform = CGAffineTransformIdentity;
        } completion:nil];
    } else {
        [self.player.currentPlayerManager play];
        self.playBtn.hidden = YES;
    }
}

- (void)dealloc {
}
-(void)invalidateDisplayLink {
    [self.displayLink invalidate];
    self.displayLink = nil;
}
-(void)stopDisplayLink {
    self.displayLink.paused = YES;
}

-(void)startDisplayLink {
    self.displayLink.paused = NO;
}

/**
 When the network changed
 */
- (void)videoPlayer:(ZFPlayerController *)videoPlayer reachabilityChanged:(ZFReachabilityStatus)status{
    switch (status) {
        case ZFReachabilityStatusUnknown:
            [MBProgressHUD wj_showPlainText:@"未知网络" view:nil];
            break;
        case ZFReachabilityStatusNotReachable:
            [MBProgressHUD wj_showPlainText:@"无网络" view:nil];
            break;
        case ZFReachabilityStatusReachableViaWiFi:
            if([videoPlayer.currentPlayerManager isPlaying]){
                [self.sliderView stopAnimating];
            }else{
                [self.sliderView startAnimating];
            }
            break;
        case ZFReachabilityStatusReachableVia2G:
            [MBProgressHUD wj_showPlainText:@"当前网络是2G流量" view:nil];
            break;
        case ZFReachabilityStatusReachableVia3G:
            [MBProgressHUD wj_showPlainText:@"当前网络是3G流量" view:nil];
            break;
        case ZFReachabilityStatusReachableVia4G:
            [MBProgressHUD wj_showPlainText:@"当前网络是4G流量" view:nil];
            break;
    }
    self.status = status;
}

- (void)setPlayer:(ZFPlayerController *)player {
    _player = player;
}
- (void)showCoverViewWithUrl:(NSString *)coverUrl {
    self.player.currentPlayerManager.view.coverImageView.alpha = 0;
}

#pragma mark - getter

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.userInteractionEnabled = NO;
        [_playBtn setImage:[UIImage imageNamed:@"icon_play_pause"] forState:UIControlStateNormal];
    }
    return _playBtn;
}

- (ZFSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[ZFSliderView alloc] init];
        _sliderView.maximumTrackTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.2];
        _sliderView.minimumTrackTintColor = [UIColor whiteColor];
        _sliderView.bufferTrackTintColor  = [UIColor clearColor];
        _sliderView.sliderHeight = 1;
        _sliderView.delegate = self;
        _sliderView.sliderHeight = 20;
        _sliderView.isHideSliderBlock = NO;
    }
    return _sliderView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

// 滑块滑动开始
- (void)sliderTouchBegan:(float)value {
    self.sliderView.isdragging = YES;
    [self.player.currentPlayerManager pause];
}
// 滑块滑动中
- (void)sliderValueChanged:(float)value {
    NSLog(@"sliderValueChanged---%f",value);
    NSTimeInterval totalTime = self.player.currentPlayerManager.totalTime;
    [self.player.currentPlayerManager seekToTime:totalTime * value completionHandler:^(BOOL finished) {
        
    }];
}
// 滑块滑动结束
- (void)sliderTouchEnded:(float)value {
    self.sliderView.isdragging = NO;
    [self.player.currentPlayerManager play];
}

// 滑杆点击
- (void)sliderTapped:(float)value {
    
}

@end
