//
//  SDVideoCameraMenuView.m
//  FamilyClassroom
//
//  Created by 王巍栋 on 2020/1/13.
//  Copyright © 2020 Dong. All rights reserved.
//

#import "SDVideoCameraMenuView.h"
#import "SDVideoCameraPlayButton.h"
#import "SDVideoCameraAuthoView.h"
#import "SDVideoCaptureManager.h"
#import "UIButton+EdgeInsets.h"
#import "SDVideoDataManager.h"
#import <Photos/Photos.h>
#import "MKActionView.h"


@interface SDVideoCameraMenuView()<CAAnimationDelegate,SDVideoCameraAuthoDelegate,MKActionViewDelegate,YQNumberSlideViewDelegate>

@property(nonatomic,strong)SDVideoConfig *config;

@property(nonatomic,strong)SDVideoCameraPlayButton *playButton;

@property(nonatomic,strong)UIButton *playBigButton;
@property(nonatomic,strong)NSMutableArray <CALayer *>*endLineArray;
@property(nonatomic,strong)NSMutableArray <UIButton *>*menuButtonArray;

@property(nonatomic,strong)UILabel *countDownLabel;

@property(nonatomic,strong)SDVideoCameraAuthoView *authoView;

@property(nonatomic,assign) BOOL isEndVideoWithEndTouch;
@property(nonatomic,assign) CGPoint playButtonCenter;
@property(nonatomic,copy) NSDate *startTime;
@property(nonatomic,assign) BOOL isTouch;

@property(nonatomic,assign) BOOL isHiddenButton;


@end

@implementation SDVideoCameraMenuView

- (instancetype)initWithFrame:(CGRect)frame cameraConfig:(SDVideoConfig *)config {
    
    if (self = [super initWithFrame:frame]) {
        self.endLineArray = [NSMutableArray arrayWithCapacity:16];
        self.config = config;
        self.progressView.hidden = YES;
        self.progressCurrentView.hidden = YES;
        self.timeLabel.hidden = YES;
        self.indexView.hidden = NO;
        self.isTouch = YES;
        self.isHiddenButton = NO;
        [self addSubview:self.closeButton];
        [self addSubview:self.progressView];
        [self addSubview:self.playButton];
        [self.progressView addSubview:self.lineLabel];
        [self addSubview:self.timeLabel];
         [self addSubview:self.playBigButton];
        [self loadMenuButtonsAction];
        [self loadVideoDataObserverAction];
        [self mkMasonry];
    }
    return self;
}

#pragma mark - 懒加载
- (void)mkMasonry {
    
    [self.playBigButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(110*MAINSCREEN_WIDTH/375);
        make.height.mas_equalTo(110);
        make.bottom.equalTo(self.slideView.mas_top).offset(-5);
    }];
    @weakify(self)
    [[self.playBigButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        UIButton *btn = (UIButton *)x;
        btn.selected = !btn.selected;
        if (btn.selected) {
            self.progressView.hidden = NO;
            self.progressCurrentView.hidden = NO;
            self.timeLabel.hidden = NO;
            self.lineLabel.hidden = NO;
            self.indexView.hidden = YES;
            self.isTouch = YES;
            [SDVideoDataManager defaultManager].cameraState = VideoCameraStateInProgress;
            self.playButton.buttonState = PlayButtonStateTouch;
            //            self.exampleSegmentView.hidden = YES;
            self.slideView.hidden = YES;
            self.deleteVideoButton.hidden = YES;
            self.finishButton.hidden = YES;
        } else {
            self.isTouch = NO;
            self.deleteVideoButton.hidden = NO;
            self.finishButton.hidden = NO;
            [SDVideoDataManager defaultManager].cameraState = VideoCameraStatePause;
            self.playButton.buttonState = PlayButtonStateNomal;

            [WHToast showMessage:@"暂停录制"
                        duration:1
                   finishHandler:nil];
            
        }
    }];
    [self.slideView next];
}
- (void)loadVideoDataObserverAction {
    
    // 添加监听
    [[SDVideoDataManager defaultManager] addObserver:self forKeyPath:@"cameraState" options:NSKeyValueObservingOptionNew context:nil];
    [[SDVideoDataManager defaultManager] addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
    [[SDVideoDataManager defaultManager] addObserver:self forKeyPath:@"videoNumber" options:NSKeyValueObservingOptionNew context:nil];
   self.mkPlayerTimeType = MKPlayerTimeType_B;
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.centerX.mas_equalTo(self);
           make.left.mas_equalTo(self.progressView.width*0.17-8);
           make.bottom.equalTo(self.progressView.mas_top).offset(-1);
        }];
    

}

- (void)YQSlideViewDidChangeIndex:(int)count
{

    if (count == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MKVideoTimeNotification object:@"拍摄1分钟"];
            self.mkPlayerTimeType = MKPlayerTimeType_A;
            self.lineLabel.frame = CGRectMake(self.progressView.width*0.5-5, 0, 8, 8);
         
             [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.centerX.mas_equalTo(self);
                       make.bottom.equalTo(self.progressView.mas_top).offset(-1);
                    }];
    }else if (count == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MKVideoTimeNotification object:@"拍摄3分钟"];
              self.mkPlayerTimeType = MKPlayerTimeType_B;
              self.lineLabel.frame = CGRectMake(self.progressView.width*0.17-5, 0, 8, 8);
               [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.progressView.width*0.17-8);
                    make.bottom.equalTo(self.progressView.mas_top).offset(-1);
              }];
    }
}

- (void)YQSlideViewDidTouchIndex:(int)count
{
    [self.slideView scrollTo:count];
}

- (SDVideoCameraAuthoView *)authoView {
    
    if (_authoView == nil) {
        _authoView = [[SDVideoCameraAuthoView alloc] initWithFrame:self.bounds];
        _authoView.delegate = self;
        [_authoView testAuthoStateAction];
    }
    return _authoView;
}

- (UIView *)progressView {
    
    if (_progressView == nil) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, MAINSCREEN_HEIGHT -  MenuProgressTopDistance, MAINSCREEN_WIDTH, 8)];
        _progressView.backgroundColor = [UIColor hexStringToColor:@"#d8d8d8" alpha:0.5];
        _progressView.layer.cornerRadius = 3.0f;
        _progressView.layer.masksToBounds = YES;
        [_progressView addSubview:self.progressCurrentView];
    }
    return _progressView;
}

- (UIView *)progressCurrentView {
    
    if (_progressCurrentView == nil) {
        _progressCurrentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.progressView.height)];
        _progressCurrentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(MAINSCREEN_WIDTH, 30)]];
    }
    return _progressCurrentView;
}

- (UIButton *)closeButton {
    
    if (_closeButton == nil) {
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(MenuProgressLeftDistance * 2, MenuViewVerticalDistance+20, 30, 30)];
        [_closeButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    }
    return _closeButton;
}


- (SDVideoCameraPlayButton *)playButton {
    if (_playButton == nil) {
        _playButton = [[SDVideoCameraPlayButton alloc] initWithFrame:CGRectMake(self.width/2.0 - 40, MAINSCREEN_HEIGHT - self.progressView.height*2 - 69*2-25, 76, 76) config:self.config];
        [_playButton addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playButtonTapAction)]];
    }
    return _playButton;
}

- (UIButton *)deleteVideoButton {
    
    if (_deleteVideoButton == nil) {
        _deleteVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        [_deleteVideoButton setImage:[UIImage imageNamed:@"sd_camera_menu_delete_icon"] forState:UIControlStateNormal];
        _deleteVideoButton.contentMode = UIViewContentModeScaleAspectFit;
        CGFloat distance = (self.width - _playButton.right)/3.0;
        _deleteVideoButton.centerY = self.playButton.centerY;
        _deleteVideoButton.centerX = distance + self.playButton.right;
        [_deleteVideoButton addTarget:self action:@selector(deleteLastVideoAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteVideoButton;
}

- (UIButton *)finishButton {
    
    if (_finishButton == nil) {
        _finishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [_finishButton setImage:KIMG(@"invalidYes") forState:UIControlStateNormal];
        CGFloat distance = (self.width - _playButton.right)/3.0;
        _finishButton.tintColor = [UIColor hexStringToColor:self.config.tintColor];
        _finishButton.centerY = self.playButton.centerY;
        _finishButton.centerX = distance * 2 + self.playButton.right;
        _finishButton.selected = NO;
        [_finishButton addTarget:self action:@selector(finishVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishButton;
}

- (UILabel *)countDownLabel {
    
    if (_countDownLabel == nil) {
        _countDownLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _countDownLabel.font = [UIFont systemFontOfSize:150 weight:UIFontWeightBold];
        _countDownLabel.textAlignment = NSTextAlignmentCenter;
        _countDownLabel.textColor = [UIColor hexStringToColor:@"ffffff"];
        _countDownLabel.text = @"3";
    }
    return _countDownLabel;
}

#pragma mark - 加载侧边按钮

- (void)loadMenuButtonsAction {
    
    self.menuButtonArray = [NSMutableArray arrayWithCapacity:1];
     CGFloat startY;
    if (isiPhoneX_series()) {
        startY = 20;
    } else {
         startY = 0;
    }
   
    CGFloat buttonWidth = 76;
    CGFloat buttonHeight = 76;
    [self.menuButtonArray removeAllObjects];
     [self.menuButtonArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (SDVideoMenuDataModel *menuDataModel in self.config.menuDataArray) {
        UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.tag = 1000000 + menuDataModel.menuType;
        menuButton.frame = CGRectMake(self.width - buttonWidth, startY, buttonWidth, buttonHeight);
        menuButton.adjustsImageWhenHighlighted = NO;
        menuButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [menuButton setImage:[UIImage imageNamed:menuDataModel.normalImageName] forState:UIControlStateNormal];
        [menuButton setImage:[UIImage imageNamed:menuDataModel.selectImageName] forState:UIControlStateSelected];
        [menuButton setTitle:menuDataModel.normalTitle forState:UIControlStateNormal];
        [menuButton setTitle:menuDataModel.selectTitle forState:UIControlStateSelected];
        [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [menuButton layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleImageTop imageTitlespace:5];
        [menuButton addTarget:self action:@selector(userClickOutButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuButton];
        [self.menuButtonArray addObject:menuButton];
        startY += buttonHeight;
        if (menuDataModel.menuType == VideoMenuTypesFlashlight) {
            menuButton.selected = !self.config.isOpenFlashlight;
            [self  userClickOutButton:menuButton];
        }
    }
    
}

#pragma mark - 按钮事件处理
- (void)playButtonTapAction {
    
    switch (_playButton.buttonState) {
        case PlayButtonStateNomal:{
         
            break;
        }
        case PlayButtonStateTouch:{
          
            
            break;
        }
        default:
            break;
    }
}

- (void)longPressClick:(UILongPressGestureRecognizer *)press {
 
    if(press.state == UIGestureRecognizerStateBegan){
        [SDVideoDataManager defaultManager].cameraState = VideoCameraStateInProgress;
        self.playButton.buttonState = PlayButtonStateMove;
        _playButtonCenter = self.playButton.center;
    } else if (press.state == UIGestureRecognizerStateEnded){
      
        [SDVideoDataManager defaultManager].cameraState = VideoCameraStatePause;
        [UIView animateWithDuration:0.2 animations:^{
            if (isiPhoneX_series()) {
                 self.playButton.frame = CGRectMake(self.width/2.0 - 40, self.height - 40 - 100, 76, 76);
            } else {
                 self.playButton.frame = CGRectMake(self.width/2.0 - 40, self.height - 100, 76, 76);
            }
           
        } completion:^(BOOL finished) {
            self.playButton.buttonState = PlayButtonStateNomal;
        }];
    } else {
        CGPoint point = [press locationInView:self];
        _playButton.center = point;
        self.playButtonCenter = point;
    }
}

- (void)setPlayButtonCenter:(CGPoint)playButtonCenter {
    
    if (sqrt(pow((_playButtonCenter.x - playButtonCenter.x), 2) + pow((_playButtonCenter.y - playButtonCenter.y), 2)) < 20) {
        return;
    }
    
    int orientation = _playButtonCenter.y - playButtonCenter.y > 0 ? TouchMoveOrientationUp : TouchMoveOrientationDown;
    _playButtonCenter = playButtonCenter;
    
    CGFloat maxY = self.height - 60 - 76/2.0;
    CGFloat minY =  76.0/2.0;
     
    float scale = 0;
    if (_playButtonCenter.y >= maxY) {
        scale = 0;
    } else if (_playButtonCenter.y <= minY) {
        scale = 1;
    } else {
        scale = (maxY - _playButtonCenter.y)/(maxY - minY);
    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(userChangeVideoZoomFactorWithScale:orientation:)]) {
        [_delegate userChangeVideoZoomFactorWithScale:scale orientation:orientation];
    }
}

- (void)userClickOutButton:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (self.isTouch == YES) {
//        [self.deleteVideoButton removeFromSuperview];
//           [self.finishButton removeFromSuperview];
        self.deleteVideoButton.hidden = YES;
        self.finishButton.hidden = YES;
    } else {
        self.deleteVideoButton.hidden = NO;
        self.finishButton.hidden = NO;
    }
   
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(userClickOutMenuButtonWithButtonType:)]) {
        [self.delegate userClickOutMenuButtonWithButtonType:sender.tag - 1000000];
    }
    if (sender.tag - 1000000 == VideoMenuTypesCountDown) {
        [self startCountDownAnimationAction];
    }
    
}

- (void)showAlbumAction {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    switch (status) {
        case PHAuthorizationStatusNotDetermined:{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(userClickAlbumAction)]) {
                            [self.delegate userClickAlbumAction];
                        }
                    });
                } else {
                    [self showSettingAlertControllerAction];
                }
            }];
            break;
        }
        case PHAuthorizationStatusRestricted: {
            UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"访问受限" message:@"手机相册访问受限" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertViewController addAction:cancelAction];
            [self.superViewController presentViewController:alertViewController animated:YES completion:nil];
            break;
        }
        case PHAuthorizationStatusDenied: {
            [self showSettingAlertControllerAction];
            break;
        }
        case PHAuthorizationStatusAuthorized: {
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(userClickAlbumAction)]) {
                [self.delegate userClickAlbumAction];
            }
            break;
        }
    }
}

- (void)showSettingAlertControllerAction {
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"提示" message:@"相机权限被禁用,请到设置中授予该应用允许访问相册权限" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertViewController addAction:cancelAction];
    [alertViewController addAction:okAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.superViewController presentViewController:alertViewController animated:YES completion:nil];
    });
}

- (void)startCountDownAnimationAction {
    
    [self addSubview:self.countDownLabel];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.delegate = self;
    animation.duration = 1.0;
    animation.fromValue = @(1.0);
    animation.toValue = @(1.5);
    animation.repeatCount = 1;
    [self.countDownLabel.layer addAnimation:animation forKey:@"scaleAnimation"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    int showNumber = [self.countDownLabel.text intValue] - 1;
    [self.countDownLabel.layer removeAnimationForKey:@"scaleAnimation"];
    if (showNumber > 0) {
        self.countDownLabel.text = [NSString stringWithFormat:@"%d",showNumber];
        [self startCountDownAnimationAction];
    } else {
        [self.countDownLabel removeFromSuperview];
        self.countDownLabel.text = @"3";
        [self playButtonTapAction];
    }
}

- (void)buttonClick:(NSInteger)index {

    if (index == 0) {
           [[NSNotificationCenter defaultCenter] postNotificationName:MKVideoTimeNotification object:@"拍摄1分钟"];
        self.mkPlayerTimeType = MKPlayerTimeType_A;
        self.lineLabel.frame = CGRectMake(self.progressView.width*0.5-5, 0, 8, 8);
     
         [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                   make.centerX.mas_equalTo(self);
                   make.bottom.equalTo(self.progressView.mas_top).offset(-1);
                }];
     
    } else if (index == 1) {
          [[NSNotificationCenter defaultCenter] postNotificationName:MKVideoTimeNotification object:@"拍摄3分钟"];
        self.mkPlayerTimeType = MKPlayerTimeType_B;
        self.lineLabel.frame = CGRectMake(self.progressView.width*0.17-5, 0, 8, 8);
         [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(self.progressView.width*0.17-8);
              make.bottom.equalTo(self.progressView.mas_top).offset(-1);
        }];
    } else if (index == 2) {
          [[NSNotificationCenter defaultCenter] postNotificationName:MKVideoTimeNotification object:@"拍摄5分钟"];
         self.mkPlayerTimeType = MKPlayerTimeType_C;
        self.lineLabel.frame = CGRectMake(self.progressView.width*0.1-5, 0, 8, 8);
        [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
               //           make.centerX.mas_equalTo(self);
                make.left.mas_equalTo(self.progressView.width*0.1-8);
                make.bottom.equalTo(self.progressView.mas_top).offset(-1);
        }];
    }
    
}

#pragma mark - 监听操作

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    // 相机状态发生改变
    if ([keyPath isEqualToString:@"cameraState"]) {
//        [_albumButton removeFromSuperview];
        switch ([SDVideoDataManager defaultManager].cameraState) {
            case VideoCameraStateIdle:{
//                [self addSubview:self.albumButton];
                break;
            }
            case VideoCameraStateInProgress:{
                
                [WHToast showMessage:@"开始录制"
                            duration:1
                       finishHandler:nil];
                
                [self removeSubViewViewAction];
             
                    
                break;
            }
            case VideoCameraStatePause:{
                
                if (isiPhoneX_series()) {
                    self.playButton.frame = CGRectMake(self.width/2.0 - 40, self.height - 176, 76, 76);
                } else {
                    self.playButton.frame = CGRectMake(self.width/2.0 - 40, self.height - 40 - 100, 76, 76);
                }
                self.playButton.buttonState = PlayButtonStateNomal;
                [self addSubViewViewAction];
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(userEndChangeVideoZoomFactor)]) {
                    [self.delegate userEndChangeVideoZoomFactor];
                }
                
                break;
            }
            case VideoCameraStateStop: {
             
                if (isiPhoneX_series()) {
                    self.playButton.frame = CGRectMake(self.width/2.0 - 40, self.height - 176, 76, 76);
                } else {
                    self.playButton.frame = CGRectMake(self.width/2.0 - 40, self.height - 40 - 100, 76, 76);
                }
                self.playButton.buttonState = PlayButtonStateNomal;
                [self addSubViewViewAction];
                break;
            }
        }
    }
    if ([keyPath isEqualToString:@"progress"]) {
       
        self.progressCurrentView.width = self.progressView.width * [SDVideoDataManager defaultManager].progress;
    }
    if ([keyPath isEqualToString:@"videoNumber"]) {
//        [self drawProgressEndLineAction];
        if ([SDVideoDataManager defaultManager].videoNumber != 0) {
            [self addSubview:self.deleteVideoButton];
            [self addSubview:self.finishButton];
        } else {
            [self.deleteVideoButton removeFromSuperview];
            [self.finishButton removeFromSuperview];
        }
    }
   
}

// 录制的时候需要移除的按钮
- (void)removeSubViewViewAction {
    
    [self.deleteVideoButton removeFromSuperview];
    [self.finishButton removeFromSuperview];
    [self.closeButton removeFromSuperview];

    
    [self.menuButtonArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
  
}

// 录制完成需要添加的按钮
- (void)addSubViewViewAction {
    
    [self addSubview:self.deleteVideoButton];
    [self addSubview:self.finishButton];
    [self addSubview:self.closeButton];
    for (UIButton *menuButton in self.menuButtonArray) {
        [self addSubview:menuButton];
    }
    self.finishButton.hidden = NO;
    self.deleteVideoButton.hidden = NO;
    self.isTouch = NO;
}

// 删除上一个视频
- (void)deleteLastVideoAction {
    
    [MKActionView show:self];

}

- (void)mkDeleteActionViewConfirm {
    [[SDVideoDataManager defaultManager] deleteAllVideoModel];
    self.progressView.hidden = YES;
    self.progressCurrentView.hidden = YES;
    self.timeLabel.hidden = YES;
    self.lineLabel.hidden = YES;
    //            self.menuView.exampleSegmentView.hidden = NO;
    self.slideView.hidden = NO;
    self.indexView.hidden = NO;
    self.playBigButton.selected = NO;
    SDVideoDataModel *dataModel = [SDVideoDataManager defaultManager].videoDataArray.lastObject;
    CGFloat currentWidth = dataModel.progress * self.progressView.width;
    
    [UIView animateWithDuration:0.01 animations:^{
        self.progressCurrentView.width = currentWidth;
    } completion:^(BOOL finished) {
        [SDVideoDataManager defaultManager].progress = dataModel.progress;
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(deleteLaseVideoDataAction)]) {
            [self.delegate deleteLaseVideoDataAction];
        }
    }];
    
}

// 完成录制
- (void)finishVideoAction:(UIButton *)action {
//    action.selected = !action.selected;
    
    switch (self.mkPlayerTimeType) {
        case  MKPlayerTimeType_A:
            {
                if (self.progressCurrentView.width >= MAINSCREEN_WIDTH/2) {
                       if (_delegate != nil && [_delegate respondsToSelector:@selector(userFinishMergeVideoAction)]) {
                              [_delegate userFinishMergeVideoAction];
                          }
                   } else {

                       [WHToast showMessage:@"拍摄时长不能少于30秒请重新录制"
                                   duration:1
                              finishHandler:nil];
                   }
            }
            break;
            case  MKPlayerTimeType_B:
                       {
                           if (self.progressCurrentView.width >= MAINSCREEN_WIDTH*0.17) {
                                  if (_delegate != nil && [_delegate respondsToSelector:@selector(userFinishMergeVideoAction)]) {
                                         [_delegate userFinishMergeVideoAction];
                                     }
                              } else {
                      
                                  [WHToast showMessage:@"拍摄时长不能少于30秒请重新录制"
                                              duration:1
                                         finishHandler:nil];
                              }
                       }
                    break;
            case  MKPlayerTimeType_C:
                       {
                           if (self.progressCurrentView.width >= MAINSCREEN_WIDTH*0.1) {
                                  if (_delegate != nil && [_delegate respondsToSelector:@selector(userFinishMergeVideoAction)]) {
                                         [_delegate userFinishMergeVideoAction];
                                     }
                              } else {
                                  
                                  [WHToast showMessage:@"拍摄时长不能少于30秒请重新录制"
                                              duration:1
                                         finishHandler:nil];
                              }
                       }
                break;
        default:
            break;
    }
   
}

// 绘制分段视频的结束线
- (void)drawProgressEndLineAction {
    
    [self.endLineArray makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self.endLineArray removeAllObjects];
    
    for (SDVideoDataModel *dataModel in [SDVideoDataManager defaultManager].videoDataArray) {
        CALayer *endLineLayer = [[CALayer alloc] init];
        endLineLayer.backgroundColor = [UIColor whiteColor].CGColor;
        endLineLayer.frame = CGRectMake(dataModel.progress * self.progressView.width, 0, 1.5, self.progressView.height);
        [self.progressView.layer addSublayer:endLineLayer];
        [self.endLineArray addObject:endLineLayer];
    }
    
}

// 检测设备状态
- (BOOL)isOpenAllDeviceAuthoStateAction {
    
    if ([SDVideoCaptureManager isOpenCameraAuthStatus] == AVAuthorizationStatusAuthorized &&
        [SDVideoCaptureManager isOpenMicrophoneAuthStatus] == AVAuthorizationStatusAuthorized) {
        return YES;
    } else {
        self.authoView.top = self.height;
        [self addSubview:self.authoView];
        [self addSubview:self.closeButton];
        [UIView animateWithDuration:0.3 animations:^{
            self.authoView.top = 0;
        }];
        return NO;
    }
}

- (void)userOpenAllDerviceAuthoAction {
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(userOpenAllDerviceAuthoAction)]) {
        [_delegate userOpenAllDerviceAuthoAction];
    }
}

- (YQNumberSlideView *)slideView {
    if (!_slideView) {
        _slideView = [[YQNumberSlideView alloc]initWithFrame:CGRectMake(30,
        30,
        [UIScreen mainScreen].bounds.size.width,
        55)];
//        self.slideView = [[YQNumberSlideView alloc]init];
            //设置一个背景色，以便查看范围
            _slideView.backgroundColor = kClearColor;
            //监控代理
            _slideView.delegate = self;
            [self addSubview:_slideView];
            [_slideView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self);
                    make.height.mas_equalTo(50);
                    if (isiPhoneX_series()) {
                         make.bottom.mas_equalTo(-55);
                    } else {
                         make.bottom.mas_equalTo(-32);
                    }
                    make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
             }];
             //设置数量
             [_slideView setLableCount:2];
             [_slideView setShowArray:@[@"拍1分钟",@"拍3分钟"]];
     
             //设置一下宽度
             _slideView.lableWidth = 80;
             //显示
             [_slideView show];
    }
    return _slideView;
}

-(UIView *)indexView{
    if (!_indexView) {
        _indexView = UIView.new;
        _indexView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(60, 30)]];

        [self addSubview:_indexView];
        [_indexView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 6));
            make.centerX.equalTo(self);
            make.top.equalTo(self.slideView.mas_bottom);
        }];
        [UIView cornerCutToCircleWithView:_indexView AndCornerRadius:6/2];
    }
    return _indexView;
}


- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.progressView.width*0.17-5, 0, 8, 8)];
        _lineLabel.backgroundColor = [UIColor whiteColor];
    }
    return _lineLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"30s";
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        [_timeLabel sizeToFit];
    
    }return _timeLabel;
}

- (UIButton *)playBigButton {
    if (!_playBigButton) {
        _playBigButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBigButton.backgroundColor = [UIColor clearColor];
    }
    return _playBigButton;;
}

- (void)dealloc {
    
    [[SDVideoDataManager defaultManager] removeObserver:self forKeyPath:@"videoNumber"];
    [[SDVideoDataManager defaultManager] removeObserver:self forKeyPath:@"cameraState"];
    [[SDVideoDataManager defaultManager] removeObserver:self forKeyPath:@"progress"];
}


@end
