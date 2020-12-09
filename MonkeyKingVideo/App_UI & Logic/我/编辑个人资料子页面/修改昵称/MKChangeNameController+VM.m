//
//  MKChangeNameController+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/16.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKChangeNameController+VM.h"

@implementation MKChangeNameController (VM)

-(void)pushRequestMessage:(NSString *)tel{
    NSDictionary *easyDict = @{
        @"sendType":@(3),
        @"areaCode":@"86",
        @"tel":tel
          };
          ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:@"/app/login/sendSmsCode"//[URL_Manager sharedInstance].MKUserInfoGET
                                                     parameters:easyDict];

    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        NSLog(@"打印成功信息--%@",response.reqResult);
    }];
}

@end
