//
//  MKAdVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/23/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKAdVC.h"
#import "MKAdVC+VM.h"
#import "MKPlayVideoView.h"
#import "MKAdLoadView.h"


@interface MKAdVC ()

@property (strong) YYTimer *timer;
@property (strong) YYTimer *timer2;
///
@property (strong,nonatomic) MKPlayVideoView *mkPlayVideo;

@property (strong,nonatomic) UIButton  *mkNextBtn;

@property(nonatomic,strong)UIButton *countDownBtn;
///
@property (strong,nonatomic) MKAdLoadView *mkAdLoadView;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(copy,nonatomic)MKDataBlock adActionBlock;

@end

@implementation MKAdVC

- (void)dealloc {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#pragma clang diagnostic pop
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MKAdVC *vc = MKAdVC.new;
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
//            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self)
    [self requestAdBlock:^(id data) {
        @strongify(self)
        if ((Boolean)data) {
            [self addPlayVideo];
            [self dataGet];
            self.gk_interactivePopDisabled = YES;
//            self.gk_fullScreenPopDisabled = YES;
        }else{
            self.gk_interactivePopDisabled = NO;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.adActionBlock) {
        self.adActionBlock(@1);
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)abandon{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)MKAdActionBlock:(MKDataBlock)adActionBlock{
    self.adActionBlock = adActionBlock;
}

-(void)Cancel{}

- (void)AlertTip{
    [NSObject showSYSAlertViewTitle:@"提前跳过？"
                            message:@"提前跳过将失去奖励积分"
                    isSeparateStyle:NO
                        btnTitleArr:@[@"放弃奖励",@"继续观看"]
                     alertBtnAction:@[@"abandon",@"Cancel"]
                           targetVC:self
                       alertVCBlock:^(id data) {
        //DIY
    }];
}

-(void)handlePlayerNotify:(NSNotification*)notify{
    
    self.mkPlayVideo.mkFontImageView.hidden = YES;
    
}

- (void)moviePlayerPlaybackStateDidChangeNotification:(NSNotification*)notify{
 
//    [self.mkPlayVideo.mkPlayer play];
      
}

-(void)moviePlayerLoadStateDidChangeNotification:(NSNotification*)notify{
    
    self.mkPlayVideo.mkFontImageView.hidden = YES;
    
}
-(void)dataGet{
    
    [self.view addSubview:self.countDownBtn];
    
    [self.countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@(kStatusBarHeight));
        
        make.left.equalTo(@(0));
        
        make.height.equalTo(@(30 * KDeviceScale));
        
        make.width.equalTo(@(60 * KDeviceScale));
        
    }];
    
    WeakSelf
    __block  NSInteger times = 0;
    self.timer  =  [YYTimer timerWithTimeInterval:30 repeats:YES usingBlock:^(YYTimer * _Nonnull timer) {
        
        if (times == 0) {
            
            
        }else if (times >= 1 ) {
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [timer invalidate];
        } else {
            
            
            
        }
        times = times + 1;
    }];
    __block  NSInteger times2 = 0;
    self.timer2  =  [YYTimer timerWithTimeInterval:10 repeats:YES usingBlock:^(YYTimer * _Nonnull timer) {
        
        if (times2 == 0) {
            
            
        }else if (times2 >= 1 ) {
            
            [weakSelf.view addSubview: weakSelf.mkNextBtn ];
            
            [weakSelf.mkNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.right.equalTo(@(-KDeviceScale * 10));
                
                make.top.equalTo(@(kStatusBarHeight));
                
                make.height.equalTo(@(KDeviceScale *30));
                
                make.width.equalTo(@(KDeviceScale *60));
                
            }];
            
            [timer invalidate];
            
        } else {
            
        }
        times2 = times2 + 1;
    }];
}
- (void)addPlayVideo{
    
    [self.view addSubview:self.mkPlayVideo];
    
    self.mkPlayVideo.mkPlayUserView.mkLoginView.hidden = YES;
    
    self.mkPlayVideo.mkPlayUserView.mkRightBtuttonView.mkZanView.mkTitleLable.text = [MKTools getRandomNumber:1000];
    
    self.mkPlayVideo.mkPlayUserView.mkRightBtuttonView.mkShareView.mkTitleLable.text = [MKTools getRandomNumber:1000];
    
    self.mkPlayVideo.mkPlayUserView.mkRightBtuttonView.mkCommentView.mkTitleLable.text = [MKTools getRandomNumber:1000];
//    if ([[KSYHTTPProxyService sharedInstance] isRunning]) {
//        NSLog(@"服務開通");
//    }
//    NSLog(@"live.VideoAddress = %@",self.mkVideoAd.adVideoUrl);
//    NSLog(@"%@",self.mkVideoAd.adVideoUrl);

    self.mkPlayVideo.mkPlayUserView.hidden = YES;

    [self.mkPlayVideo.mkVideoView setFrame:CGRectMake(0, kStatusBarHeight+kNavigationBarHeight,kScreenWidth, kScreenHeight - kStatusBarHeight-kNavigationBarHeight - 250*KDeviceScale)];

    [self.view addSubview:self.mkAdLoadView];

    [self.mkAdLoadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));

        make.bottom.equalTo(@(0));

        make.right.equalTo(@(0));

        make.height.equalTo(@(250 *KDeviceScale));
    }];

    self.mkAdLoadView.mkTitleLabel.text = [NSString ensureNonnullString:self.mkVideoAd.adName ReplaceStr:@"亚博体育"];

    self.mkAdLoadView.mkDecribeLabel.text =[NSString ensureNonnullString:self.mkVideoAd.remark ReplaceStr:@"亚博体育亚博体育亚博体\n育亚博体育亚博体育"];

    self.mkAdLoadView.mkDecribeLabel.textAlignment = NSTextAlignmentCenter;

    self.mkAdLoadView.mkTitleLabel.textAlignment = NSTextAlignmentCenter;

    [self.mkAdLoadView.mkImageView sd_setImageWithURL:[NSURL URLWithString:self.mkVideoAd.logoImg] placeholderImage:KIMG(@"替代头像")];
    WeakSelf
    [self.mkAdLoadView.mkButton addAction:^(UIButton *btn) {

        [MKTools openSafariWith:[NSURL URLWithString:[NSString ensureNonnullString:weakSelf.mkVideoAd.adLink ReplaceStr:@"http://www.baidu.com"]]];

        [weakSelf.navigationController popViewControllerAnimated:YES];

    }];
}

#pragma mark —— lazyLoad
- (MKVideoAdModel *)mkVideoAd{
    
    if (!_mkVideoAd) {
        
        _mkVideoAd = [[MKVideoAdModel alloc]init];
    }
    return _mkVideoAd;
}

- ( MKPlayVideoView*)mkPlayVideo{
    
    if (!_mkPlayVideo) {
        
        _mkPlayVideo = [[MKPlayVideoView alloc]initWithFrame:self.view.bounds];
        
    }
    return _mkPlayVideo;
}
- (UIButton *)mkNextBtn{
    
    if (!_mkNextBtn) {
        
        _mkNextBtn = [[UIButton alloc]init];
        
        _mkNextBtn.layer.cornerRadius = 15 *KDeviceScale;
        
        _mkNextBtn.layer.masksToBounds = YES;
        
        [_mkNextBtn setTitle:@"跳过" forState:UIControlStateNormal];
        
        
        [_mkNextBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        
        _mkNextBtn.backgroundColor = [UIColor lightGrayColor];
        
        WeakSelf
        [_mkNextBtn addAction:^(UIButton *btn) {
            
            [weakSelf AlertTip];
        }];
    }
    return _mkNextBtn;
}

-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [[UIButton alloc] initWithType:CountDownBtnType_countDown
                                               runType:CountDownBtnRunType_auto
                                      layerBorderWidth:0
                                     layerCornerRadius:6
                                      layerBorderColor:nil
                                            titleColor:kGrayColor
                                         titleBeginStr:@""
                                        titleLabelFont:[UIFont systemFontOfSize:8
                                                                         weight:UIFontWeightRegular]];
        _countDownBtn.titleRuningStr = @"";
        _countDownBtn.titleEndStr = @"";
        _countDownBtn.backgroundColor = KLightGrayColor;
        _countDownBtn.bgCountDownColor = kClearColor;//倒计时的时候此btn的背景色
        _countDownBtn.bgEndColor = kClearColor;//倒计时完全结束后的背景色
        _countDownBtn.showTimeType = ShowTimeType_SS;
        _countDownBtn.countDownBtnNewLineType = CountDownBtnNewLineType_normal;
        
        [_countDownBtn timeFailBeginFrom:30];//注销这句话就是手动启动，放开这句话就是自启动
        
//        @weakify(self)
        [_countDownBtn actionCountDownClickEventBlock:^(id data) {
//            @strongify(self)
        }];
        [self.view addSubview:_countDownBtn];

    }return _countDownBtn;
}

- (MKAdLoadView *)mkAdLoadView{
    
    if (!_mkAdLoadView) {
        
        _mkAdLoadView = [[MKAdLoadView alloc]init];
    }
    
    return _mkAdLoadView;
}

@end
