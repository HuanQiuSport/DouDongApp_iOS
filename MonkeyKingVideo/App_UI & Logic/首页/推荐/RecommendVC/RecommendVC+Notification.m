//
//  RecommendVC+Notification.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+Notification.h"

#pragma clang diagnostic push

#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
static BOOL isCreate = YES;
@implementation RecommendVC (Notification)
///第一桢渲染成功通知  后台播放相关通知     播放状态更改用户或者程序 退出录成功通知
-(void)addNotification{
    if (isCreate == YES) {
        isCreate = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self // 登录成功通知
                                                     selector:@selector(loginSuccess)
                                                         name:KLoginSuccessNotifaction
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self // 退出登录通知
                                                     selector:@selector(logOutSuccess)
                                                         name:KLoginOutNotifaction
                                                       object:nil];
           
            [[NSNotificationCenter defaultCenter] addObserver:self //从活动状态进入非活动状态
                                                     selector:@selector(applicationWillResignActive:)
                                                         name:UIApplicationWillResignActiveNotification
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self //程序进入前台并处于活动状态时调用
                                                     selector:@selector(applicationDidBecomeActive:)
                                                         name:UIApplicationDidBecomeActiveNotification
                                                       object:nil];
             
        //    [[NSNotificationCenter defaultCenter] addObserver:self ///打开宝盒
        //                                             selector:@selector(canOpenDiamonds)
        //                                                 name:MKOpenDiamondNotification
        //                                               object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self   /// 刷币
                                                     selector:@selector(canGetCoin)
                                                         name:MKCanCoinNotification object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self //点击home
                                                     selector:@selector(didHomeVC)
                                                         name:MKHomeNotification
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self //点击社区
                                                     selector:@selector(didNoHomeVC)
                                                         name:MKCommunityNotification
                                                       object:nil];
            
            
            [[NSNotificationCenter defaultCenter] addObserver:self //点击拍摄
                                                     selector:@selector(didNoHomeVC)
                                                         name:MKShotNotification
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self //点击赚钱
                                                     selector:@selector(didNoHomeVC)
                                                         name:MKLucrativeNotification
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self //点击我的
                                                     selector:@selector(didNoHomeVC)
                                                         name:MKMineNotification
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self //锁屏
                                                     selector:@selector(mkLockHander)
                                                         name:MKLockScreenNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self //开屏
                                                     selector:@selector(mkNoLockHander)
                                                         name:MKNoLockScreenNotification
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self //
                                                     selector:@selector(mkSingleTapHander)
                                                         name:MKSingleTapNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self //
                                                     selector:@selector(mkSingleHander)
                                                         name:MKSingleHanderNotification
                                                       object:nil];
            
            [[NSNotificationCenter defaultCenter] addObserver:self //
                                                     selector:@selector(test)
                                                         name:@"testAttentionVC"
                                                       object:nil];
    }
//    else {
//        <#statements#>
//    }
    

}
/// 页面消失也可以存在的通知
-(void)addDidDisappearNotification{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MKCanCoinNotification object:nil]; // 删除刷币通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"testAttentionVC" object:nil]; // 删除关注测试通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MKMineNotification object:nil]; // 删除刷币通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MKLucrativeNotification object:nil]; // 删除刷币通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MKShotNotification object:nil]; // 删除刷币通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MKCommunityNotification object:nil]; // 删除刷币通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:MKCanCoinNotification object:nil]; // 删除刷币通知

}
- (void)test
{
    self.player.viewControllerDisappear = YES;
}
- (void)removeNotification{
    isCreate = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 通知事件处理
//从活动状态进入非活动状态
- (void)applicationWillResignActive:(NSNotification *)notification {
    if([self isPlayVideo]){
        if ([self mkIsCanGetCoin]) {
            self.lastIndex == self.index;
            [self.player.currentPlayerManager pause];
            [self.mkShuaCoinView stopAddCoin];
//            [self.mkDiamondsView stopAddDiamond];
            [self.mkshareview removeAllSubviews];
            [self.mkshareview removeFromSuperview];
            self.mkshareview = nil;
        }
        
    }
}

//程序进入前台并处于活动状态时调用
- (void)applicationDidBecomeActive:(NSNotification *)notification {
    if([self isPlayVideo]){
        if ([self mkIsCanGetCoin]) {
            if([SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex == 0){
                [self.player.currentPlayerManager play];
                 self.controlView.playBtn.hidden = YES;
            }
            if (self.mkFirstPlay) { //是 第一次播放
//                if (!self.mkDiamondsView.hidden) {
//                    [self.mkDiamondsView startAddDiamond];
//                }
                if (!self.mkShuaCoinView.hidden) {
                    [self.mkShuaCoinView startAddCoin];
                }
            }else{// 非 第一次播放
                if(self.index == self.lastIndex ){
//                    if (!self.mkDiamondsView.hidden) {
//                        [self.mkDiamondsView stopAddDiamond];
//                    }
                    if (!self.mkShuaCoinView.hidden) {
                        [self.mkShuaCoinView stopAddCoin];
                    }
                }
            }
          
        }else{
            
        }
    }
}


#pragma mark - 首页抖币和宝箱开关
- (void)mkSingleTapHander{
    
    if([self isPlayVideo]){
        
        if (self.mkFirstPlay) {
            
            if (!self.mkShuaCoinView.hidden) {
                NSLog(@"mkSingleTapHander");
//                [self.mkShuaCoinView.timerExample3 start];
            }
            
//            if (!self.mkDiamondsView.hidden) {
//
//                [self.mkDiamondsView.timerExample3 start];
//            }
        }
    }
}
#pragma mark - 首页刷新当前推荐数据
- (void)mkSingleHander{

   
}
- (void)didHomeVC{ // 点击home
//    NSLog(@"点击home");
    NSArray *mkArray =  [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeCurrentView"];
    NSNumber *mkHomeIndexView = mkArray.firstObject;
    BOOL mkIsHomeRecommend = [mkHomeIndexView boolValue];
    if (![self.player.currentPlayerManager isPlaying]) {
        if (mkIsHomeRecommend) {
            [self playTheIndex:self.index];
        }
    }
   
    if([MKTools mkLoginIsLogin]){
       
    }else{
        [self goldNumSwitch];
        if (self.mkVideoListType == MKVideoListType_A) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([self.player.currentPlayerManager isPlaying]) {
                    if (mkIsHomeRecommend) {
                        [self.player.currentPlayerManager play];
                        self.controlView.playBtn.hidden = YES;
                    }
                }
            });
        }
        [self.controlView.sliderView startAnimating];
    }
}
- (void)didNoHomeVC{ // 点击社区 ｜ 赚币 ｜ 我的 ｜ 拍摄
    [self.player.currentPlayerManager pause];
    NSLog(@"点击社区 ｜ 赚币 ｜ 我的 ｜ 拍摄");
}
- (void)mkLockHander{
   
}
- (void)mkNoLockHander{
   
}

- (void)loginSuccess {
//    [self.mkDiamondsView removeFromSuperview];
    [self.mkShuaCoinView removeFromSuperview];
    [self.tableView removeFromSuperview];
    self.index = 0; // 登录之后重置未0
    self.mkRecommend = nil;
    self.videoDemandModel = nil;
    [self.player.currentPlayerManager pause];
    [self.player.currentPlayerManager stop];
    [self.view addSubview:self.tableView];
    [self initPlayer];
    [self mkSetNavi];
    if([MKTools mkLoginIsLogin]){
        
    }else{
//        [self.mkDiamondsView resetTime];
        [self.mkShuaCoinView resetTime];
        [self goldNumSwitch];
    }
}
- (void)logOutSuccess {
    [self.tableView removeFromSuperview];
    self.mkRecommend = nil;
    self.videoDemandModel = nil;
    [self.player.currentPlayerManager pause];
    [self.player.currentPlayerManager stop];
    [self.view addSubview:self.tableView];
    [self initPlayer];
//    [self.mkDiamondsView removeFromSuperview];
    [self.mkShuaCoinView removeFromSuperview];
    [self.mkShuaCoinView clearCoin];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MKTools mkGetAttentionArrayOfCurrentLoginAllDelete];
            [MKTools mkGetLikeVideoArrayOfCurrentLoginAllDelete];
        });
    });
  
 
    
}

- (void)canGetCoin{
    if([MKTools mkLoginIsLogin]){
        NSLog(@"mkLoginIsLogin");
        return;
    }
    if (self.mkShuaCoinView.hidden) {
        NSLog(@"mkShuaCoinView.hidden");
        return;
    }
    if(self.mkVideoListType == MKVideoListType_A){
        NSLog(@"self.mkVideoListType == MKVideoListType_A");
    }else{
        NSLog(@"self.mkVideoListType != MKVideoListType_A");
        return;
    }
    NSLog(@"OpenCoin");
    MKLoginModel *model2 = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
    
    NSString *timeStr = [MKKeyAndSecreetTool getNowTimeTimestamp3];
    
    timeStr = [NSString stringWithFormat:@"%@%@",timeStr,@"niGMYaqV6r"];
    
    NSDictionary *dic  = (NSDictionary*)self.playRecordArray.lastObject;
    
    [self.playRecordArray removeAllObjects];
    
    [self.playRecordArray addObject:dic];
    
    model2.coinStartPlayTime = [[NSString alloc]initWithString:[NSString stringWithFormat:@"%@", [MKKeyAndSecreetTool encodeString:timeStr]]];
    
    [[MKLoginModel getUsingLKDBHelper] insertToDB:model2 callback:^(BOOL result) {}];
    [self OpenCoin];
}
- (void)canOpenDiamonds{
    if([MKTools mkLoginIsLogin]){
        return;
    }
//    if(self.mkDiamondsView.hidden){
//        return;
//    }
    if(self.mkVideoListType == MKVideoListType_A){
        
    }else{
        return;
    }
    MKLoginModel *model2 = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
    
    NSString *timeStr = [MKKeyAndSecreetTool getNowTimeTimestamp3];
    
    timeStr = [NSString stringWithFormat:@"%@%@",timeStr,@"niGMYaqV6r"];
    
    NSDictionary *dic  = (NSDictionary*)self.playRecordArray.lastObject;
    
    [self.playRecordArray removeAllObjects];
    
    [self.playRecordArray addObject:dic];
    
    model2.diamondsStartPlayTime = [NSString stringWithFormat:@"%@", [MKKeyAndSecreetTool encodeString:timeStr]];
    
    [[MKLoginModel getUsingLKDBHelper] insertToDB:model2 callback:^(BOOL result) {NSLog(@"更新宝箱开始时间%@",result?@"成功":@"失败");}];
    
    [self OpenDiamonds];
}
@end
#pragma clang diagnostic pop
