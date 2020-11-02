//
//  DouCoinDetailVC+VM.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/5.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DouCoinDetailVC+VM.h"

@implementation DouCoinDetailVC (VM)
-(void)netWorking_MKWalletMyFlowsPOST{
    ///
    NSDictionary *easyDict = @{
        @"type":@"0",
        @"beginDate":[NSObject getToday],
        @"pageSize":@(10),
        @"pageNum":@(self.page)
    };//流水类型(0-金币流水，1-余额流水)
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKWalletMyFlowsPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSLog(@"");
            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                self.walletMyFlowsModel = [MKWalletMyFlowsModel mj_objectWithKeyValues:response.reqResult];
                NSArray *listArr = [MKWalletMyFlowsListModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"list"]];
                if (listArr) {
                    @weakify(self)
                    [listArr enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                        NSUInteger idx,
                                                        BOOL * _Nonnull stop) {
                        @strongify(self)
                        MKWalletMyFlowsListModel *model = listArr[idx];
                        [self.walletMyFlowsListModelMutArr addObject:model];
                    }];
                }
                if (self.walletMyFlowsModel.pages.integerValue == 0) {
                    self.page --;
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                if (self.walletMyFlowsListModelMutArr.count) {
                    [self.tableView ly_showEmptyView];//无数据调用
                }
                [self.tableView reloadData];
            }
            else
            {
                [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:response.reqResult dissmissAfterDeley:1.5f];
            }
            
//            [self.tableView.mj_header endRefreshing];
//            [self.tableView.mj_footer endRefreshing];
//            self.tableView.mj_footer.hidden = YES;
        }
    }];
}

@end
