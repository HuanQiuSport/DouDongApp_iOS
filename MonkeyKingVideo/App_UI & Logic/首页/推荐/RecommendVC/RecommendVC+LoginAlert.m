//
//  RecommendVC+LoginAlert.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/10/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+LoginAlert.h"
#import "WPAlertControl.h"
#import "WPView.h"
@implementation RecommendVC (LoginAlert)
- (void)mkLoginAlert{
    @weakify(self)
    WPView *view1 = [WPView viewWithTapClick:^(id other) {
        @strongify(self)
        [self.player.currentPlayerManager play];
    }];

    view1.tap = ^(id other) {
        [WPAlertControl alertHiddenForRootControl:self completion:^(WPAlertShowStatus status, WPAlertControl *alertControl) {
            switch (status) {
                    
                case WPAnimateWillAppear:
                    [self.player.currentPlayerManager play];
                    
                    break;
                case WPAnimateDidAppear:
                    
                    break;
                case WPAnimateWillDisappear:
                    
                    break;
                case WPAnimateDidDisappear:
                {
                    WeakSelf
                    [MKTools mkLoginIsYESWith:weakSelf];
                }
                    break;
            }
        }];
        
    };
    view1.frame = CGRectMake(0, 0, 272*KDeviceScale, 395*KDeviceScale);
    view1.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:view1.frame];
    image.image = KIMG(@"登录弹窗");
    [view1 addSubview:image];
    
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
            self.controlView.playBtn.hidden = NO;
//            [self.controlView.playBtn sendSubviewToBack:self.view];
        };
        return NO;
    }
                   animateStatus:nil];
}

@end
