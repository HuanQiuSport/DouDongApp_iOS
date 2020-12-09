//
//  MKChangeNickNameVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/14.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKBindingTelVC+VM.h"

@implementation MKBindingTelVC (VM)

- (void)uploadDataRequest{
    NSDictionary *easyDict = @{
        @"smsCode":self.verCodeTextFeild.text,
//        @"areaCode":@"86",
        @"phone":self.textField.text
    };
      ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKUserInfoBindPhonePOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        NSLog(@"打印成功信息--%ld",(long)response.code);
        if (response.code == 200) {

            [WHToast showMessage:@"绑定手机号成功"
                        duration:1
                   finishHandler:nil];
            
            [self backBtnClickEvent:nil];
        }else{

            [WHToast showMessage:response.reqResult
                        duration:1
                   finishHandler:nil];
            
        }
    }];
}

-(void)pushRequestMessage{
    NSDictionary *easyDict = @{
        @"sendType":@(3),
        @"areaCode":@"86",
        @"tel":self.textField.text
    };

    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKLoginSendSmsCodePOST
                                                     parameters:easyDict];

    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        NSLog(@"打印成功信息--%@",response.reqResult);
        
        [WHToast showMessage:@"发送验证码成功"
                    duration:1
               finishHandler:nil];
        
    }];
}

@end
