//
//  RecommendVC+MKMoney.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/4/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+MKMoney.h"
#import "MKShuaCoinView.h"
#pragma clang diagnostic push

#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation RecommendVC (MKMoney)
///  添加宝盒
-(void)mkAddShuaCoin{
    /*
     [MKAnimations moveUp:self.mkHomeCoinView andAnimationDuration:1.0 andWait:YES andLength:20];
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         @strongify(self)
         self.mkHomeCoinView.frame = CGRectMake(0, 0,100,30);
         self.mkHomeCoinView.hidden = YES;
     });
     */
    self.mkShuaCoinView.mkImageView.image = KIMG(@"mk_红包");
//    WeakSelf
//    [self.mkShuaCoinView addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
//        [weakSelf.mkShuaCoinView opencoin];
//    }];
    [self.view addSubview:self.mkShuaCoinView];
    
    [self.mkShuaCoinView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(20*KDeviceScale));
        
        make.centerY.equalTo(self.view.mas_centerY).offset(0*KDeviceScale);
        
        make.width.height.equalTo(@(80*KDeviceScale));
        
    }];
    
    [self mkSettingShuaCoin:30];
    self.mkShuaCoinView.hidden = YES;
    
}
/// 设置宝盒时间
- (void)mkSettingShuaCoin:(CGFloat)time{
    
//       [self.mkShuaCoinView resetTime:time];
  
}

///  移除宝盒
- (void)mkRemoveShuaCoin{
    
    [self.mkShuaCoinView removeFromSuperview];
    
}
@end
#pragma clang diagnostic pop
