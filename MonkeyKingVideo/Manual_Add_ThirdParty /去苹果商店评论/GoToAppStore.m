//
//  GoToAppStore.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/29/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "GoToAppStore.h"

@implementation GoToAppStore

- (void)showGotoAppStore:(UIViewController *)VC{
    [MKPublickDataManager  sharedPublicDataManage].isShowComment = NO;
    if ([MKPublickDataManager sharedPublicDataManage].isShowComment) {
        return;
    }
    
    //当前版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    float appVersion = [[infoDictionary objectForKey:@"CFBundleShortVersionString"] floatValue];
    //userDefaults里的天数
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int udtheDays = [[userDefaults objectForKey:@"theDays"] intValue];
    //userDefaults里的版本号
    float udAppVersion = [[userDefaults objectForKey:@"appVersion"] intValue];
    //userDefaults里用户上次的选项
    int udUserChoose = [[userDefaults objectForKey:@"userOptChoose"] intValue];
    //时间戳的天数
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    int daySeconds = 24 * 60 * 60;
    NSInteger theDays = interval / daySeconds;
    
    //版本升级之后的处理,全部规则清空,开始弹窗
    if (udAppVersion && appVersion>udAppVersion) {
        [userDefaults removeObjectForKey:@"theDays"];
        [userDefaults removeObjectForKey:@"appVersion"];
        [userDefaults removeObjectForKey:@"userOptChoose"];
        [self alertUserCommentView:VC];
    }
    //1,从来没弹出过的
    //2,用户选择😓我要吐槽，7天之后再弹出
    //3,用户选择😭残忍拒绝后，7天内，每过1天会弹一次
    //4,用户选择😭残忍拒绝的30天后，才会弹出
    else if (!udUserChoose ||
             (udUserChoose==2 && theDays-udtheDays>7) ||
             (udUserChoose>=3 && theDays-udtheDays<=7 && theDays-udtheDays>udUserChoose-3) ||
             (udUserChoose>=3 && theDays-udtheDays>30))
    {
        [self alertUserCommentView:VC];
        
    }

}

-(void)alertUserCommentView:(UIViewController *)VC{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //当前时间戳的天数
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        int daySeconds = 24 * 60 * 60;
        NSInteger theDays = interval / daySeconds;
        //当前版本号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        float appVersion = [[infoDictionary objectForKey:@"CFBundleShortVersionString"] floatValue];
        //userDefaults里版本号
        float udAppVersion = [[userDefaults objectForKey:@"appVersion"] intValue];
        //userDefaults里用户选择项目
        int udUserChoose = [[userDefaults objectForKey:@"userOptChoose"] intValue];
        //userDefaults里用户天数
        int udtheDays = [[userDefaults objectForKey:@"theDays"] intValue];
        
        //当前版本比userDefaults里版本号高
        if (appVersion>udAppVersion) {
            [userDefaults setObject:[NSString stringWithFormat:@"%f",appVersion] forKey:@"appVersion"];
        }
        
        alertController = [UIAlertController alertControllerWithTitle:nil message:@"为了我们能够提供更好的服务体验，请告诉我们您的使用感受吧！" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *refuseAction = [UIAlertAction actionWithTitle:@"😭以后再说！" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [[MKPublickDataManager sharedPublicDataManage] setIsShowComment:YES];

            [userDefaults setObject:@"1" forKey:@"userOptChoose"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
        }];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"👍不错，好评鼓励！" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [[MKPublickDataManager sharedPublicDataManage] setIsShowComment:YES];

            [userDefaults setObject:@"2" forKey:@"userOptChoose"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            
            NSString *str = [NSString stringWithFormat:
                             @"https://apps.apple.com/cn/app/pixelmator-pro/id1289583905?mt=12",
                             self.myAppID ];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            
        }];
        
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"😓不爽，我要吐槽！" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
            [[MKPublickDataManager sharedPublicDataManage] setIsShowComment:YES];

            if (udUserChoose<=3 || theDays-[[userDefaults objectForKey:@"theDays"] intValue]>30) {
                [userDefaults setObject:@"3" forKey:@"userOptChoose"];
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            }else{
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)(theDays-udtheDays+3)] forKey:@"userOptChoose"];
            }
            NSString *str = [NSString stringWithFormat:
                             @"https://apps.apple.com/cn/app/pixelmator-pro/id1289583905?mt=12",
                             self.myAppID ];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }];
        
        
        [alertController addAction:okAction];
        [alertController addAction:showAction];
        [alertController addAction:refuseAction];
        [VC presentViewController:alertController animated:YES completion:nil];
        
    }else{
        #if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
        alertViewTest = [[UIAlertView alloc] initWithTitle:nil
                                                   message:@"为了我们能够提供更好的服务体验，请告诉我们您的使用感受吧！"
                                                  delegate:self
                                         cancelButtonTitle:@"👍不错，好评鼓励！"
                                         otherButtonTitles:@"😓不爽，我要吐槽！",@"😭以后再说！", nil];
        [alertViewTest show];
        #endif
    }
    
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [[PublicDataManage sharedPublicDataManage] setIsShowComment:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //当前时间戳的天数
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    int daySeconds = 24 * 60 * 60;
    NSInteger theDays = interval / daySeconds;
    //当前版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    float appVersion = [[infoDictionary objectForKey:@"CFBundleShortVersionString"] floatValue];
    //userDefaults里版本号
    float udAppVersion = [[userDefaults objectForKey:@"appVersion"] intValue];
    //userDefaults里用户选择项目
    int udUserChoose = [[userDefaults objectForKey:@"userOptChoose"] intValue];
    //userDefaults里用户天数
    int udtheDays = [[userDefaults objectForKey:@"theDays"] intValue];
    
    //当前版本比userDefaults里版本号高
    if (appVersion>udAppVersion) {
        [userDefaults setObject:[NSString stringWithFormat:@"%f",appVersion] forKey:@"appVersion"];
    }
    
    switch (buttonIndex) {
        case 0:{ //好评
            [userDefaults setObject:@"1" forKey:@"userOptChoose"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             self.myAppID ];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 1:{ //不好用，我要提意见
            [userDefaults setObject:@"2" forKey:@"userOptChoose"];
            [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            NSString *str = [NSString stringWithFormat:
                             @"https://itunes.apple.com/cn/app/id%@?mt=8",
                             self.myAppID ];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;
        case 2: //残忍的拒绝
            if (udUserChoose<=3 || theDays-[[userDefaults objectForKey:@"theDays"] intValue]>30) {
                [userDefaults setObject:@"3" forKey:@"userOptChoose"];
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)theDays] forKey:@"theDays"];
            }else{
                [userDefaults setObject:[NSString stringWithFormat:@"%d",(int)(theDays-udtheDays+3)] forKey:@"userOptChoose"];
            }
            break;

        default:
            break;
    }
//    NSLog(@"%@",[userDefaults objectForKey:@"appVersion"]);
//    NSLog(@"%@",[userDefaults objectForKey:@"userOptChoose"]);
//    NSLog(@"%@",[userDefaults objectForKey:@"theDays"]);
    
}

#endif
@end
