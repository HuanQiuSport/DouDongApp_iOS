//
//  VerificationCodeVC+VM.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "VerificationCodeVC+VM.h"

@implementation VerificationCodeVC (VM)

-(void)login_netWorking{
    ///  测试用，万能验证码
    NSDictionary *easyDict;
    if ([self.hwTextCodeView.code isEqualToString:@"1111"]) {
        easyDict = @{
            @"tel":self.requestParams[@"tel"],//手机号码
            @"smscode":@"111111",//短信
            @"originType":@"0"//来源 0、苹果 1、安卓 2、H5
        };
        
    }
    else
    {
        easyDict = @{
            @"tel":self.requestParams[@"tel"],//手机号码
            @"smscode":self.hwTextCodeView.code,//短信
            @"originType":@"0"//来源 0、苹果 1、安卓 2、H5
        };
    }
    
    
//    NSDictionary *easyDict = @{
//        @"tel":self.requestParams[@"tel"],//手机号码
//        @"smscode":self.hwTextCodeView.code,//短信
//        @"originType":@"0"//来源 0、苹果 1、安卓 2、H5
//    };

    /// 
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKLoginDo
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if(response.isSuccess){
            NSError *error;
            if ([response.reqResult isKindOfClass:[NSDictionary class]]) {
                MKLoginModel *model = [[MKLoginModel alloc]initWithDictionary:(NSDictionary *)response.reqResult error:&error];
                            model.sex = [model.sex intValue] ? @"女" :@"男";//0、男;1、女
                            if (error == nil) {
                                [[MKLoginModel getUsingLKDBHelper] insertToDB:model callback:^(BOOL result) {
                                    NSLog(@"%@",result?@"成功":@"失败");
                                }];
                            }
                            UIViewController * presentingViewController = self.presentingViewController;
                            while (presentingViewController.presentingViewController) {
                                presentingViewController = presentingViewController.presentingViewController;
                            }
                            [presentingViewController dismissViewControllerAnimated:YES completion:nil];
                            NSLog(@"登录成功%@",response.reqResult);
                            [MKTools shared]._isReloadRequest = YES;
                //            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:KLoginSuccessNotifaction object:nil]];
                            [[NSNotificationCenter defaultCenter] postNotificationName:KLoginSuccessNotifaction object:nil];
                            
            }
            else
            {
               [MBProgressHUD wj_showError:[NSString stringWithFormat:@"登录失败：%@",response.reqResult]];
            }
        }
        
        

    }];
}
@end
