//
//  AppDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AppDelegate.h"
//#import "VideoHandleTool.h"

@interface AppDelegate ()
@property(nonatomic,strong)RACSignal *reqSignal;

@end

@implementation AppDelegate

static AppDelegate *static_appDelegate = nil;
+(AppDelegate *)sharedInstance{
    @synchronized(self){
        if (!static_appDelegate) {
            static_appDelegate = AppDelegate.new;
        }
    }return static_appDelegate;
}

-(instancetype)init{
    if (self = [super init]) {
        static_appDelegate = self;
    }return self;
}
- (void)reachabilityChanged:(NSNotification *)notify{
    
}
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDarkContent animated:YES];
    [SkinManager manager].skin = MKSkinWhite;
    /*
     * 禁止App系统文件夹document同步
     * 苹果要求：可重复产生的数据不得进行同步,什么叫做可重复数据？这里最好禁止，否则会影响上架，被拒！
     */
    [FileFolderHandleTool banSysDocSynchronization];
    
//    [[KSYHTTPProxyService sharedInstance] startServer];
    
    // AWS SDK
//    [self configAWS];
    // Override point for customization after application launch.
    #if DEBUG
        /**
         *  宏忽略警告-+         */
        SuppressPerformSelectorLeakWarning(
                                           id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
                                           [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
                                           );
    #endif
#pragma mark —— 网络监控
    [FMARCNetwork.sharedInstance AFNReachability];
#pragma mark —— 沙盒路径
    NSString *directory = NSHomeDirectory();
//    NSLog(@"沙盒路径 : %@", directory);
#pragma mark —— 配置导航栏属性
    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];

    // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
    reach.reachableOnWWAN = NO;

    // Here we set up a NSNotification observer. The Reachability that caused the notification
    // is passed in the object parameter
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];

    [reach startNotifier];
    dispatch_async(dispatch_get_main_queue(), ^{
         [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityChangedNotification
                                                             object:self];
     });
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        configure.gk_translationX = 15;
        configure.gk_translationY = 20;
        configure.gk_scaleX = 0.90;
        configure.gk_scaleY = 0.92;
        // 导航栏背景色
        configure.backgroundColor = UIColor.whiteColor;
        // 导航栏标题颜色
        configure.titleColor = UIColor.blackColor;
        // 导航栏标题字体
        configure.titleFont = [UIFont systemFontOfSize:18.0f];
        // 导航栏返回按钮样式
        configure.backStyle = GKNavigationBarBackStyleBlack;
        // 导航栏左右item间距
        configure.gk_navItemLeftSpace = 12.0f;
        configure.gk_navItemRightSpace = 12.0f;
        
        configure.shiledItemSpaceVCs = @[@"PUPhotoPickerHostViewController"];
    }];
#pragma mark —— 配置键盘全局
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 启用手势触摸:控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义,(使用TextField的tintColor属性IQToolbar，否则色调的颜色是黑色 )
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条,当需要支持内联编辑(Inline Editing), 这就需要隐藏键盘上的工具条(默认打开)
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
    //如果系统版本低于iOS 13.0 则运行以下代码
    if (@available(iOS 13.0, *)) {

    }else{
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        self.window.rootViewController = self.navigationController;
        [self.window makeKeyAndVisible];
    }
    [self postChannle];
    return YES;
}
//系统版本低于iOS13.0的设备
-(void)applicationDidEnterBackground:(UIApplication *)application{
//    NSLog(@"---applicationDidEnterBackground----"); //进入后台
    
    if ([NSObject didUserPressLockButton]) {
         //User pressed lock button
//          NSLog(@"Lock screen.");
        CustomSYSUITabBarController *tbvc = [SceneDelegate sharedInstance].customSYSUITabBarController;
        [NSObject showSYSAlertViewTitle:@"App——1"
                                message:@""
                        isSeparateStyle:NO
                            btnTitleArr:@[@"好的"]
                         alertBtnAction:@[@""]
                               targetVC:tbvc
                           alertVCBlock:^(id data) {
            //DIY
        }];
     } else {
//          NSLog(@"Home.");
         //user pressed home button
         CustomSYSUITabBarController *tbvc = [SceneDelegate sharedInstance].customSYSUITabBarController;
         [NSObject showSYSAlertViewTitle:@"APP_2"
                                 message:@""
                         isSeparateStyle:NO
                             btnTitleArr:@[@"好的"]
                          alertBtnAction:@[@""]
                                targetVC:tbvc
                            alertVCBlock:^(id data) {
             //DIY
         }];
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
//系统版本低于iOS13.0的设备
-(void)applicationDidBecomeActive:(UIApplication *)application {
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
#pragma - mark AWS SDK
//- (void)configAWS {
//    AWSEndpoint *EndPoint = [[AWSEndpoint alloc] initWithURLString:@"http://www.akixr.top:8080"];
//    
//    AWSBasicSessionCredentialsProvider *provider =
//    [[AWSBasicSessionCredentialsProvider alloc] initWithAccessKey:@"AKIAIOSFODNN7EXAMPLE"
//                                                        secretKey:@"JalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
//                                                     sessionToken:@"latest"];
//    //如果有identityPoolId，可以使用identityPoolId设置
//    //AWSCognitoCredentialsProvider *provider = [[AWSCognitoCredentialsProvider alloc] initWithRegionType:AWSRegionUSEast1 identityPoolId:POOL_ID];
//    
//    AWSServiceConfiguration *configuration =
//    [[AWSServiceConfiguration alloc] initWithRegion:AWSRegionUSEast1
//                                           endpoint:EndPoint
//                                credentialsProvider:provider];
//    
//    AWSServiceManager.defaultServiceManager.defaultServiceConfiguration = configuration;
//}
#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration"
                                          sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application
didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

//- (void) application:(UIApplication *)application
//   handleEventsForBackgroundURLSession:(NSString *)identifier
//   completionHandler:(void (^)(void))completionHandler {
//       
//       //provide the completionHandler to the TransferUtility to support background transfers.
//       [AWSS3TransferUtility interceptApplication:application
//              handleEventsForBackgroundURLSession:identifier
//                                completionHandler:completionHandler];
//}

- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application{
//    [MBProgressHUD wj_showError:@"退出锁屏"];
}
- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application API_AVAILABLE(ios(4.0)){
//    [MBProgressHUD wj_showError:@"进入锁屏"];
}
#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;
- (NSPersistentCloudKitContainer *)persistentContainer  API_AVAILABLE(ios(13.0)){
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"MonkeyKingVideo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
//                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }return _persistentContainer;
}
#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
#pragma mark —— lazyLoad
-(CustomSYSUITabBarController *)customSYSUITabBarController{
    if (!_customSYSUITabBarController) {
        _customSYSUITabBarController = CustomSYSUITabBarController.new;
    }return _customSYSUITabBarController;
}

-(UINavigationController *)navigationController{
    if (!_navigationController) {
//        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.customSYSUITabBarController];
        _navigationController = [UINavigationController rootVC:self.customSYSUITabBarController
                                               transitionScale:NO];
        _navigationController.navigationBar.hidden = YES;
    }return _navigationController;
}

#pragma mark
- (void)postChannle{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{
        @"deviceId":UDID,
        @"origin":@(originType_Apple),
        @"version":HDAppVersion,
        @"channelUrl":[URL_Manager sharedInstance].channelUrl
    }];
    if([self isFristpostChannle]) {
        [dic setValue:@"1" forKey:@"first"];
    }
    dispatch_async(dispatch_queue_create("startTime", DISPATCH_QUEUE_SERIAL), ^{
        FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                               path:[URL_Manager sharedInstance].MKStartTimePOST
                                                         parameters:dic];
        self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
        [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
            NSLog(@"%@",response.reqResult);
            if(response.code == 200) {
                [self completeFristpostChannle];
            }
        }];
    });
}

-(BOOL)isFristpostChannle {
    NSString *frist = [[NSUserDefaults standardUserDefaults] valueForKey:@"fristpostChannle"];
    if(frist == nil) {
        return true;
    }
    return false;
}

-(void)completeFristpostChannle {
    [[NSUserDefaults standardUserDefaults] setValue:@"fristpostChannle" forKey:@"fristpostChannle"];
}

@end
