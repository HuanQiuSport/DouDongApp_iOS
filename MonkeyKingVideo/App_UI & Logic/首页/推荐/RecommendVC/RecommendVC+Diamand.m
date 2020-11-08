//
//  RecommendVC+Diamand.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+Diamand.h"
#import "RecommendVC+Notification.h"
#pragma clang diagnostic push

#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation RecommendVC (Diamand)
///  添加宝盒
-(void)mkAddLauchBaoHe{
    self.mkDiamondsView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.mkDiamondsView];
    
    self.mkDiamondsView.mkImageView.image = KIMG(@"筹码");
    CGFloat offsetY = KDeviceScale *62;
    if( [UIScreen mainScreen].bounds.size.height <= 667) {
        offsetY = 0;
    }
    [self.mkDiamondsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(0*KDeviceScale));
        
        make.centerY.equalTo(self.view.mas_centerY).offset(offsetY);
        
        make.width.height.equalTo(@(88*KDeviceScale));
        
    }];
    self.mkDiamondsView.hidden = NO;
    
    [self.mkDiamondsView addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
       
        NSURL * url = [NSURL URLWithString:@"tingyun.75://"]; //如果是企业签名包需要先授信
        BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:url];
//
        NSURL * url2 = [NSURL URLWithString:@"hqsitety://"];
        BOOL canOpen2 = [[UIApplication sharedApplication] canOpenURL:url2];
//
        //先判断是否能打开该url
        if (canOpen){//打开微信
//            [MBProgressHUD wj_showSuccess:@"正在打开环球体育APP"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:url];
//            });
        }else {
//            [MBProgressHUD wj_showSuccess:@"正在下载环球体育APP"];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//            });
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mkSkipHQAppString]
                                               options:@{}
                                     completionHandler:nil];
        }
    }];
    
}


/// 设置宝盒时间
- (void)mkSettingBaeHe:(NSInteger)time{
    
//    [self.mkDiamondsView resetTime:time];
    
}

///  移除宝盒
- (void)mkRemoveBaoHe{
    
//    [self.mkDiamondsView removeFromSuperview];
    
}

@end
#pragma clang diagnostic pop
