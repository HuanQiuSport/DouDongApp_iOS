//
//  VerificationCodeVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/29.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "VerificationCodeVC.h"
#import "VerificationCodeVC+VM.h"
#import "MKLoginButtonView.h"

#import "CustomZFPlayerControlView.h"

ZFPlayerController *ZFPlayer_VerificationCodeVC;

@interface VerificationCodeVC ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *tips_1_Lab;
@property(nonatomic,strong)UILabel *tips_2_Lab;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)CountDownBtn *countDownBtn;
@property(nonatomic,strong)NSString *telStr;

@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property (strong,nonatomic) MKLoginButtonView *mkLoginView;
///
@property (strong,nonatomic) UIButton *mkBackButton;

@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong)CustomZFPlayerControlView *customPlayerControlView;

@end

@implementation VerificationCodeVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    VerificationCodeVC *vc = VerificationCodeVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    vc.telStr = requestParams[@"tel"];
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

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtnCategory];
    self.gk_navLineHidden = YES;
//    self.gifImageView.image = kIMG(@"nodata");
//    [self.view sendSubviewToBack:self.gifImageView];
    self.gk_navigationBar.hidden = 1;
    if (self.successBlock) {
        self.successBlock(@1);
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.player.currentPlayerManager play];
    
    [self.view addSubview:self.mkBackButton];
    [self.mkBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.offset(15+18+15);
        make.height.offset(24+12+12);
        make.top.offset(kStatusBarHeight+kNavigationBarHeight+8);
    }];
    [self.view addSubview:self.titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.top.equalTo(self.mkBackButton.mas_bottom).offset(22);
        make.height.offset(33);
    }];
    [self.view addSubview:self.tips_1_Lab];
    [self.tips_1_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(9);
        make.right.offset(-30);
    }];
    [self.view addSubview:self.hwTextCodeView];
    [self.hwTextCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(74);
        make.left.right.equalTo(self.tips_1_Lab);
        make.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.tips_2_Lab];
    [self.tips_2_Lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hwTextCodeView.mas_bottom).offset(17);
        make.left.equalTo(self.tips_1_Lab);
        make.height.offset(14);
    }];
    [self.view addSubview:self.countDownBtn];
    [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.tips_2_Lab.mas_centerY).offset(0);
        make.left.equalTo(self.tips_2_Lab.mas_right).offset(SCALING_RATIO(10));
    }];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.height.offset(44);
        make.top.equalTo(self.tips_2_Lab.mas_bottom).offset(28);
    }];
    
    self.titleLab.alpha = 1;
    self.tips_1_Lab.text = [NSString stringWithFormat:@"我们已经给手机号%@发送了一个4位数验证码，输入验证码即可登录",self.telStr];
    self.hwTextCodeView.alpha = 1;
    self.tips_2_Lab.alpha = 1;
    self.countDownBtn.alpha = 1;
    self.mkLoginView.alpha = 1;
    
    [self.view bringSubviewToFront:self.gk_navigationBar];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.player.currentPlayerManager pause];
}

-(void)loginBtnClickEvent:(UIButton *)sender{
    NSLog(@"%@",self.hwTextCodeView.code);
    if (self.hwTextCodeView.code.length == 0) {
        [[MKTools shared] showMBProgressViewOnlyTextInView:self.view
                                                      text:@"请填写验证吗"
                                        dissmissAfterDeley:1.5];
        return;
    }else if (self.hwTextCodeView.code.length == 4){
        [NSObject feedbackGenerator];
        [self login_netWorking];
    }else{}

    
}

#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"请输入验证码";
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:24];

    }return _titleLab;
}

-(UILabel *)tips_1_Lab{
    if (!_tips_1_Lab) {
        _tips_1_Lab = UILabel.new;
        _tips_1_Lab.textColor = RGBCOLOR(76, 82, 95);
        _tips_1_Lab.font = [UIFont systemFontOfSize:13];
        _tips_1_Lab.numberOfLines = 0;

    }return _tips_1_Lab;
}

-(HWTextCodeView *)hwTextCodeView{
    if (!_hwTextCodeView) {
        _hwTextCodeView = [[HWTextCodeView alloc] initWithCount:4
                                                         margin:20];
        _hwTextCodeView.backgroundColor = kClearColor;
        @weakify(self)
        [_hwTextCodeView HWTextCodeViewActionBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UITextField.class]) {
                self.loginBtn.userInteractionEnabled = YES;
                self.loginBtn.alpha = 1;
            }
        }];

    }return _hwTextCodeView;
}

-(UILabel *)tips_2_Lab{
    if (!_tips_2_Lab) {
        _tips_2_Lab = UILabel.new;
        _tips_2_Lab.text= @"没收到验证码？";
        _tips_2_Lab.font = [UIFont systemFontOfSize:13];
        _tips_2_Lab.textColor = [UIColor whiteColor];

    }return _tips_2_Lab;
}

-(CountDownBtn *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [[CountDownBtn alloc] initWithStyle:CountDownBtnType_CountDown];
        _countDownBtn.titleRuningStr = @"重新发送";
        _countDownBtn.titleBeginStr = @"重新发送";
        _countDownBtn.titleEndStr = @"重新发送";
        _countDownBtn.titleLabelFont = [UIFont systemFontOfSize:13];
        _countDownBtn.titleColor = RGBCOLOR(76, 82, 95);
        _countDownBtn.bgCountDownColor = kClearColor;
        _countDownBtn.bgEndColor = kClearColor;
        _countDownBtn.layerCornerRadius = 6;
        [_countDownBtn timeFailBeginFrom:60];

    }return _countDownBtn;
}

-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = UIButton.new;
        [_loginBtn setTitle:@"登录"
                   forState:UIControlStateNormal];
        [_loginBtn setTitleColor:kWhiteColor
                        forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"gradualColor"] forState:UIControlStateNormal];;
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.alpha = 0.7f;
        _loginBtn.layer.cornerRadius = 22;
        _loginBtn.layer.masksToBounds = 1;
        [_loginBtn addTarget:self
                      action:@selector(loginBtnClickEvent:)
            forControlEvents:UIControlEventTouchUpInside];

    }return _loginBtn;
}

- (UIButton *)mkBackButton{
    
    if (!_mkBackButton) {
        
        _mkBackButton = [[UIButton alloc]init];
        
        [_mkBackButton setImage:kIMG(@"back_white") forState:UIControlStateNormal];
        
        WeakSelf
        [_mkBackButton addAction:^(UIButton *btn) {
            
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
        }];
    }
    return _mkBackButton;
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
        ZFPlayer_VerificationCodeVC = _player;
        @weakify(self)
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}


@end
