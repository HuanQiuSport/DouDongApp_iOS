//
//  SceneDelegate+LaunchingAd.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "SceneDelegate+LaunchingAd.h"

@implementation SceneDelegate (LaunchingAd)
///如果需要网络请求得到URL
-(void)netWorkingAd{
//    http://172.24.135.208/taskpage/#/adverti
      [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
          
          
          /// 
          NSMutableDictionary *easyDict = [NSMutableDictionary dictionary];
          /// 
          FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                                 path:@"Room/GetHotLive_v2"
                                                           parameters:easyDict];
          RACSignal *reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
          [reqSignal subscribeNext:^(FMHttpResonse *response) {
              if (response.isSuccess) {
//                  NSLog(@"%p",response.reqResult);
//                  NSLog(@"--%@",response.reqResult);
                  //设置网络启动图片URL
                  imgAdView.imgUrl = @"";
                  //点击响应的url
                  imgAdView.advertUrl = @"";
                  //是否能点击
                  imgAdView.isClickAdView = YES;
                  //设置广告的类型
                  imgAdView.getLBlaunchImageAdViewType(LogoAdType);
                  //自定义跳过按钮
                  imgAdView.skipBtn.backgroundColor = [UIColor lightGrayColor];
                  imgAdView.skipBtn.alpha = 0.5;
                  [imgAdView.skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                  __block LBLaunchImageAdView *adView = imgAdView;
                  adView.backgroundColor = [UIColor clearColor];
                  imgAdView.clickBlock = ^(const clickType type) {
                      switch (type) {
                          case clickAdType:{
                              NSLog(@"点击广告回调");
                              if (adView.advertUrl.length > 10 && adView.isClickAdView) {
                                  [self clickAd];
                              }
                          }break;
                          case skipAdType:{
//                              NSLog(@"点击跳过回调");
                              [self skipAd];
                          }break;
                          case overtimeAdType:{
//                              NSLog(@"倒计时完成后的回调");
                              [self overtimeAd];
                          }break;
                          default:
                              break;
                    }
                };
              }
          }];
      }];
}
///如果直接是固定的图片Url
-(void)fixedAdPicsUrl{
    @weakify(self)
    [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
        //设置广告的类型
        imgAdView.getLBlaunchImageAdViewType(LogoAdType);
        //用户第一次进App，边下gif，一边播放本地默认的gif；除了第一次进App才播放默认的gif
        //第二次进直接播放上一个下载的gif，同时下载其他gif,下载成功删除上一个下载的gif
        BOOL isEmptyItemAtPath = [FileFolderHandleTool isEmptyItemAtPath:self.launchingAdPathStr
                                                                   error:nil];
        if (isEmptyItemAtPath) {//空文件夹：第一次进，或者上次下载不成功
            //设置本地启动图片
//            imgAdView.localAdImgName = @"启动页.gif";
            imgAdView.localAdImgName = @"启动图.png";
        }else{
            //本地遍历
            NSArray *arr = [FileFolderHandleTool listFilesInDirectoryAtPath:self.launchingAdPathStr
                                                                       deep:NO];
            NSString *resourcePathStr = [self.launchingAdPathStr stringByAppendingPathComponent:arr[0]];
            imgAdView.aDImgView.image = [UIImage imageWithContentsOfFile:resourcePathStr];
        }
        //下载 下次进来用
        [self netWorking_MKadInfoAdInfoGET];
        //自定义跳过按钮
        imgAdView.skipBtn.backgroundColor = [UIColor blackColor];
        //各种点击事件的回调
        imgAdView.clickBlock = ^(clickType type){
            @strongify(self)
            switch (type) {
                case clickAdType:{
//                    NSLog(@"点击广告回调");
                    [self clickAd];
                }break;
                case skipAdType:{
//                    NSLog(@"点击跳过回调");
                    [self skipAd];
                }break;
                case overtimeAdType:{
//                    NSLog(@"倒计时完成后的回调");
                    [self overtimeAd];
                }break;
                default:
                    break;
            }
        };
    }];
}

///如果是本地图片
-(void)localAdPic{
    @weakify(self)
    [NSObject makeLBLaunchImageAdView:^(LBLaunchImageAdView *imgAdView) {
        //设置广告的类型
        imgAdView.backgroundColor = [UIColor clearColor];
        imgAdView.getLBlaunchImageAdViewType(LogoAdType);
        imgAdView.localAdImgName = @"广告页.jpg";
        imgAdView.adTime = 4;
        //自定义跳过按钮
        imgAdView.skipBtn.backgroundColor = [UIColor blackColor];
        //各种点击事件的回调
        imgAdView.clickBlock = ^(clickType type){
            @strongify(self)
            switch (type) {
                case clickAdType:{
//                    NSLog(@"点击广告回调");
                    [self clickAd];
                }break;
                case skipAdType:{
//                    NSLog(@"点击跳过回调");
                    [self skipAd];
                }break;
                case overtimeAdType:{
//                    NSLog(@"倒计时完成后的回调");
                    [self overtimeAd];
                }break;
                default:
                    break;
            }
        };
    }];
}

- (void)localAd{
    [self.window setRootViewController:self.navigationController];
    [self.window makeKeyAndVisible];
}

#pragma mark —— 启动页触发事件
///点击广告回调
-(void)clickAd{
    if (@available(iOS 13.0, *)){
        [self.window setRootViewController:self.navigationController];
        [self.window makeKeyAndVisible];
    }
    NSString *url = mkSkipHQAppString;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]
                                       options:@{}
                             completionHandler:nil];
}

///点击跳过回调
-(void)skipAd{
    if (@available(iOS 13.0, *)){
        [self.window setRootViewController:self.navigationController];
        [self.window makeKeyAndVisible];
    }
}
///倒计时完成后的回调
-(void)overtimeAd{
    if (@available(iOS 13.0, *)){
        [self.window setRootViewController:self.navigationController];
        [self.window makeKeyAndVisible];
    }
}
///GET 查询开屏或视频广告
-(void)netWorking_MKadInfoAdInfoGET{
    /// 
    NSDictionary *easyDict = @{
        @"adType":@"0"//广告类型 0开屏广告 1视频广告
    };
    /// 
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKadInfoAdInfoGET
                                                     parameters:easyDict];
    RACSignal *reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
//            NSLog(@"%@",response.reqResult);
            self.launchingAdModel = [MKLaunchingAdModel mj_objectWithKeyValues:response.reqResult];
            //下载gif文件到本地 /Library/caches
            if ([FileFolderHandleTool isExistsAtPath:self.launchingAdPathStr]) {
                //文件夹存在
                if ([FileFolderHandleTool isEmptyItemAtPath:self.launchingAdPathStr
                                                      error:nil]) {
                    //空文件夹
//                    NSLog(@"");
                    [self netWorking_downLoadGif:self.launchingAdPathStr];
                }else{
                    //文件夹下面有文件，则删除之
                    [FileFolderHandleTool delFile:@[self.launchingAdPathStr]
                                       fileSuffix:nil];
                    //空文件夹
//                    NSLog(@"");
                    [self netWorking_downLoadGif:self.launchingAdPathStr];
                }
            }else{
                //文件夹不存在，那么进行创建
                BOOL FileFolder = [FileFolderHandleTool createDirectoryAtPath:self.launchingAdPathStr
                                                                        error:nil];
                if (FileFolder) {
                    //空文件夹
//                    NSLog(@"");
                    [self netWorking_downLoadGif:self.launchingAdPathStr];
                }else{
                    [NSException raise:@"失败的文件夹创建"
                                format:@"文件夹路径:%@创建不成功", self.launchingAdPathStr];
                }
            }
        }
    }];
}

-(void)netWorking_downLoadGif:(NSString *)pathStr{
    [[FMARCNetwork sharedInstance] downloadUrl:self.launchingAdModel.adImg
                              downloadFilePath:pathStr
                                       success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
    }
                                       failure:^(NSError *error) {
//        NSLog(@"error = %@",error);
    }];
}


#pragma mark -  活跃时长
//开始
- (void)userTimeStart{
    NSDate *nowDate = [NSDate date];
    SetUserDefaultKeyWithObject(@"USERSTARTDATE", nowDate);
}
//结束
- (void)userTimeEnd{
    NSDate *startDate = GetUserDefaultObjForKey(@"USERSTARTDATE");
    NSDate *nowDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:startDate toDate:nowDate options:0];
    
    NSDictionary *easyDict = @{
        @"origin":@(originType_Apple),
        @"useTime":@(cmps.second),
        @"userId":[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKUseTimePOST
                                                     parameters:easyDict];
    RACSignal *reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [reqSignal subscribeNext:^(FMHttpResonse *response) {
//        NSLog(@"userTimeEnd------%@",response.reqResult);
    }];
}
#pragma mark -  版本更新
- (void)version{
    
}
@end
