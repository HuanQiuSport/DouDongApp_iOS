//
//  MKSettingVC+VM.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/27/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSettingVC+VM.h"

@implementation MKSettingVC (VM)

- (void)requestLogoutWithData:(MKDataBlock)block{
    NSDictionary *easyDict = @{ };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKOutGET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if (response.code == 200) {
                block(@(YES));
            }else{
                block(@(NO));
            }
        }
    }];
}

@end
