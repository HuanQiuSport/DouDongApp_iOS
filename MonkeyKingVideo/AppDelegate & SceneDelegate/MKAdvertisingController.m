//
//  MKAdvertisingController.m
//  MonkeyKingVideo
//
//  Created by george on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKAdvertisingController.h"

@interface MKAdvertisingController ()

@property(nonatomic,strong) UIImageView *adView;
@property(nonatomic,strong) UIView *locationView;
@property(nonatomic,strong) UIView *timeView;
@property(nonatomic,strong) UILabel *timeLabel;

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,assign) int count;

@end

@implementation MKAdvertisingController

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [self.timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 4;
    [self setSubviews];
    [self startTime];
}

- (void)setSubviews {
    [self.view addSubview:self.adView];
    [self.view addSubview:self.locationView];
    [self.view addSubview:self.timeView];
    if ([self.timerHiddenString isEqualToString:@"隐藏"]) {
        [self.timeView removeFromSuperview];
    } else {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTopLabel) userInfo:nil repeats:YES];
    }
}

#pragma mark
- (void)startTime{
    NSDictionary *dic = @{
        @"deviceId":UDID,
        @"origin":@(originType_Apple),
        @"version":HDAppVersion,
        @"channelUrl":@""
    };
    dispatch_async(dispatch_queue_create("startTime", DISPATCH_QUEUE_SERIAL), ^{
        FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                               path:[URL_Manager sharedInstance].MKStartTimePOST
                                                         parameters:dic];
        self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
        [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
//            NSLog(@"%@",response.reqResult);
        }];
    });
}

#pragma mark
- (void)updateTopLabel{
    self.count -= 1;
    self.timeLabel.text = [NSString stringWithFormat:@"%d",self.count];
    if (self.count == 0) {
        [self changeWindow];
    }
}

- (void)imageViewTapAction{
    if ([self.timerHiddenString isEqualToString:@"隐藏"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self changeWindow];
    }
 
//    NSString *url = @"itms-services://?action=download-manifest&url=https://bt.5li2v2.com/channel/ios/hqbetgame_201_6215472_202009132133_4712.plist";
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
    NSURL * url = [NSURL URLWithString:@"tingyun.75://"];
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
    //先判断是否能打开该url
    if (canOpen){//打开微信
        [[UIApplication sharedApplication] openURL:url];
    }else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mkSkipHQAppString]
                                           options:@{}
                                 completionHandler:nil];
    }
}

- (void)changeWindow{
    [self.timer invalidate];
    
    NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects];
    UIWindowScene *windowScene = (UIWindowScene *)array[0];
    SceneDelegate *delegate = (SceneDelegate *)windowScene.delegate;
    delegate.window.rootViewController = [UINavigationController rootVC:delegate.customSYSUITabBarController transitionScale:NO];
    [delegate.window makeKeyWindow];
}

#pragma mark
- (UIImageView *)adView{
    if (!_adView) {
        _adView = [[UIImageView alloc] init];
        _adView.frame = self.view.frame;
        _adView.image = KIMG(@"广告图.png");
        _adView.userInteractionEnabled = YES;
        [_adView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTapAction)]];
    }
    return _adView;
}

- (UIView *)locationView{
    if (!_locationView) {
        _locationView = [[UIView alloc]init];
        _locationView.frame = CGRectMake(SCREEN_W - 100, kStatusBarHeight + 20, 90, 30);
        _locationView.backgroundColor = KLightGrayColor;
        _locationView.alpha = 0.5;
        [UIView cornerCutToCircleWithView:_locationView AndCornerRadius:15];
    }
    return _locationView;
}

- (UIView *)timeView{
    if (!_timeView) {
        _timeView = [[UIView alloc]init];
        _timeView.frame = self.locationView.frame;
        [_timeView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeWindow)]];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.frame = CGRectMake(10, 0, 10, _timeView.height);
        _timeLabel.text = @"4";
        _timeLabel.font = kFontSize(18);
        _timeLabel.textColor = kWhiteColor;
        [_timeView addSubview:_timeLabel];
        
        UIView *line =  [[UIView alloc]init];
        line.frame = CGRectMake(_timeLabel.maxX+10, 8, 2, 14);
        line.backgroundColor = kWhiteColor;
        [_timeView addSubview:line];
        
        UILabel *prompt = [[UILabel alloc]init];
        prompt.frame = CGRectMake(line.maxX+10, 0, 50, _timeView.height);
        prompt.text = @"跳过";
        prompt.font = kFontSize(17);
        prompt.textColor = kWhiteColor;
        [_timeView addSubview:prompt];
    }
    return _timeView;
}

@end
