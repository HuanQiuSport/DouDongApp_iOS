//
//  RecommendVC+Ads2.m
//  MonkeyKingVideo
//
//  Created by hansong on 10/16/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "WPAlertControl.h"
#import "WPView.h"
@implementation RecommendVC (Ads2)
- (void)gotoAD2{
    @weakify(self)
    WPView *view1 = [WPView viewWithTapClick:^(id other) {
        @strongify(self)
//        [self mkLoginAlert];
    }];

    view1.tap = ^(id other) {
        [WPAlertControl alertHiddenForRootControl:self completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
            switch (status) {
                    
                case WPAnimateWillAppear:
                    
                    
                    break;
                case WPAnimateDidAppear:
                    
                    break;
                case WPAnimateWillDisappear:
                     
                    break;
                case WPAnimateDidDisappear:
                {
                    [self.player.currentPlayerManager play];
        
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
                    break;
            }
        }];
        
    };
    view1.frame = CGRectMake(0, 0, kScreenWidth,kScreenHeight);
    view1.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:view1.frame];
    image.image = [UIImage imageNamed:@"广告图"];
    [view1 addSubview:image];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-80*KDeviceScale,kStatusBarHeight,60*KDeviceScale,22*KDeviceScale)];
    [button titleLabel].font = [UIFont systemFontOfSize:10 weight:UIFontWeightThin];
    [button addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
        NSLog(@"%@",@"点击跳过");
//        [[[WPAlertControl alloc] init] dismissViewControllerAnimated:YES completion:^{
//            NSLog(@"点击了跳过回调");
//        }];
         [WPAlertControl alertHiddenForRootControl:self completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
             
         }];
    }];
    button.backgroundColor = [UIColor redColor];
    [view1 addSubview:button];
    button.layer.cornerRadius = 11*KDeviceScale;
    button.layer.masksToBounds = YES;
    button.backgroundColor = kHexRGB(0x101010);
    button.titleColor = [UIColor whiteColor];
    [button setTitle:@"4" forState:UIControlStateNormal];
     
    if ([[[SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers lastObject] isKindOfClass:[DoorVC class]]) {
//        NSLog(@"你他妹的手那么快干啥子呦");
        return;
    }
    [WPAlertControl alertForView:view1
                           begin:WPAlertBeginCenter
                             end:WPAlertEndCenter
                     animateType:WPAlertAnimateBounce
                        constant:0
            animageBeginInterval:0.3
              animageEndInterval:0.1
                       maskColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
                             pan:YES
                     rootControl:self
                       maskClick:^BOOL(NSInteger index, NSUInteger alertLevel, WPAlertControl *alertControl) {
        @strongify(self)
        if ([self.player.currentPlayerManager isPlaying]) {
            [self.player.currentPlayerManager pause];
            
        };
        return NO;
    }animateStatus:nil];
    __block NSInteger second = 3;
    //(1)
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //(2)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //(3)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //(4)
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second == 0) {
                button.userInteractionEnabled = YES;
                [button setTitle:[NSString stringWithFormat:@"0｜跳转"] forState:UIControlStateNormal];
                second = 3;
                dispatch_cancel(timer);
                [[[WPAlertControl alloc] init] dismissViewControllerAnimated:YES completion:^{}];
            
            } else {
                button.userInteractionEnabled = NO;
                [button setTitle:[NSString stringWithFormat:@"%ld｜跳转",second] forState:UIControlStateNormal];
                second--;
            }
        });
    });
    //(5)
    dispatch_resume(timer);

}
@end
