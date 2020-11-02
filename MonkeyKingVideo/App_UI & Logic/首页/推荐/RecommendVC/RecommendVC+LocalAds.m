//
//  RecommendVC+LocalAds.m
//  MonkeyKingVideo
//
//  Created by hansong on 10/16/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//
#import "RecommendVC+Private.h"


@implementation RecommendVC (LocalAds)
- (void)goToAD3{
//    @weakify(self)
//    [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
//        //设置广告的类型
//        imgAdView.backgroundColor = [UIColor clearColor];
//        imgAdView.getLBlaunchImageAdViewType(LogoAdType);
//        imgAdView.localAdImgName = @"广告页.jpg";
//        imgAdView.adTime = 4;
//        //自定义跳过按钮
//        imgAdView.skipBtn.backgroundColor = [UIColor blackColor];
//        //各种点击事件的回调
//        imgAdView.clickBlock = ^(clickType type){
//           @strongify(self)
//            switch (type) {
//                case clickAdType:{
////                    NSLog(@"点击广告回调");
//                    [self clickAd];
//                }break;
//                case skipAdType:{
////                    NSLog(@"点击跳过回调");
//                    [self skipAd];
//                }break;
//                case overtimeAdType:{
////                    NSLog(@"倒计时完成后的回调");
//                    [self overtimeAd];
//                }break;
//                default:
//                    break;
//            }
//        };
//    }];
}
- (void)clickAd{
//    NSURL * url = [NSURL URLWithString:@"tingyun.75://"];
//    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
//    //先判断是否能打开该url
//    if (canOpen){//打开微信
//        [[UIApplication sharedApplication] openURL:url];
//    }else {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mkSkipHQAppString]
//                                           options:@{}
//                                 completionHandler:nil];
//    }
}
- (void)skipAd{
//    [self gotoAD2];
}
- (void)overtimeAd{
//    [self gotoAD2];
}
@end
