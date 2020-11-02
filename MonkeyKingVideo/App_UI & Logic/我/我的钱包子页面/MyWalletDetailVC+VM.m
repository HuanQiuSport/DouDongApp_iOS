//
//  MyWalletDetailVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyWalletDetailVC+VM.h"
#import <MJExtension/MJExtension.h>
#import "WalletInfoModel.h"

@implementation MyWalletDetailVC (VM)
// POST /app/wallet/withdrawBalance 余额提现
-(void)MKWalletWithdrawBalance_POST{
    NSDictionary *easyDict = @{
        @"drawType":@"",
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKWalletWithdrawBalancePOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            

        } else {
            
        }
    }];
}
// GET /app/wallet/getWithdrawType MKgetWithdrawTypeGET 提现类型
-(void)MKWalletWithdrawBalance_GET{

    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKgetWithdrawTypeGET
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            

        } else {
            
        }
    }];
}
// 获取用户信息
-(void)netWorking_MKWalletMyWalletPOST{
    //[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token
    ///
    NSMutableDictionary *easyDict = [NSMutableDictionary dictionary];
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKWalletMyWalletPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            [self initUI];
            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                WalletInfoModel *model = [WalletInfoModel mj_objectWithKeyValues:response.reqResult];
                self.walletModel = model;
//                if ([[NSString stringWithFormat:@"%@",response.reqResult[@"balance"]] isEqualToString:@"0.00"]) {
//                    self.balanceCount.text = @"0";
//                } else{
//                    self.balanceCount.text = [NSString stringWithFormat:@"%@",response.reqResult[@"balance"]];
//                }
//                self.canWithdrawNub = [NSString stringWithFormat:@"%@",response.reqResult[@"drawBalance"]];
//                self.withdrawNumb = [NSString stringWithFormat:@"%@",response.reqResult[@"drawCount"]];
//                self.friendNumb = [NSString stringWithFormat:@"%@",response.reqResult[@"friendCount"]];
//                self.siginNumb = [NSString stringWithFormat:@"%@",response.reqResult[@"signCount"]];
            }
        }
    }];
}
@end
