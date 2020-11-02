//
//  LoginVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/28/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LoginVC.h"
#import "MKPhoneNumberView.h"
#import "MKLoginButtonView.h"
#import "LoginVC+VM.h"
#import "FLAnimatedImageView.h"
#import <SDWebImage/UIView+WebCache.h>

#import "CustomZFPlayerControlView.h"

ZFPlayerController *ZFPlayer_LoginVC;

@interface LoginVC ()

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
/// 关闭
@property(strong,nonatomic)UIButton *rightBarBtn;
/// 标题
@property(strong,nonatomic)UILabel *mkTitleLabel;
/// 副标题
@property(strong,nonatomic)UILabel *mkDescribeLabel;
/// 手机号
@property(strong,nonatomic)MKPhoneNumberView *mkPhoneNumberView;
///  登录
@property(strong,nonatomic)MKLoginButtonView *mkLoginButtonView;

@property(strong,nonatomic)NSMutableAttributedString *placeholder;

@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)CustomZFPlayerControlView *customPlayerControlView;

@end

@implementation LoginVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    LoginVC *vc = LoginVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
//    self.gifImageView.alpha = 1;
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"注册页视频" ofType:@"gif"];
//    NSData *gifData = [NSData dataWithContentsOfFile:path];
//    self.gifImageView.image = [UIImage sd_imageWithGIFData:gifData];
    self.gk_navLineHidden = YES;
    self.gk_navigationBar.hidden = NO;
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.player.currentPlayerManager play];
    [self mkAddSubView];
    [self mkLayOutView];
    [self.mkPhoneNumberView.mkPhoneTF becomeFirstResponder];
    self.mkPhoneNumberView.mkPhoneLable.hidden = YES;
    self.mkPhoneNumberView.mkTopLineVIew.hidden = YES;
    [self.view bringSubviewToFront:self.gk_navigationBar];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player.currentPlayerManager pause];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark —— 点击事件
-(void)rightBarBtnClickEvent:(UIButton *)sender{
    [self.view removeAllSubviews];
    self.view.backgroundColor = [UIColor blackColor];
//    if ([SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex == 4) {
//        [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = 0;
//    } else {
//
//    }
    [self dismissViewControllerAnimated:NO
                             completion:^{
        
    }];
}

#pragma mark - 添加子视图
- (void)mkAddSubView{
    self.mkTitleLabel.alpha = 1;
    self.mkDescribeLabel.alpha = 1;
    self.mkPhoneNumberView.alpha = 1;
    self.mkLoginButtonView.alpha = 1;
}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    [self.mkTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(32);
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(kStatusBarHeight + 20);
        make.height.offset(33);
    }];
    
    [self.mkDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(32);
        make.top.equalTo(self.mkTitleLabel.mas_bottom).offset(6);
        make.height.offset(20);
    }];
    
    [self.mkPhoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mkDescribeLabel.mas_bottom).offset(30);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.equalTo(@(50 *KDeviceScale));
    }];
    
    [self.mkLoginButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mkPhoneNumberView.mas_bottom).offset(30);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(50 * KDeviceScale));
    }];
    @weakify(self)
    [self.mkLoginButtonView.mkLoginButton addAction:^(UIButton *btn) {
#pragma mark - 登录入口
        @strongify(self)
        [self.view endEditing:YES];
        if (![NSString isNullString:self.telStr]) {//国内手机号码是11位
            [NSObject feedbackGenerator];
            if (self.telStr.length == 11) {
                [weak_self sendSmsCode_netWorking];
            }else{
                [MBProgressHUD wj_showPlainText:@"请填写正确的手机号码"
                                           view:nil];
            }
        }else{
            [MBProgressHUD wj_showPlainText:@"请填写手机号码"
                                       view:nil];
        }
    }];
}

#pragma mark - setter
-(UIButton *)rightBarBtn{
    if (!_rightBarBtn) {
        _rightBarBtn = UIButton.new;
        [_rightBarBtn setImage:kIMG(@"login_close")
                      forState:UIControlStateNormal];
        [_rightBarBtn addTarget:self
                         action:@selector(rightBarBtnClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
    }return _rightBarBtn;
}

- (UILabel *)mkTitleLabel{
    if (!_mkTitleLabel) {
        _mkTitleLabel = UILabel.new;
        _mkTitleLabel.text = @"请输入手机号";
        _mkTitleLabel.textColor = [UIColor whiteColor];
        [MKTools mkSetStyleLabel24:_mkTitleLabel];
        [self.view addSubview:_mkTitleLabel];
    }return _mkTitleLabel;
}

- (UILabel *)mkDescribeLabel{
    if (!_mkDescribeLabel) {
        _mkDescribeLabel = UILabel.new;
        _mkDescribeLabel.text = @"无需注册，使用验证码快速登录";
        _mkDescribeLabel.textColor = RGBCOLOR(76, 82, 95);
        _mkDescribeLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_mkDescribeLabel];
    }return _mkDescribeLabel;
}

-(NSMutableAttributedString *)placeholder{
    if (!_placeholder) {
        NSString *holderText = @"请输入手机号码";
        _placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [_placeholder addAttribute:NSForegroundColorAttributeName
                             value:RGBCOLOR(76, 82, 95)
                             range:NSMakeRange(0, holderText.length)];
        [_placeholder addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:16]
                             range:NSMakeRange(0, holderText.length)];
    }return _placeholder;
}

- (MKPhoneNumberView *)mkPhoneNumberView{
    if (!_mkPhoneNumberView) {
        _mkPhoneNumberView = MKPhoneNumberView.new;
        _mkPhoneNumberView.mkPhoneLable.textColor = [UIColor whiteColor];
        _mkPhoneNumberView.mkPhoneTF.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName:RGBCOLOR(76, 82, 95)}];
        _mkPhoneNumberView.mkPhoneTF.textColor = UIColor.whiteColor;
        [self.view addSubview:_mkPhoneNumberView];
        @weakify(self)
        [_mkPhoneNumberView action:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UITextField.class]) {
                UITextField *tf = (UITextField *)data;
                self.telStr = tf.text;
            }
        }];
        [_mkPhoneNumberView actionisInputtingBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:NSString.class]) {
                NSString *str = (NSString *)data;
                self.mkLoginButtonView.mkLoginButton.userInteractionEnabled = ![NSString isNullString:str];
                self.mkLoginButtonView.mkLoginButton.alpha = [NSString isNullString:str] ? 0.4 :1;
            }
        }];
    }return _mkPhoneNumberView;
}

- (MKLoginButtonView *)mkLoginButtonView{
    if (!_mkLoginButtonView) {
        _mkLoginButtonView = MKLoginButtonView.new;
        _mkLoginButtonView.mkLoginButton.userInteractionEnabled = NO;
        _mkLoginButtonView.mkLoginButton.alpha = 0.4;
        [self.view addSubview:_mkLoginButtonView];
    }return _mkLoginButtonView;
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;
        
//        _playerManager.assetURL = [NSURL URLWithString:@"https://www.apple.com/105/media/us/iphone-x/2017/01df5b43-28e4-4848-bf20-490c34a926a7/films/feature/iphone-x-feature-tpl-cc-us-20170912_1280x720h.mp4"];
        
        _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:(kStatusBarHeight > 20.00) ? @"iph_X": @"非iph_X" ofType:@"mp4"]];
        
    }return _playerManager;
}

-(ZFPlayerController *)player{
    if (!_player) {
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
                                                      containerView:self.view];
        _player.controlView = self.customPlayerControlView;
        ZFPlayer_LoginVC = _player;
        @weakify(self)
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(id data) {
            @strongify(self)
            [self.view endEditing:YES];
        }];
    }return _customPlayerControlView;
}

@end
