//
//  MKAdVC+VM.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/23/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKAdVC+VM.h"
#import "MKVideoAdModel.h"

@implementation MKAdVC (VM)

- (void)requestAdBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"adType":@(1),
    };
    /// 
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[[URL_Manager sharedInstance] MKadInfoAdInfoGET]
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if (response.code == 200) {
                NSError *error;
                MKVideoAdModel *model = [[MKVideoAdModel alloc]initWithDictionary:(NSDictionary *)response.reqResult error:&error];
                if (error == nil) {
                    weak_self.mkVideoAd = model;
                    block(@(YES));
                }else{
                    block(@(NO));
                }
            }
            else{
                block(@(NO));
            }
        }else{

            [WHToast showMessage:@"没有哦oooo～"
                        duration:1
                   finishHandler:nil];
            
            block(@(NO));
        }
    }];
}

@end
