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

@interface MKDouYinControlView()
///
@property (assign,nonatomic) ZFReachabilityStatus status ;

@property (assign,nonatomic) NSInteger loadState;

@property(nonatomic,strong) NSMutableArray  *dataSource;

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
        ///添加 KVO 对进度监听
           [self.sliderView addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
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
    min_h = 1;
    self.sliderView.frame = CGRectMake(min_x, min_y, min_w, min_h);
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
/// 加载状态改变
- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    WeakSelf
    DLog(@"牛逼的瞬间%lu playState：%lu",(unsigned long)state,(unsigned long)videoPlayer.currentPlayerManager.playState);
    
    if([SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex == 0){
        
    }else{
//        NSLog(@"不在首页模块不播放");
        return;
    }
    self.loadState = state;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        switch (state) {
//            case ZFPlayerLoadStateUnknown:
//                [self.sliderView startAnimating];
//                break;
//            case ZFPlayerLoadStatePrepare:
//                [self.sliderView startAnimating];
//                break;
//            case ZFPlayerLoadStatePlayable:
//                if(videoPlayer.currentPlayerManager.isPlaying){
//                    [self.sliderView stopAnimating];
//                }
//                else
//                {
//                    [self.sliderView startAnimating];
//                }
//
//                break;
//            case ZFPlayerLoadStatePlaythroughOK:
//                [self.sliderView startAnimating];
//                break;
//            case ZFPlayerLoadStateStalled:
//                if(videoPlayer.currentPlayerManager.isPlaying){
//                    [self.sliderView stopAnimating];
//                }
//                else
//                {
//                    [self.sliderView startAnimating];
//                }
//                break;
//        }
//    });
    if(videoPlayer.currentPlayerManager.isPlaying){

        dispatch_async(dispatch_get_main_queue(), ^{
            switch (state) {
                case ZFPlayerLoadStateUnknown:
                    [self.sliderView startAnimating];
                    break;
                case ZFPlayerLoadStatePrepare:
                    [self.sliderView startAnimating];
                    break;
                case ZFPlayerLoadStatePlayable:
                    [self.sliderView stopAnimating];
                    break;
                case ZFPlayerLoadStatePlaythroughOK:
                    [self.sliderView startAnimating];
                    break;
                case ZFPlayerLoadStateStalled:
                    [self.sliderView stopAnimating];
                    break;
            }
        });
    }else{
//        NSLog(@"加载状态改变暂停");
        if(self.playBtn.isHidden) {
            [self.sliderView startAnimating];
        }
    }
//    if ((state == ZFPlayerLoadStateStalled || state == ZFPlayerLoadStatePrepare || state == ZFPlayerLoadStateUnknown) && ) {
//        [self.sliderView startAnimating];
//    } else {
//
//    }
    
}
#pragma mark - KVO 监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
//    DLog(@"监听进度条%@ == %@ == %@ == %@",keyPath,object,context,change);
//    NSString *progress = [NSString stringWithFormat:@"%@",change[@"new"]];
//    [self.dataSource addObject:progress];
//            __weak typeof (self) weakSelf = self;
//            [UIView animateWithDuration:0.01f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
////                weakSelf.sliderView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
////                [weakSelf.sliderView startAnimating];
//            } completion:^(BOOL finished) {
////                weakSelf.sliderView.hidden = YES;
//            }];
//        }
//    }else{
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
}

- (void)dealloc {
    [self.sliderView removeObserver:self forKeyPath:@"value"];
    self.sliderView = nil;
}

/// When the player prepare to play the video.
- (void)videoPlayer:(ZFPlayerController *)videoPlayer prepareToPlay:(NSURL *)assetURL{
    if([videoPlayer.currentPlayerManager isPlaying]){
        [self.sliderView stopAnimating];
    }else{
        [self.sliderView startAnimating];
    }
}

/// When th player playback state changed.
- (void)videoPlayer:(ZFPlayerController *)videoPlayer playStateChanged:(ZFPlayerPlaybackState)state{
    
    BOOL isload = true;
    // 加载状态
    
    switch (self.loadState) {
        case 0:// ZFPlayerLoadStateUnknown
        {
            [self.sliderView startAnimating];
            isload = NO;
//            weakSelf.playerLoadStateChangedBlock(@"NO");
            break;
        }

        case 1:// ZFPlayerLoadStatePrepare
        {
            [self.sliderView startAnimating];
            isload = NO;
//            weakSelf.playerLoadStateChangedBlock(@"NO");
            break;
        }

        case 2:// ZFPlayerLoadStatePlayable
        {
            [self.sliderView stopAnimating];
            isload = YES;
//            weakSelf.playerLoadStateChangedBlock(@"YES");
            break;
        }

        case 3:// ZFPlayerLoadStatePlaythroughOK
        {
            [self.sliderView startAnimating];
            isload = NO;
//            weakSelf.playerLoadStateChangedBlock(@"NO");
            break;
        }

        case 4:// ZFPlayerLoadStateStalled
        {
            [self.sliderView stopAnimating];
            isload = YES;
//            weakSelf.playerLoadStateChangedBlock(@"YES");
            break;
        }

    }
    WeakSelf
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"播放状态改变了 %lu",(unsigned long)state);
        weakSelf.playerLoadStateChangedBlock(@"NO");
        switch (state) {
            case ZFPlayerPlayStateUnknown:
                if([videoPlayer.currentPlayerManager isPlaying]){
                    if (isload == YES) {
                        [weakSelf.sliderView stopAnimating];
                        NSLog(@"1----1");
                        weakSelf.playerLoadStateChangedBlock(@"YES");
                    }
                    else
                    {
                        [weakSelf.sliderView startAnimating];
                    }
                    
                }else{
                    [weakSelf.sliderView startAnimating];
                }
                break;
            case ZFPlayerPlayStatePlaying:
                if([videoPlayer.currentPlayerManager isPlaying]){
                    if (isload == YES) {
                        [weakSelf.sliderView stopAnimating];
                        weakSelf.playerLoadStateChangedBlock(@"YES");
                    }
                    else
                    {
                        [weakSelf.sliderView startAnimating];
                    }
                }else{
                    [weakSelf.sliderView startAnimating];
                }
                break;
            case ZFPlayerPlayStatePaused:
                [weakSelf.sliderView stopAnimating];
                if (isload == YES) {
                    weakSelf.playerLoadStateChangedBlock(@"NO");
                }
//                else
//                {
//                    [weakSelf.sliderView startAnimating];
//                }
                break;
            case ZFPlayerPlayStatePlayFailed:
                [weakSelf.sliderView startAnimating];
                break;
            case ZFPlayerPlayStatePlayStopped:
                [weakSelf.sliderView startAnimating];
                break;
        }
    });
    
}
/**
 When the network changed
 */
- (void)videoPlayer:(ZFPlayerController *)videoPlayer reachabilityChanged:(ZFReachabilityStatus)status{
    switch (status) {
        case ZFReachabilityStatusUnknown:
            if([videoPlayer.currentPlayerManager isPlaying]){
                [self.sliderView stopAnimating];
            }else{
                [self.sliderView startAnimating];
            }
            [MBProgressHUD wj_showPlainText:@"未知网络" view:nil];
            break;
        case ZFReachabilityStatusNotReachable:
            [MBProgressHUD wj_showPlainText:@"无网络" view:nil];
            if([videoPlayer.currentPlayerManager isPlaying]){
                [self.sliderView stopAnimating];
            }else{
                [self.sliderView startAnimating];
            }
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
            if([videoPlayer.currentPlayerManager isPlaying]){
                [self.sliderView stopAnimating];
            }else{
                [self.sliderView startAnimating];
            }
            break;
        case ZFReachabilityStatusReachableVia3G:
            [MBProgressHUD wj_showPlainText:@"当前网络是3G流量" view:nil];
            if([videoPlayer.currentPlayerManager isPlaying]){
                [self.sliderView stopAnimating];
            }else{
                [self.sliderView startAnimating];
            }
            break;
        case ZFReachabilityStatusReachableVia4G:
            [MBProgressHUD wj_showPlainText:@"当前网络是4G流量" view:nil];
            if([videoPlayer.currentPlayerManager isPlaying]){
                [self.sliderView stopAnimating];
            }else{
                [self.sliderView startAnimating];
            }
            break;
    }
    self.status = status;
//    NSLog(@"当前网络状态%ld",(long)self.status);
}
/// 播放进度改变回调
- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    
    self.sliderView.value = videoPlayer.progress;
 
}

- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl {
    if (self.player.currentPlayerManager.isPlaying) {
        [self.player.currentPlayerManager pause];
        self.playBtn.hidden = NO;
        self.playerLoadStateChangedBlock(@"NO");
        [self.sliderView stopAnimating];
        self.playBtn.transform = CGAffineTransformMakeScale(1.5f, 1.5f);
        [UIView animateWithDuration:0.2f delay:0
                            options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.playBtn.transform = CGAffineTransformIdentity;
        } completion:nil];
        
    } else {
        [self.player.currentPlayerManager play];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKSingleTapNotification object:nil];
        self.playBtn.hidden = YES;
        self.playerLoadStateChangedBlock(@"YES");
    }
}
#pragma mark - 长按快进
//- (void)gestureLongPress:(ZFPlayerGestureControl *)gestureControl{
//    if (self.player.currentPlayerManager.isPlaying) {
//        [self.player.currentPlayerManager pause];
//        double time = self.player.currentTime + 3;
//        [self.player seekToTime:time completionHandler:^(BOOL finished) {
//            [self.player.currentPlayerManager play];
//        }];
//    }
//}
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

@end
