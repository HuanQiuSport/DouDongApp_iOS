//
//  SceneDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "SceneDelegate+LaunchingAd.h"
#import "EditUserInfoVC.h"
#import "MKAdvertisingController.h"

API_AVAILABLE(ios(13.0))

@interface SceneDelegate ()

@end

@implementation SceneDelegate

static SceneDelegate *static_sceneDelegate = nil;
+(SceneDelegate *)sharedInstance{
    @synchronized(self){
        if (!static_sceneDelegate) {
            static_sceneDelegate = SceneDelegate.new;
        }
    }return static_sceneDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_sceneDelegate = self;
        self.launchingAdPathStr = [[FileFolderHandleTool cachesDir] stringByAppendingPathComponent:@"LaunchingAd"]; // /Library/caches
    }return self;
}

-(void)KKK:(NSNotification *)noti{
    NSNumber *b = noti.object;
    if (b.intValue == AFNetworkReachabilityStatusNotReachable) {
        [MBProgressHUD wj_showPlainText:@"没有网络连接"
                                   view:nil];
    }
}

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions  API_AVAILABLE(ios(13.0)){
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    [self clearAllUserDefaultsData];
        //在这里手动创建新的window
        if (@available(iOS 13.0, *)) {
            self.windowScene = (UIWindowScene *)scene;
        }
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES]; 
#pragma mark —— 启动图
    
    [self localAd];
}

- (void)sceneDidDisconnect:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}

- (void)sceneDidBecomeActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
//    NSLog(@"---applicationDidBecomeActive----");//进入前台
    extern ZFPlayerController *ZFPlayer_DoorVC;
    extern ZFPlayerController *ZFPlayer_ForgetCodeVC;
    if (ZFPlayer_DoorVC) {
        [ZFPlayer_DoorVC.currentPlayerManager play];
    }
    if (ZFPlayer_ForgetCodeVC) {
        [ZFPlayer_ForgetCodeVC.currentPlayerManager play];
    }
}

- (void)sceneWillResignActive:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
//    NSLog(@"");
    [self userTimeEnd];
//    if (![MKTools mkLoginIsLogin]) {
//
//    }
    
}

- (void)sceneWillEnterForeground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
//    NSLog(@"");
    [self userTimeStart];
}

- (void)sceneDidEnterBackground:(UIScene *)scene  API_AVAILABLE(ios(13.0)){
    [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
//    NSLog(@"---applicationDidEnterBackground----"); //进入后台
    
    if ([NSObject didUserPressLockButton]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MKLockScreenNotification object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:MKNoLockScreenNotification object:nil];
    }
    
    extern ZFPlayerController *ZFPlayer_DoorVC;
    extern ZFPlayerController *ZFPlayer_ForgetCodeVC;
    if (ZFPlayer_DoorVC) {
        [ZFPlayer_DoorVC.currentPlayerManager pause];
    }
    if (ZFPlayer_ForgetCodeVC) {
        [ZFPlayer_ForgetCodeVC.currentPlayerManager pause];
    }
}


#pragma mark —— lazyLoad
-(CustomSYSUITabBarController *)customSYSUITabBarController{
    if (@available(iOS 13.0, *)) {
        if (!_customSYSUITabBarController) {
            _customSYSUITabBarController = CustomSYSUITabBarController.new;
        }return _customSYSUITabBarController;
    } else {
        return [AppDelegate sharedInstance].customSYSUITabBarController;
    }
   
}

-(UINavigationController *)navigationController{
    if (@available(iOS 13.0, *)) {
    if (!_navigationController) {
        //        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.customSYSUITabBarController];
        //        _navigationController = [UINavigationController rootVC:self.customSYSUITabBarController
        //                                               transitionScale:NO];
        _navigationController = [UINavigationController rootVC:self.customSYSUITabBarController];
        _navigationController.navigationBar.hidden = YES;
    }return _navigationController;
    } else {
        return [AppDelegate sharedInstance].navigationController;
    }
}

- (NSMutableArray *)selectIndexArr {
    if (!_selectIndexArr) {
        _selectIndexArr  = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectIndexArr;
}

/**
 *  清除所有的存储本地的数据
 */
- (void)clearAllUserDefaultsData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic) {
        if ([[NSString stringWithFormat:@"%@",key] isEqualToString:@"Acc"]|| [[NSString stringWithFormat:@"%@",key] isEqualToString:@"Password"]) {
            break;
        }
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

@end
