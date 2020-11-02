//
//  MyCoinVC+VM.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyCoinVC+VM.h"

@implementation MyCoinVC (VM)
// 兑换余额
-(void)netWorking_MKWalletChargeGoldPOSTBlock:(MKDataBlock)block{
    ///
    NSInteger totalCion = [self.showNumLab.text intValue] % 100;
    NSDictionary *easyDict = @{
        @"chargeGoldNum":[NSString stringWithFormat:@"%ld",(long)totalCion]
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKWalletChargeGoldPOST
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSLog(@"response");
            block(@(YES));
//            self.walletMyFlowsModel = [MKWalletMyFlowsModel mj_objectWithKeyValues:response.reqResult];
//            NSArray *listArr = [MKWalletMyFlowsListModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"list"]];
//            if (listArr) {
//                @weakify(self)
//                [listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj,
//                                                    NSUInteger idx,
//                                                    BOOL * _Nonnull stop) {
//                    @strongify(self)
//                    MKWalletMyFlowsListModel *model = listArr[idx];
//                    [self.walletMyFlowsListModelMutArr addObject:model];
//                }];
//            }
//            if (self.walletMyFlowsListModelMutArr.count) {
//                [self.tableView ly_showEmptyView];//无数据调用
//            }
//            [self.tableView reloadData];
//            [self.tableView.mj_header endRefreshing];
//            [self.tableView.mj_footer endRefreshing];
//            self.tableView.mj_footer.hidden = YES;
        }
        else{
            block(@(NO));
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
            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                
                WeakSelf
                dispatch_async(dispatch_get_main_queue() , ^{
                    weakSelf.showNumLab.text = [NSString stringWithFormat:@"%@",response.reqResult[@"goldNumber"]];
                });
                
            }

        }
    }];
}
// 提示框
-(void)netWorking_ChargeBalanceTipsGET:(MKDataBlock)block{
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKChargeBalanceTipsGET
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        
        if (response.isSuccess) {
            if (response.code == 200) {
                if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                    
                    self.TipsStr = [NSString stringWithFormat:@"您当前的金币数为%@个，可兑换的余额为%@元，确认兑换吗？",response.reqResult[@"value"],response.reqResult[@"key"] ];
                    block(@(YES));
                }
                else
                {
                   block(@(NO));
                }
            }
            else if (response.code != 200)
            {
                self.TipsStr = response.message;
                block(@(NO));
            }
            

        }
        else
        {
            self.TipsStr = response.message;
            block(@(NO));
        }
    }];
}
@end
