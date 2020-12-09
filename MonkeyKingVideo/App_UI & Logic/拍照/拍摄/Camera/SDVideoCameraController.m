//
//  SDVideoCameraController.m
//  FamilyClassroom
//
//  Created by 王巍栋 on 2020/1/13.
//  Copyright © 2020 Dong. All rights reserved.
//

#import "SDVideoCameraController.h"
#import "SDVideoPreviewViewController.h"
#import "SDVideoAlbumViewController.h"
#import "SDVideoCameraAuthoView.h"
#import "SDVideoCaptureManager.h"
#import "SDAudioPlayerManager.h"
#import "SDVideoLoadingView.h"
#import "SDVideoDataManager.h"
#import "SDVideoUtils.h"
#import "MKUploadingVC.h"

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SDVideoPreviewMusicView.h"
#import "SDVideoPreviewTagsView.h"
#import "SDVideoPreviewTextView.h"
#import "UIButton+EdgeInsets.h"
#import "SDVideoLoadingView.h"
#import "MKVideoController.h"
#import "UIView+Extension.h"
#import "SDVideoUtils.h"

@interface SDVideoCameraController ()<SDVideoMusicDelegate,SDVideoCameraMenuDelegate,SDVideoPreviewTextDelegate,SDVideoPreviewTagsDelegate>

@property(nonatomic,strong)SDVideoConfig *config;
@property(nonatomic,strong)UIView *videoView;
@property(nonatomic,strong)SDVideoCaptureManager *captureManager;
@property(nonatomic,strong)SDAudioPlayerManager *audioManager;

//@property(nonatomic,strong)SDVideoConfig *config;
@property(nonatomic,strong)AVPlayerItem *playItem;
@property(nonatomic,strong)AVPlayerItem *audioPlayItem;
@property(nonatomic,copy)NSArray <AVAsset *>*videoAssetArray;
@property(nonatomic,assign)CMTimeRange playTimeRange;

//@property(nonatomic,strong)UIImage *bgImage;
//@property(nonatomic,strong)UIImageView *mainVideoView;
//@property(nonatomic,strong)UIButton *returnButton;
//@property(nonatomic,strong)UIButton *nextButton;
//@property(nonatomic,strong)UIButton *musicButton;
//@property(nonatomic,strong)UIButton *textButton;
//@property(nonatomic,strong)UIButton *iconButton;
@property(nonatomic,strong)UIImage *thumb;
@property(nonatomic,strong)UIImageView *deleteTextImageView;

@property(nonatomic,strong)CALayer *verticalLineLayer;
@property(nonatomic,strong)CALayer *horizontalLineLayer;

@property(nonatomic,strong)SDVideoPreviewMusicView *musicView;
@property(nonatomic,strong)SDVideoPreviewTextView *textView;
@property(nonatomic,strong)SDVideoPreviewTagsView *tagsView;


@property(nonatomic,strong)AVPlayerLayer *videoLayer;
@property(nonatomic,strong)AVPlayer *audioPlayer;
@property(nonatomic,strong)AVPlayer *player;

@property(nonatomic,strong)NSMutableArray <NSDictionary *>*effectViewArray;
@property(nonatomic,strong)AVAssetImageGenerator *gen;


@end

@implementation SDVideoCameraController

- (instancetype)initWithCameraConfig:(SDVideoConfig *)config {
    
    if (self = [super init]) {
        self.config = config;
        [config configDataSelfCheckAction];
        [SDVideoDataManager defaultManager].config = config;
        [SDVideoDataManager defaultManager].cameraState = VideoCameraStateIdle;
        [[SDVideoDataManager defaultManager] addObserver:self forKeyPath:@"cameraState" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.videoView];
    [self.view addSubview:self.menuView];
   
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
   
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoItemPlayFinishAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [self.player play];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if ([self.menuView isOpenAllDeviceAuthoStateAction]) {
        [self captureManager];
    }
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController setNavigationBarHidden:YES];
 
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
  
}

- (void)closeButtonAction {
    if ([SDVideoDataManager defaultManager].videoNumber != 0) {
//        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//        UIAlertAction *reloadAction = [UIAlertAction actionWithTitle:@"重新拍摄" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            [[SDVideoDataManager defaultManager] deleteAllVideoModel];
//            self.menuView.progressView.hidden = YES;
//            self.menuView.progressCurrentView.hidden = YES;
//            self.menuView.timeLabel.hidden = YES;
//            self.menuView.lineLabel.hidden = YES;
////            self.menuView.exampleSegmentView.hidden = NO;
//            self.menuView.slideView.hidden = NO;
//            self.menuView.indexView.hidden = NO;
//        }];
//        UIAlertAction *exitAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            [self.navigationController popToRootViewControllerAnimated:YES];
//
//        }];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
//        [alertViewController addAction:reloadAction];
//        [alertViewController addAction:exitAction];
//        [alertViewController addAction:cancelAction];
//        alertViewController.view.tintColor = [UIColor colorWithHexString:@"c4c1c1"];
        
        SPAlertController *alert = [SPAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:SPAlertControllerStyleActionSheet];

         SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"重新拍摄" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
             
                    [[SDVideoDataManager defaultManager] deleteAllVideoModel];
                    self.menuView.progressView.hidden = YES;
                    self.menuView.progressCurrentView.hidden = YES;
                    self.menuView.timeLabel.hidden = YES;
                    self.menuView.lineLabel.hidden = YES;
        //            self.menuView.exampleSegmentView.hidden = NO;
                    self.menuView.slideView.hidden = NO;
                    self.menuView.indexView.hidden = NO;
         }];
        
         SPAlertAction *action2 = [SPAlertAction actionWithTitle:@"退出" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
             [self.navigationController popToRootViewControllerAnimated:YES];
         }];
         SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {}];

        action1.titleFont = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        action2.titleFont = [UIFont systemFontOfSize: 18];
        action3.titleFont = [UIFont systemFontOfSize: 18];
         [alert addAction:action1];
         [alert addAction:action2];
         [alert addAction:action3];
         [self presentViewController: alert animated:YES completion:^{}];
        
        
//        UIView *firstSubview = alert.view.subviews.firstObject;
//        UIView *alertContentView = firstSubview.subviews.firstObject;
//
//        for (UIView *subSubView in alertContentView.subviews) {
//               subSubView.backgroundColor = [UIColor colorWithHexString:@"1f242f"]; // Here you change background
//        }
//        [self presentViewController:alert animated:YES completion:nil];
       
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 懒加载

-(UIImage *)getImage:(NSString *)videoURL {
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [self.gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    self.thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return self.thumb;
}

- (UIView *)videoView {
    
    if (_videoView == nil) {
        _videoView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _videoView.backgroundColor = [UIColor blackColor];
        _videoView.layer.masksToBounds = YES;
    }
    return _videoView;
}

- (SDVideoCameraMenuView *)menuView {
    
    if (_menuView == nil) {
        _menuView = [[SDVideoCameraMenuView alloc] initWithFrame:[UIScreen mainScreen].bounds cameraConfig:self.config];
        _menuView.superViewController = self;
        _menuView.delegate = self;
        [_menuView.closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _menuView;
}

- (SDVideoCaptureManager *)captureManager {
    
    if (_captureManager == nil) {
        _captureManager = [[SDVideoCaptureManager alloc] initWithVideoView:self.videoView config:self.config];
    }
    return _captureManager;
}

- (SDAudioPlayerManager *)audioManager {
    
    if (_audioManager == nil) {
        _audioManager = [[SDAudioPlayerManager alloc] initWithConfig:self.config];
    }
    return _audioManager;
}

#pragma mark - 控制层回调方法

- (void)userFinishMergeVideoAction {
    
//    [SDVideoLoadingView showLoadingAction];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableArray *videoAssetArray = [NSMutableArray arrayWithCapacity:16];
        for (SDVideoDataModel *dataModel in [SDVideoDataManager defaultManager].videoDataArray) {
            AVAsset *asset = [AVAsset assetWithURL:dataModel.pathURL];
            [videoAssetArray addObject:asset];
        }

        AVPlayerItem *playItem = [SDVideoUtils mergeMediaPlayerItemActionWithAssetArray:videoAssetArray
                                                                              timeRange:kCMTimeRangeZero
                                                                           bgAudioAsset:nil
                                                                         originalVolume:1
                                                                          bgAudioVolume:0];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [SDVideoLoadingView dismissLoadingAction];
//            SDVideoPreviewViewController *previewViewController = [[SDVideoPreviewViewController alloc] initWithCameraConfig:self.config playItem:playItem videoAssetArray:videoAssetArray playTimeRange:kCMTimeRangeZero];
                   self.playItem = playItem;
                   self.playTimeRange = kCMTimeRangeZero;
                   self.videoAssetArray = videoAssetArray;
                   self.effectViewArray = [NSMutableArray arrayWithCapacity:16];
            
            [WHToast showMessage:@"处理中"
                        duration:1
                   finishHandler:nil];
            
//            [self.navigationController pushViewController:previewViewController animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self popViewControllerAction];
            });
        });
        
    });
}



- (void)deleteLaseVideoDataAction {

    [self.audioManager seekToTime:CMTimeMake([SDVideoDataManager defaultManager].totalVideoTime, 1.0)];
}

- (void)userClickOutMenuButtonWithButtonType:(VideoMenuType)menuType {
    
    switch (menuType) {
        case VideoMenuTypesTurnOver:{
            [self.captureManager exchangeCameraInputAction];
            
            break;
        }
        case VideoMenuTypesFlashlight:{
            [self.captureManager openCameraFlashLight];
      
            break;
        }
        default:
            break;
    }
}

- (void)userChangeVideoZoomFactorWithScale:(CGFloat)scale orientation:(TouchMoveOrientation)orientation {

    [self.captureManager setVideoZoomFactorWithScale:scale orientation:orientation];
}

- (void)userEndChangeVideoZoomFactor {
    
    [self.captureManager reloadCurrentVideoZoomFactorAction];
}

- (void)userClickAlbumAction {
    
    SDVideoAlbumViewController *albumViewController = [[SDVideoAlbumViewController alloc] initWithCameraConfig:self.config];
    UINavigationController *albumNavigationController = [[UINavigationController alloc] initWithRootViewController:albumViewController];
    albumNavigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.navigationController presentViewController:albumNavigationController animated:YES completion:nil];
}

- (void)userOpenAllDerviceAuthoAction {
    
    [self captureManager];
}

#pragma mark - 监听方法

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if ([keyPath isEqualToString:@"cameraState"]) {
        switch ([SDVideoDataManager defaultManager].cameraState) {
            case VideoCameraStateIdle:{
                break;
            }
            case VideoCameraStateInProgress:{
                [self.audioManager play];
                [self.captureManager startVideoRecordingAction];
                break;
            }
            case VideoCameraStatePause:{
                [self.audioManager pause];
                [self.captureManager pauseOrStopVideoRecordingAction];//停止录制
                break;
            }
            case VideoCameraStateStop: {
                [self.audioManager pause];
                [self.captureManager pauseOrStopVideoRecordingAction];//停止录制
                break;
            }
        }
    }
}

#pragma mark - 系统方法

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)popViewControllerAction {
    
    AVAsset *bgAudioAsset = nil;
    CGFloat bgAudioVolume = 0;
    if (_audioPlayItem != nil) {
        bgAudioAsset = _audioPlayItem.asset;
        bgAudioVolume = _audioPlayer.volume;
    }
    
    NSMutableArray *layerArray = [NSMutableArray arrayWithCapacity:16];
    
//    [SDVideoLoadingView showLoadingAction];
    // 缩放倍数
    CGFloat widthScale = SDVideoSize.width/self.view.width;
    CGFloat heightScale = SDVideoSize.height/self.view.height;

    // 根据视频尺寸需要进行对应的缩放.以宽度为基准.
    for (NSDictionary *dictionary in self.effectViewArray) {
        UIView *effectView = dictionary[@"view"];
        NSData *viewData = [NSKeyedArchiver archivedDataWithRootObject:effectView];
        UIView *effectCopyView = [NSKeyedUnarchiver unarchiveObjectWithData:viewData];
        effectCopyView.layer.affineTransform = CGAffineTransformMakeScale(widthScale, widthScale);
        effectCopyView.layer.position = CGPointMake(effectCopyView.centerX * widthScale, effectCopyView.centerY *heightScale);
        [layerArray addObject:effectCopyView.layer];
    }
    
    NSString *mergeVideoPathString = [SDVideoUtils mergeMediaActionWithAssetArray:self.videoAssetArray
                                                                    bgAudioAsset:bgAudioAsset
                                                                       timeRange:self.playTimeRange
                                                                  originalVolume:self.player.volume
                                                                   bgAudioVolume:bgAudioVolume
                                                                      layerArray:layerArray
                                                                    mergeFilePath:[SDVideoUtils getSandboxFilePathWithPathType:self.config.mergeFilePathType] mergeFileName:self.config.mergeFileName];


    if (self.config.returnBlock != nil) {
        self.config.returnBlock(mergeVideoPathString);
    }
    if (mergeVideoPathString != nil) {
        [FileFolderHandleTool createAlbumFolder:HDAppDisplayName
                                                                path:mergeVideoPathString];//存系统相册
    }
   
    NSDictionary *userInfo = @{@"vedioUrl":mergeVideoPathString,@"photo":[SDVideoCameraController mh_getVideoTempImageFromVideo:[NSURL fileURLWithPath:mergeVideoPathString] withTime:0.02]};
    [[NSNotificationCenter defaultCenter] postNotificationName:MKPhotoPushNotification object:nil userInfo:userInfo];
      [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载
#pragma mark - 获取视频的缩略图方法
+ (UIImage *)mh_getVideoTempImageFromVideo:(NSURL *)videoUrl withTime:(CGFloat)theTime
{
    AVURLAsset * asset = [AVURLAsset URLAssetWithURL:videoUrl options:nil];
    CGFloat timescale = asset.duration.timescale;
    UIImage *shotImage;
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CGFloat width = [UIScreen mainScreen].scale * 100;
    CGFloat height = width * [UIScreen mainScreen].bounds.size.height / [UIScreen mainScreen].bounds.size.width;
    gen.maximumSize =  CGSizeMake(width, height);
    
    CMTime time = CMTimeMakeWithSeconds(theTime, timescale);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    shotImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return shotImage;
}
//- (UIButton *)returnButton {
//
//    if (_returnButton == nil) {
//        _returnButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 40, 40)];
//        [_returnButton setImage:[UIImage imageNamed:@"sd_commom_return_icon"] forState:UIControlStateNormal];
//        [_returnButton addTarget:self action:@selector(returnViewControllerAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _returnButton;
//}
//
//- (UIButton *)nextButton {
//
//    if (_nextButton == nil) {
//        _nextButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.width - 15 - 60, self.view.height - 15 - 30, 60, 30)];
//        _nextButton.backgroundColor = [UIColor hexStringToColor:self.config.tintColor];
//        _nextButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        _nextButton.layer.cornerRadius = 5.0f;
//        _nextButton.layer.masksToBounds = YES;
//        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
//        [_nextButton addTarget:self action:@selector(popViewControllerAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _nextButton;
//}

//- (UIImageView *)mainVideoView {
//
//    if (_mainVideoView == nil) {
//        _mainVideoView = [[UIImageView alloc] initWithImage:self.bgImage];
//        _mainVideoView.userInteractionEnabled = YES;
//        _mainVideoView.frame = self.view.bounds;
//        [_mainVideoView.layer addSublayer:self.videoLayer];
//        [_mainVideoView.layer addSublayer:self.verticalLineLayer];
//        [_mainVideoView.layer addSublayer:self.horizontalLineLayer];
//        self.verticalLineLayer.hidden = YES;
//        self.horizontalLineLayer.hidden = YES;
//    }
//    return _mainVideoView;
//}

//- (UIImageView *)deleteTextImageView {
//
//    if (_deleteTextImageView == nil) {
//        _deleteTextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainVideoView.width/2.0 - 30, StatusHeight, 60, 60)];
//        _deleteTextImageView.image = [UIImage imageNamed:@"sd_preview_text_delete_icon"];
//        _deleteTextImageView.contentMode = UIViewContentModeCenter;
//        _deleteTextImageView.layer.cornerRadius = 30.0f;
//        _deleteTextImageView.layer.masksToBounds = YES;
//    }
//    return _deleteTextImageView;
//}

- (CALayer *)verticalLineLayer {
    
    if (_verticalLineLayer == nil) {
        _verticalLineLayer = [[CALayer alloc] init];
        _verticalLineLayer.frame = CGRectMake(MAINSCREEN_WIDTH/2.0, 0, 1.0, MAINSCREEN_HEIGHT);
        _verticalLineLayer.backgroundColor = [UIColor hexStringToColor:@"00f5ff"].CGColor;
    }
    return _verticalLineLayer;
}

- (CALayer *)horizontalLineLayer {
    
    if (_horizontalLineLayer == nil) {
        _horizontalLineLayer = [[CALayer alloc] init];
        _horizontalLineLayer.frame = CGRectMake(0, MAINSCREEN_HEIGHT/2.0, MAINSCREEN_WIDTH, 1.0);
        _horizontalLineLayer.backgroundColor = [UIColor hexStringToColor:@"00f5ff"].CGColor;
    }
    return _horizontalLineLayer;
}

//- (UIButton *)musicButton {
//
//    if (_musicButton == nil) {
//        _musicButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 60, 60)];
//        _musicButton.centerY = self.nextButton.centerY;
//        _musicButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
//        _musicButton.adjustsImageWhenHighlighted = NO;
//        [_musicButton setTitle:@"配乐" forState:UIControlStateNormal];
//        [_musicButton setTitleColor:[UIColor hexStringToColor:@"ffffff"] forState:UIControlStateNormal];
//        [_musicButton setImage:[UIImage imageNamed:@"sd_preview_music_normal_icon"] forState:UIControlStateNormal];
//        [_musicButton setImage:[UIImage imageNamed:@"sd_preview_music_finish_icon"] forState:UIControlStateSelected];
//        [_musicButton addTarget:self action:@selector(showMusicViewAction) forControlEvents:UIControlEventTouchUpInside];
//        [_musicButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:5];
//    }
//    return _musicButton;
//}

//- (UIButton *)textButton {
//
//    if (_textButton == nil) {
//        _textButton = [[UIButton alloc] initWithFrame:CGRectMake(self.musicButton.right, 0, 60, 60)];
//        _textButton.centerY = self.nextButton.centerY;
//        _textButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
//        _textButton.adjustsImageWhenHighlighted = NO;
//        [_textButton setTitle:@"文字" forState:UIControlStateNormal];
//        [_textButton setTitleColor:[UIColor hexStringToColor:@"ffffff"] forState:UIControlStateNormal];
//        [_textButton setImage:[UIImage imageNamed:@"sd_preview_text_icon"] forState:UIControlStateNormal];
//        [_textButton addTarget:self action:@selector(showTextViewAction) forControlEvents:UIControlEventTouchUpInside];
//        [_textButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:5];
//    }
//    return _textButton;
//}

//- (UIButton *)iconButton {
//
//    if (_iconButton == nil) {
//        _iconButton = [[UIButton alloc] initWithFrame:CGRectMake(self.textButton.right, 0, 60, 60)];
//        _iconButton.centerY = self.nextButton.centerY;
//        _iconButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
//        _iconButton.adjustsImageWhenHighlighted = NO;
//        [_iconButton setTitle:@"贴纸" forState:UIControlStateNormal];
//        [_iconButton setTitleColor:[UIColor hexStringToColor:@"ffffff"] forState:UIControlStateNormal];
//        [_iconButton setImage:[UIImage imageNamed:@"sd_preview_image_icon"] forState:UIControlStateNormal];
//        [_iconButton addTarget:self action:@selector(showTagsViewAction) forControlEvents:UIControlEventTouchUpInside];
//        [_iconButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:5];
//    }
//    return _iconButton;
//}

- (SDVideoPreviewMusicView *)musicView {
    
    if (_musicView == nil) {
        _musicView = [[SDVideoPreviewMusicView alloc] initWithFrame:[UIScreen mainScreen].bounds config:self.config superViewController:self];
        _musicView.delegate = self;
    }
    return _musicView;
}

- (SDVideoPreviewTextView *)textView {
    
    if (_textView == nil) {
        _textView = [[SDVideoPreviewTextView alloc] initWithFrame:[UIScreen mainScreen].bounds config:self.config];
        _textView.delegate = self;
    }
    return _textView;
}

- (SDVideoPreviewTagsView *)tagsView {
    
    if (_tagsView == nil) {
        _tagsView = [[SDVideoPreviewTagsView alloc] initWithFrame:[UIScreen mainScreen].bounds config:self.config];
        _tagsView.delegate = self;
    }
    return _tagsView;
}

- (AVPlayerLayer *)videoLayer {
    
    if (_videoLayer == nil) {
        _videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _videoLayer.frame = self.view.bounds;
    }
    return _videoLayer;
}

- (AVPlayer *)player {
    
    if (_player == nil) {
        _player = [AVPlayer playerWithPlayerItem:self.playItem];
        _player.currentItem.forwardPlaybackEndTime = self.player.currentItem.duration;
    }
    return _player;
}

#pragma mark - 相关事件

- (void)returnViewControllerAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showMusicViewAction {
    
    [self.view addSubview:self.musicView];
    [self.musicView showViewAction];
}

- (void)showTextViewAction {
    
    [self.view addSubview:self.textView];
    [self.textView showViewAction];
}

- (void)showTagsViewAction {
    
    [self.view addSubview:self.tagsView];
    [self.tagsView showViewAction];
}

#pragma mark - 回调事件

- (void)userSelectbackgroundMusicWithDataModel:(SDVideoMusicModel *)dataModel musicVolume:(CGFloat)musicVolume {
    
    if (dataModel == nil) {
        [_audioPlayer pause];
        _audioPlayItem = nil;
    } else {
        self.audioPlayItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:dataModel.musicPathURL]];
        _audioPlayer = [[AVPlayer alloc] initWithPlayerItem:self.audioPlayItem];
        [_audioPlayer setVolume:musicVolume/100.0];
        [self reloadPlayVideoItemAction];
    }
}

- (void)userChangeOriginalVolume:(CGFloat)originalVolume musicVolume:(CGFloat)musicVolume {
    
    [self.player setVolume:originalVolume/100.0];
    [self.audioPlayer setVolume:musicVolume/100.0];
}

- (void)userFinishInputTextWithDataModel:(SDVideoPreviewEffectModel *)dataModel {
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    textLabel.backgroundColor = dataModel.backgroundColor;
    textLabel.textColor = dataModel.textColor;
    textLabel.userInteractionEnabled = YES;
    textLabel.font = dataModel.textFont;
    textLabel.layer.cornerRadius = 3.0f;
    textLabel.layer.masksToBounds = YES;
    textLabel.text = dataModel.text;
    textLabel.numberOfLines = 0;
    CGSize textSize = [textLabel sizeThatFits:CGSizeMake(self.view.width - 10 * 2 - 3 * 2, 0)];
    textSize = CGSizeMake(textSize.width + 3 * 2, textSize.height  + 3 * 2);
    if (textSize.height > self.view.height - 10 * 2 - 3 * 2) {
        textSize = CGSizeMake(textSize.width, self.view.height - 10 * 2);
    }
    textLabel.size = textSize;
    textLabel.center = CGPointMake(self.view.width/2.0, self.view.height/2.0);
    [textLabel addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(effectViewMoveAction:)]];
//    [self.mainVideoView addSubview:textLabel];
    [self.effectViewArray addObject:@{@"data":dataModel,@"view":textLabel}];
}

- (void)userFinishSelectTagWithDataModel:(SDVideoPreviewEffectModel *)dataModel {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:dataModel.image];
    imageView.size = dataModel.contentSize;
    imageView.center = CGPointMake(self.view.width/2.0, self.view.height/2.0);
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(effectViewMoveAction:)]];
//    [self.mainVideoView addSubview:imageView];
    [self.effectViewArray addObject:@{@"data":dataModel,@"view":imageView}];
}

- (void)effectViewMoveAction:(UIPanGestureRecognizer *)panGestureRecognizer {
    
//    CGPoint panPoint = [panGestureRecognizer locationInView:self.mainVideoView];
//
//    switch (panGestureRecognizer.state) {
//        case UIGestureRecognizerStateBegan:{
////            self.deleteTextImageView.backgroundColor = [UIColor clearColor];
////            [self.mainVideoView addSubview:self.deleteTextImageView];
//            [UIView animateWithDuration:0.1 animations:^{
//                panGestureRecognizer.view.center = [self loadTextButtonCenterWithDragPoint:panPoint];
//            }];
//            break;
//        }
//        case UIGestureRecognizerStateChanged:{
//            panGestureRecognizer.view.center = [self loadTextButtonCenterWithDragPoint:panPoint];
//            break;
//        }
//        case UIGestureRecognizerStateEnded:{
//            if (CGRectContainsPoint(_deleteTextImageView.frame,panGestureRecognizer.view.center)) {
//                [panGestureRecognizer.view removeFromSuperview];
//                for (NSDictionary *effectDictionary in self.effectViewArray) {
//                    if ([effectDictionary[@"view"] isEqual:panGestureRecognizer.view]) {
//                        [self.effectViewArray removeObject:effectDictionary];
//                        break;
//                    }
//                }
//            }
//            [_deleteTextImageView removeFromSuperview];
//            self.verticalLineLayer.hidden = YES;
//            self.horizontalLineLayer.hidden = YES;
//            break;
//        }
//        default:
//            break;
//    }
}

- (CGPoint)loadTextButtonCenterWithDragPoint:(CGPoint)dragPoint {
    
    CGPoint returnPoint = dragPoint;
//    if (returnPoint.x >= self.mainVideoView.width/2.0 - 10.0 &&
//        returnPoint.x <= self.mainVideoView.width/2.0 + 10.0) {
//        returnPoint = CGPointMake(self.mainVideoView.width/2.0, returnPoint.y);
//        [self loadLineLayer:self.verticalLineLayer hidden:NO];
//    } else {
//        [self loadLineLayer:self.verticalLineLayer hidden:YES];
//    }
//    if (returnPoint.y >= self.mainVideoView.height/2.0 - 10.0 &&
//        returnPoint.y <= self.mainVideoView.height/2.0 + 10.0) {
//        returnPoint = CGPointMake(returnPoint.x, self.mainVideoView.height/2.0);
//        [self loadLineLayer:self.horizontalLineLayer hidden:NO];
//    } else {
//        [self loadLineLayer:self.horizontalLineLayer hidden:YES];
//    }
    
    if (CGRectContainsPoint(_deleteTextImageView.frame,returnPoint)) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        _deleteTextImageView.backgroundColor = [UIColor hexStringToColor:self.config.tintColor alpha:0.8];
    } else {
        _deleteTextImageView.backgroundColor = [UIColor clearColor];
    }
    
    return returnPoint;
}

- (void)loadLineLayer:(CALayer *)lineLayer hidden:(BOOL)hidden {
    
    if (hidden == NO && lineLayer.hidden == YES) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    lineLayer.hidden = hidden;
}

#pragma mark - 视频播放完成通知

- (void)videoItemPlayFinishAction:(NSNotification *)notification {
    
    // 把当前播放完成的视频重新添加到队列中.
    AVPlayerItem *playItem = notification.object;
    if ([playItem isEqual:self.playItem]) {
        [self reloadPlayVideoItemAction];
    }
}

- (void)reloadPlayVideoItemAction {
    
    [self.player pause];
    self.player.currentItem.forwardPlaybackEndTime = self.player.currentItem.duration;
    [self.player.currentItem seekToTime:kCMTimeZero toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    if (self.audioPlayItem != nil) {
        [self.audioPlayer pause];
        [self.audioPlayer.currentItem seekToTime:kCMTimeZero toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
        [self.audioPlayer play];
    }
    [self.player play];
}

#pragma mark - 系统方法
- (void)dealloc {
      [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[SDVideoDataManager defaultManager] removeObserver:self forKeyPath:@"cameraState"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
