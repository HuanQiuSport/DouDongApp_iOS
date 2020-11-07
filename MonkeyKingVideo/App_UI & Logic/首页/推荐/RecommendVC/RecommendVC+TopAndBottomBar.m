//
//  RecommendVC+TopAndBottomBar.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "RecommendVC+TopAndBottomBar.h"
#import "RecommendVC+Private.h"
@implementation RecommendVC (TopAndBottomBar)
#pragma mark - 是否显示顶部导航条
- (void)mkSetNavi{
    switch (self.mkVideoListType) {
        case MKVideoListType_A:{
              self.gk_navigationBar.hidden = YES;
              self.gk_statusBarHidden = YES;
            [self mkAddLauchBaoHe]; // 右边
            if ([MKTools mkLoginIsLogin]) {
               
            }else{
                [self mkAddShuaCoin];   // 左边
            }
            
           
        }break;
        case MKVideoListType_B:{
            self.gk_navigationBar.hidden = NO;
            self.gk_statusBarHidden = NO;
            [self hideNavLine];
            
        }break;
        case MKVideoListType_C:{
            self.gk_navigationBar.hidden = NO;
            self.gk_statusBarHidden = NO;
            [self hideNavLine];
        }break;
        case MKVideoListType_D:{
            self.gk_navigationBar.hidden = NO;
            self.gk_statusBarHidden = NO;
            [self hideNavLine];
        }break;
    }
}
#pragma mark -  发送到最前面的视图   由于是自定义的navi bar 相当于一个view ，它先添加到self.view 上，后面的播放器视图添加再navi bar 之上，所以navi bar view 就看不到了，需要通过调整视图的Z 值来达到显示的目的
- (void)sendNavibarToFront{
     [self.view bringSubviewToFront:self.gk_navigationBar]; 
}
- (NSInteger)isHomeVCInRecommendVC{
    
    NSArray *array = [[SceneDelegate sharedInstance].customSYSUITabBarController.viewControllers.firstObject childViewControllers];
    
    NSArray *array2 =  [[[[[[SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers.firstObject childViewControllers]
                           firstObject] childViewControllers] firstObject] childViewControllers];
    
    NSArray *array3 = [AppDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers;
    if (@available(iOS 13.0, *)) {
        array3 = [SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers;
    }
    NSArray *mkArray =  [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeCurrentView"];
    NSNumber *mkHomeIndexView = mkArray.firstObject;
    BOOL mkIsHomeRecommend = [mkHomeIndexView boolValue];
//    NSLog(@"🔥🔥%@",array2);
    @try {
        return array3.count;
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
    return 0;
}
#pragma mark -  是否可以获取金币
- (BOOL)mkIsCanGetCoin{
    if([SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex == 0){
        if([self isHomeVCInRecommendVC] == 1){
            NSArray *mkArray =  [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeCurrentView"];
            NSNumber *mkHomeIndexView = mkArray.firstObject;
            BOOL mkIsHomeRecommend = [mkHomeIndexView boolValue];
            if (mkIsHomeRecommend) {
                return  YES;
            }else{
//                NSLog(@"不在推荐列表没有福利");
                return NO;
            }
        }else{
//            NSLog(@"不在首页没有福利");
            return NO;
        }
    }else{
//        NSLog(@"不在首页模块没有福利");
        return NO;
    }
}


@end
//[[SceneDelegate sharedInstance].customSYSUITabBarController.viewControllers.firstObject childViewControllers]
//<__NSSingleObjectArrayI 0x109739d50>(
//<JXCategoryListContainerViewController: 0x10930a080>
//)
//po [0x1094b8680 childViewControllers]
//<__NSSingleObjectArrayI 0x10976d510>(
//<JXCategoryListContainerViewController: 0x10930a080>
//)
#pragma mark - 推荐 | 关注 
//po [SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers
//<__NSSingleObjectArrayI 0x130703c70>(
//<CustomSYSUITabBarController: 0x10b8b0480>
//)
#pragma mark - 推荐 ->登录
//(lldb) po [SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers
//<__NSArrayI 0x13144bc10>(
//<CustomSYSUITabBarController: 0x10b8b0480>,
//<DoorVC: 0x1139bc280>
//)
#pragma mark - 推荐 ->登录->忘记密码
//(lldb) po [SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers
//<__NSArrayI 0x12ef09a90>(
//<CustomSYSUITabBarController: 0x10b8b0480>,
//<DoorVC: 0x1139bc280>,
//<ForgetCodeVC: 0x12a023a80>
//)
#pragma mark - 关注 ->登录->忘记密码
//(lldb) po [SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers
//<__NSArrayI 0x13149fe50>(
//<CustomSYSUITabBarController: 0x10b8b0480>,
//<DoorVC: 0x12ad0b980>
//)
#pragma mark - 关注 ->登录->忘记密码
//(lldb) po [SceneDelegate sharedInstance].customSYSUITabBarController.navigationController.viewControllers
//<__NSArrayI 0x12b174410>(
//<CustomSYSUITabBarController: 0x10b8b0480>,
//<DoorVC: 0x12ad0b980>,
//<ForgetCodeVC: 0x12a08f780>
//)
#pragma mark - 四个导航
//(lldb) po [SceneDelegate sharedInstance].customSYSUITabBarController.viewControllers
//<__NSArrayM 0x114e976d0>(
//<HomeVC: 0x10b8ba480>,
//<CommunityVC: 0x10b8b9f80>,
//<PhotoVC: 0x10b8b9a80>,
//<TaskVC: 0x10b8b9080>,
//<MKMineVC: 0x10b8b8b80>
//)
