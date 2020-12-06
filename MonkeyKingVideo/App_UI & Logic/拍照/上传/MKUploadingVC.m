//
//  MKUploadingVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "LGiOSBtn.h"
#import "AgreementView.h"
#import "MKWebViewVC.h"
#import "MKUploadingVC.h"
#import "MKUploadingVC+VM.h"
//导入系统框架
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "CustomerAVPlayer.h"

#import "SDVideoDataManager.h"


#define InputLimit 60

@interface MKUploadingVC ()
<UITextViewDelegate,DZDeleteButtonDelegate,CAAnimationDelegate,TZImagePickerControllerDelegate>

@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)SZTextView *textView;
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)LGiOSBtn *__block choosePicBtn;
@property(nonatomic,strong)UIButton *releaseBtn;
@property(nonatomic,assign)int inputLimit;
@property(nonatomic,strong)UIImage *imgData;
@property(nonatomic,assign)BOOL isClickMKUploadingVCView;
@property(nonatomic,strong)NSData *__block vedioData;
@property(nonatomic,strong)AVURLAsset *__block urlAsset;

@property(nonatomic,strong)AgreementView *agreementView;
@property(nonatomic,copy) NSString *urlVideo;

@property(nonatomic,strong) NSMutableArray *videoArray;

@property(nonatomic,strong)CustomerAVPlayer *customerAVPlayer;
@property(nonatomic,strong) UIButton  *actionBtn;
@property(nonatomic,copy) NSString  *videoString;
@property(nonatomic,strong)UIBarButtonItem *returnBtnItem;
@end

@implementation MKUploadingVC



#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.inputLimit = InputLimit;
    }return self;
}

- (void)loadView {
    [super loadView];
    
     [self.actionBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xF8F8F8);
    self.gk_navLineHidden = YES;
    self.backView.alpha = 1;
    self.textView.alpha = 1;
    self.choosePicBtn.alpha = 1;
    self.tipsLab.alpha = 1;
    self.agreementView.alpha = 1;
    self.gk_navBackgroundColor = UIColor.whiteColor;
    [IQKeyboardManager sharedManager].enable = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPhoto:) name:MKPhotoPushNotification object:nil];
  
    [self mkEvent];

    self.gk_navLeftBarButtonItem =  self.returnBtnItem;
    [self.view endEditing:YES];  
    [self confirmButtonStatue];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isClickMKUploadingVCView = NO;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
  
  
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    NSLog(@"");
}
#pragma mark - 返回按钮
-(UIBarButtonItem *)returnBtnItem{
    if (!_returnBtnItem) {
        UIButton *btn = UIButton.new;
//        [btn pp_addDotWithColor:[UIColor redColor]];
        btn.frame = CGRectMake(0,  0, 24,  44);
        [btn setImage:KIMG(@"white_后退")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(returnBtnClickEvent)
      forControlEvents:UIControlEventTouchUpInside];
        _returnBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _returnBtnItem;
}
- (void)returnBtnClickEvent
{
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    NSString *idxStr =  GetUserDefaultObjForKey(@"selectedIndex");
    [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = [idxStr intValue];
}
- (void)mkEvent {
    @weakify(self)
    
          [[_choosePicBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
              @strongify(self)
              if (self.urlVideo != nil || self.urlVideo.length != 0) {
                  [self videoPlayer];
              } else {
                  
                   [self choosePicBtnClickEvent:x];
              }
          }];
          [UIView colourToLayerOfView:_choosePicBtn
                           WithColour:kClearColor
                       AndBorderWidth:0.2f];
          [self.view layoutIfNeeded];
        

          [[_releaseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
              @strongify(self)
              if (self.agreementView.agreementBtn.selected &&
                  ![NSString isNullString:self.textView.text] &&
                  (self.imgData != nil || self.urlVideo != nil)) {
//                  NSLog(@"发布成功");
 
                  //这里先鉴定是否已经登录？
                  if (![NSString isNullString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token]) {
                      // 已经登录才可以上传视频
                      /*
                      上传限制 10M
                      总长度 length （B）
                      B => KB => M
                      length/1024/1024

                      if (sizeof(self.vedioData) <= 300 * 1024 * 1024) { (旧判断吧)
                      */
                          if ([MKUploadingVC mh_getVideolength:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",self.urlVideo]]] <= 30.f) {
                              [MBProgressHUD wj_showPlainText:@"请上传超过30秒的视频"
                              view:self.view];
                          }
                          else if ([MKUploadingVC mh_getVideolength:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",self.urlVideo]]]  > 300.f) {
                              [MBProgressHUD wj_showPlainText:@"上传视频的时长不得超过5分钟"
                              view:self.view];
                          } else {
                             
                              NSString *urlString = [NSString stringWithFormat:@"file://%@",self.urlVideo];
                              [self videosUploadNetworkingWithData:self.vedioData
                                                                             videoArticle:self.textView.text
                                                                                 urlAsset:self.urlAsset videoTime:[MKUploadingVC mh_getVideolength:[NSURL URLWithString:urlString]]];
                          }
                         

                  }else{
                      [NSObject Login];
                  }
              }else{
                  if (!self.imgData && self.urlVideo == nil) {
                      [NSObject showSYSAlertViewTitle:@"您还没选择需要上传的视频呢~~~"
                                              message:nil
                                      isSeparateStyle:NO
                                          btnTitleArr:@[@"确定"]
                                       alertBtnAction:@[@"sure"]
                                             targetVC:self
                                         alertVCBlock:^(id data) {
                          //DIY
                      }];
                  }else if ([NSString isNullString:self.textView.text]){
                      [NSObject showSYSAlertViewTitle:@"主人，写点什么吧~~~"
                                              message:nil
                                      isSeparateStyle:NO
                                          btnTitleArr:@[@"确定"]
                                       alertBtnAction:@[@""]
                                             targetVC:self
                                         alertVCBlock:^(id data) {
                          //DIY
                      }];
                  }else{}
              }
          }];
    [_releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.size.mas_equalTo(CGSizeMake(200*SCREEN_W/375, 40));
              make.centerX.equalTo(self.view);
              make.top.equalTo(self.choosePicBtn.mas_bottom).offset(SCALING_RATIO(10));
          }];
          [UIView cornerCutToCircleWithView:_releaseBtn
                            AndCornerRadius:SCALING_RATIO(20)];
}
#pragma mark - 获取视频长度
+(CGFloat)mh_getVideolength:(NSURL *)videoUrl
{
    AVURLAsset * asset = [AVURLAsset assetWithURL:videoUrl];
    CGFloat length = (CGFloat)asset.duration.value/(CGFloat)asset.duration.timescale;
    return length;
}

//这个地方必须用下划线属性而不能用self.属性。因为这两个方法反复调用，会触发懒加载
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    NSLog(@"");
}
///发布成功以后做的事情
-(void)afterRelease{
//    [self deleteButtonRemoveSelf:self.choosePicBtn];
    [self.choosePicBtn setImage:KIMG(@"white_upload_add")
              forState:UIControlStateNormal];
      self.choosePicBtn.iconBtn.hidden = YES;
      self.choosePicBtn.shaking = NO;

      self.imgData = nil;
      self.urlVideo = nil;
     
      [self confirmButtonStatue];
    [self btnClickEvent:self.agreementView.agreementBtn];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    self.textView.text = @"";
     [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:@"上传成功" dissmissAfterDeley:2.0f];
    [self performSelector:@selector(pushMine) withObject:nil afterDelay:2.0];
    
}
// 去个人中心，发起通知，跳转并更新作品列表
- (void)pushMine{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessUploadPushToMine" object:nil userInfo:nil];
    [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = 4; // 跳转到个人中心
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    self.isClickMKUploadingVCView = !self.isClickMKUploadingVCView;
//    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = !self.isClickMKUploadingVCView;
}
#pragma mark —— 点击事件
-(void)btnClickEvent:(UIButton *)sender{
    
    sender.selected = !sender.selected;
}

-(void)sure{
    [self choosePicBtnClickEvent:nil];
}

-(void)confirmButtonStatue {
    if ((self.imgData) && ![NSString isNullString:self.textView.text] ) {
        self.releaseBtn.userInteractionEnabled = YES;
        self.releaseBtn.alpha = 1;
//        self.releaseBtn.backgroundColor = kRedColor;
           [self.releaseBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
    }else if (self.urlVideo != nil && ![NSString isNullString:self.textView.text]) {
        self.releaseBtn.userInteractionEnabled = YES;
        self.releaseBtn.alpha = 1;
//        self.releaseBtn.backgroundColor = kRedColor;
           [self.releaseBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
    } else {
        self.releaseBtn.userInteractionEnabled = NO;
        self.releaseBtn.alpha = 0.4;
//        self.releaseBtn.backgroundColor = KLightGrayColor;
    }
}
///选择相册文件 imagePickerVc.allowPickingVideo
-(void)choosePicBtnClickEvent:(LGiOSBtn *)sender{
    self.imagePickerVC = nil;
    [NSObject feedbackGenerator];
    @weakify(self)
    [self choosePic:TZImagePickerControllerType_1 imagePickerVCBlock:^(id data) {
        @strongify(self)
        //回调 这样就可以全部选择视频了
        self.imagePickerVC.allowPickingVideo = YES;
        self.imagePickerVC.allowPickingImage = NO;
        self.imagePickerVC.allowPickingOriginalPhoto = NO;
        self.imagePickerVC.allowPickingGif = NO;
        self.imagePickerVC.allowPickingMultipleVideo = NO;
    }];
    
    [self GettingPicBlock:^(id firstArg, ...)NS_REQUIRES_NIL_TERMINATION{
        @strongify(self)
        if (firstArg) {
            // 取出第一个参数
//            NSLog(@"%@", firstArg);
            // 定义一个指向个数可变的参数列表指针；
            va_list args;
            // 用于存放取出的参数
            id arg = nil;
            // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
            va_start(args, firstArg);
            // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
            if ([firstArg isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)firstArg;
                for (int i = 0; i < num.intValue; i++) {
                    arg = va_arg(args, id);
//                    NSLog(@"KKK = %@", arg);
                    if ([arg isKindOfClass:UIImage.class]) {
                        self.imgData = (UIImage *)arg;
                        [self.choosePicBtn setImage:[UIImage addImage:[UIImage cropSquareImage:self.imgData]
                                                            withImage:KIMG(@"播放")
                                                    image2Coefficient:3]
                                           forState:UIControlStateNormal];
                        sender.iconBtn.hidden = NO;
                        [self confirmButtonStatue];
                    }else if ([arg isKindOfClass:PHAsset.class]){
//                        NSLog(@"");
                        PHAsset *phAsset = (PHAsset *)arg;
                        WeakSelf
                        [FileFolderHandleTool getVedioFromPHAsset:phAsset complete:^(id data, id data2) {
                      
                            if ([data isKindOfClass:NSData.class]) {
                                weakSelf.vedioData = data;
                            }
                            if ([data2 isKindOfClass:NSURL.class]) {
                                NSURL *dataUrl = (NSURL *)data2;
                                weakSelf.urlVideo = [NSString stringWithFormat:@"%@",dataUrl];
                             
                            }
                            
                        }];
                    }else if ([arg isKindOfClass:NSString.class]){
//                        NSLog(@"");
                    }else if ([arg isKindOfClass:NSArray.class]){
                        NSArray *arr = (NSArray *)arg;
                        if (arr.count == 1) {
                            if ([arr[0] isKindOfClass:PHAsset.class]) {
                                
                            }else if ([arr[0] isKindOfClass:UIImage.class]){
                                [NSObject showSYSAlertViewTitle:@"请选择视频作品"
                                                        message:nil
                                                isSeparateStyle:NO
                                                    btnTitleArr:@[@"确认"]
                                                 alertBtnAction:@[@"sure"]
                                                       targetVC:self
                                                   alertVCBlock:^(id data) {
                                    //DIY
                                }];
                            }else{
//                                NSLog(@"");
                            }
                        }else{
//                            NSLog(@"");
                        }
                    }else{
//                        NSLog(@"");
                    }
                }
            }else{
//                NSLog(@"");
            }
            // 清空参数列表，并置参数指针args无效
            va_end(args);
        }
    }];
}
#pragma mark - DZDeleteButtonDelegate
- (void)deleteButtonRemoveSelf:(LGiOSBtn *_Nonnull)button{
    [button setImage:KIMG(@"white_upload_add")
            forState:UIControlStateNormal];
    button.iconBtn.hidden = YES;
    button.shaking = NO;

    [self deleteVideos:self.videoString];

    self.imgData = nil;
    self.urlVideo = nil;
   
    [self confirmButtonStatue];
}

- (void)uploadingWithPath:(NSString *)path {
    
    self.videoString = path;
}

-(void)deleteVideos:(NSString *)videoString {
    BOOL success = [FileFolderHandleTool removeItemAtPath:[FileFolderHandleTool directoryAtPath:videoString]
                                                    error:nil];
    if (success) {

    }
    
}
#pragma mark - UITextViewDelegate协议中的方法
//将要进入编辑模式
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {return YES;}
//已经进入编辑模式
- (void)textViewDidBeginEditing:(UITextView *)textView {}
//将要结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {return YES;}
//已经结束/退出编辑模式
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self confirmButtonStatue];
}
//当textView的内容发生改变的时候调用
- (void)textViewDidChange:(UITextView *)textView {
    
    if(textView.text.length > 30)
    {
       textView.text= [textView.text substringToIndex:30];
    }
}
//选中textView 或者输入内容的时候调用
- (void)textViewDidChangeSelection:(UITextView *)textView {}
//从键盘上将要输入到textView 的时候调用
//rangge  光标的位置
//text  将要输入的内容
//返回YES 可以输入到textView中  NO不能
- (BOOL)textView:(UITextView *)textView
shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    return YES;
}

- (void)notificationPhoto:(NSNotification*)photoInfo {
    NSDictionary *imageInfo = (NSDictionary *)photoInfo.userInfo;
    
    [self.choosePicBtn setImage:[UIImage addImage:[UIImage cropSquareImage:imageInfo[@"photo"]]
                                                               withImage:KIMG(@"播放")
                                                       image2Coefficient:3]
                                              forState:UIControlStateNormal];

    self.choosePicBtn.iconBtn.hidden = NO;
    self.urlVideo  = [NSString stringWithFormat:@"%@",imageInfo[@"vedioUrl"]];
    AVURLAsset * asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:self.urlVideo] options:nil];
    NSURL *url = asset.URL;
    self.vedioData = [NSData dataWithContentsOfURL:url];
    [self confirmButtonStatue];
    [self.view layoutIfNeeded];
}


#pragma mark - lazyLoad
-(UIView *)backView{
    if (!_backView) {
        _backView = UIView.new;
        _backView.backgroundColor = UIColor.whiteColor;
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
//        _backView.layer.borderColor = [UIColor colorWithHexString:@"606060"].CGColor;
//        _backView.layer.borderWidth = 1.0;
        [self.view addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(SCALING_RATIO(10));
            make.height.mas_equalTo(SCALING_RATIO(105));
//            make.width.mas_equalTo(309*SCREEN_W/375);
        }];
    }return _backView;
}

-(SZTextView *)textView {
    if (!_textView) {
        _textView = SZTextView.new;
        _textView.backgroundColor = kClearColor;
        _textView.delegate = self;
        _textView.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"上传视频获赞可兑换现金奖励，赶紧来发布视频吧~！"
                                                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular],
                                                                                              NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"]}];
        _textView.placeholderTextColor = [UIColor colorWithHexString:@"999999"];
        _textView.textColor = UIColor.blackColor;
        _textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0];
        [self.backView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.backView);
            make.height.mas_equalTo(SCALING_RATIO(100));
        }];
    }return _textView;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.textColor = kWhiteColor;//
//        _tipsLab.attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还可以输入%d个字符",self.inputLimit]
//                                                                         attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular],
//                                                                                      NSForegroundColorAttributeName:HEXCOLOR(0x242A37)}];
        [self.backView addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.backView).offset(SCALING_RATIO(-6));
            make.top.equalTo(self.textView.mas_bottom).offset(SCALING_RATIO(-6));
        }];
    }return _tipsLab;
}

-(LGiOSBtn *)choosePicBtn {
    if (!_choosePicBtn) {
        _choosePicBtn = LGiOSBtn.new;
        _choosePicBtn.delegate = self;
       
        [self.view addSubview:_choosePicBtn];
        [_choosePicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(130), SCALING_RATIO(130)));
            make.left.equalTo(self.view).offset(SCALING_RATIO(32));
            make.top.equalTo(self.backView.mas_bottom).offset(10);
//            if (iPhoneX | iPhoneScreen_XSMAX | iPhoneScreen_X_XS | iPhoneScreen_XR) {
//                 make.top.mas_equalTo(SCALING_RATIO(47+88));
//            } else {
//                 make.top.mas_equalTo(SCALING_RATIO(47+64));
//            }
           
        }];
      
    }return _choosePicBtn;
}

- (void)videoPlayer {
   
     [self.customerAVPlayer play];
}

-(CustomerAVPlayer *)customerAVPlayer{
    if (!_customerAVPlayer) {
        if (_urlVideo != nil) {
            NSURL *url = [NSURL fileURLWithPath:_urlVideo];
            _customerAVPlayer = [[CustomerAVPlayer alloc] initWithURL:url];
            _customerAVPlayer.backgroundColor = kClearColor;
            UIWindow  *windows =   [UIApplication sharedApplication].keyWindow;
            [windows addSubview:_customerAVPlayer];
            [windows addSubview:self.actionBtn];
            _customerAVPlayer.frame = self.view.bounds;
        }
    }
    return _customerAVPlayer;
}

-(UIButton *)releaseBtn{
    if (!_releaseBtn) {
        _releaseBtn = UIButton.new;
        [_releaseBtn setTitle:@"确认发布"
                     forState:UIControlStateNormal];
        _releaseBtn.uxy_acceptEventInterval = 1;
        _releaseBtn.titleLabel.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        //默认先关
        _releaseBtn.userInteractionEnabled = NO;
//        _releaseBtn.alpha = 1;
        [_releaseBtn setTitleColor:[UIColor colorWithWhite:1 alpha:0.6] forState:UIControlStateNormal];
        [_releaseBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        _releaseBtn.backgroundColor = [UIColor colorWithHexString:@"20242f"];
        @weakify(self)
        [[_releaseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.agreementView.agreementBtn.selected &&
                ![NSString isNullString:self.textView.text] &&
                (self.imgData || self.urlVideo != nil)) {
//                NSLog(@"发布成功");
                if (self.urlVideo != nil) {
                    if ([MKPublickDataManager sharedPublicDataManage].mkLoginModel.token != nil) {
                        // 已经登录才可以上传视频
                        CGFloat length = (CGFloat)self.vedioData.length;
                        CGFloat dataSize = length / (1024.0 * 1024.0);
    //                    if (length/1024/1024 <= 10.0f) {
                        
                            if ([MKUploadingVC mh_getVideolength:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",self.urlVideo]]] <= 10.f) {
                                [MBProgressHUD wj_showPlainText:@"请上传超过10秒的视频"
                                view:self.view];
                            }  else if (dataSize > 300) {
                                [MBProgressHUD wj_showPlainText:@"上传视频的不能超过300M"
                                view:self.view];
                            } else {
                                NSString *urlString = [NSString stringWithFormat:@"file://%@",self.urlVideo];
//                                [self videosUploadNetworkingWithData:self.vedioData
//                                                                               videoArticle:self.textView.text
//                                                                                   urlAsset:self.urlAsset videoTime:[MKUploadingVC mh_getVideolength:[NSURL URLWithString:urlString]]];
                                NSString *filename = [NSString stringWithFormat:@"%.0f.mp4", [NSDate date].timeIntervalSince1970 * 1000];
                                [self presignedUploadUrl:filename videoTitle:self.textView.text data:self.vedioData];
                            }
                    }else{
                        [NSObject Login];
                    }
                } else {
                    DLog(@"没有视频播放地址");
                }
                //这里先鉴定是否已经登录？
                DLog(@"登录成功%@",[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token);
            
            }else{
             
                if(self.agreementView.agreementBtn.selected == YES){
                 if (!self.imgData || self.urlVideo == nil) {
                                  [NSObject showSYSAlertViewTitle:@"您还没选择需要上传的视频呢~~~"
                                                          message:nil
                                                  isSeparateStyle:NO
                                                      btnTitleArr:@[@"确定"]
                                                   alertBtnAction:@[@"sure"]
                                                         targetVC:self
                                                     alertVCBlock:^(id data) {
                                      //DIY
                                  }];
                              }else if ([NSString isNullString:self.textView.text]){
                                  [NSObject showSYSAlertViewTitle:@"主人，写点什么吧~~~"
                                                          message:nil
                                                  isSeparateStyle:NO
                                                      btnTitleArr:@[@"确定"]
                                                   alertBtnAction:@[@""]
                                                         targetVC:self
                                                     alertVCBlock:^(id data) {
                                  }];
                              }
                }else {
                    [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:@"请确认勾选上传须知" dissmissAfterDeley:2.0f];
                }
            }
        }];
        [self.view addSubview:_releaseBtn];
        [_releaseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200*SCREEN_W/375, 40));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.choosePicBtn.mas_bottom).offset(SCALING_RATIO(10));
        }];
        [UIView cornerCutToCircleWithView:_releaseBtn
                          AndCornerRadius:SCALING_RATIO(20)];
      [self.view addSubview:_releaseBtn];
    }return _releaseBtn;
}

-(AgreementView *)agreementView{
    if (!_agreementView) {
        _agreementView = AgreementView.new;
        @weakify(self)
        [_agreementView actionAgreementViewBtnBlock:^(id data) {
            @strongify(self)
            [self btnClickEvent:data];
        }];
        
        [_agreementView actionAgreementViewLinkBlock:^(id data) {
            @strongify(self)
//            NSLog(@"点击到了一个链接");
    //        [[MKTools shared] cleanCacheAndCookie];
            MKWebViewVC *vc  = MKWebViewVC.new;
            vc.url = [NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5UploadNotice,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
            
            [self.navigationController pushViewController:vc
                                                 animated:YES];
        }];
        
        [self.view addSubview:_agreementView];
        [_agreementView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(150, 20));
            make.top.equalTo(self.releaseBtn.mas_bottom).offset(18);
        }];
    }return _agreementView;
}

- (NSMutableArray *)videoArray {
    if (!_videoArray) {
        _videoArray = [NSMutableArray arrayWithCapacity:16];
    }
    return _videoArray;
}

- (UIButton *)actionBtn {
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionBtn.backgroundColor = [UIColor clearColor];
        _actionBtn.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    }
    return _actionBtn;
}


-(void)buttonClickAction:(UIButton *)sender {

    [UIView animateWithDuration:0.3 animations:^{
     self.customerAVPlayer.transform = CGAffineTransformMakeScale(1.2, 1.2);
 } completion:^(BOOL finished) {
     // 完成后要将视图还原
     // CGAffineTransformIdentity
     [UIView animateWithDuration:0.3 animations:^{
         self.customerAVPlayer.transform = CGAffineTransformIdentity;
       [self.customerAVPlayer stop];
       [self.customerAVPlayer removeFromSuperview];
       self.customerAVPlayer = Nil;
      [self.actionBtn removeFromSuperview];
     }];
 }];
}

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
      [[NSNotificationCenter defaultCenter] removeObserver:self name:MKPhotoPushNotification object:nil];
 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"SuccessUploadPushToMine" object:nil];
    
}
/*
上传限制 10M
总长度 length （B）
B => KB => M
length/1024/1024

if (sizeof(self.vedioData) <= 300 * 1024 * 1024) { (旧判断吧)
*/
- (NSUInteger)durationWithVideo:(NSURL *)videoUrl{
      
      NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
      AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts]; // 初始化视频媒体文件
      NSUInteger second = 0;
      second = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
      
      return second;
}

- (id)transformedValue:(double)value
{
 
//    double convertedValue = [value doubleValue];
    int multiplyFactor = 0;
 
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];
 
    while (value > 1024) {
        value /= 1024;
        multiplyFactor++;
    }
 
    return [NSString stringWithFormat:@"%.2f | %@",value, [tokens objectAtIndex:multiplyFactor]];
}

@end
