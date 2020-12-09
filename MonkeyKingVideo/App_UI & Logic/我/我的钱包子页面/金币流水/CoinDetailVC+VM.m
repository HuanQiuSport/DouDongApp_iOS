//
//  CoinDetailVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CoinDetailVC+VM.h"

@implementation CoinDetailVC (VM)

-(void)netWorking_MKWalletMyFlowsPOST{

    NSDictionary *easyDict = @{
        @"type":[NSNumber numberWithInteger:self.walletStyle],
        @"beginDate":[TimeModel.new getDayWithDate:nil dateFormatStr:@"yyyy-MM-dd"]
    };//流水类型(0-金币流水，1-余额流水)
    /// 
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKWalletMyFlowsPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSLog(@"");
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
            if (self.walletMyFlowsListModelMutArr.count) {
                [self.tableView ly_showEmptyView];//无数据调用
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = YES;
        }
    }];
}

@end

//{
//    endRow = 3;
//    hasNextPage = 0;
//    hasPreviousPage = 0;
//    isFirstPage = 1;
//    isLastPage = 1;
//    list =     (
//                {
//            amount = 500;
//            createTime = 1595745828000;
//            createUser = 0;
//            delete = 0;
//            goldType = 1;
//            id = 1287277421858414593;
//            inOutType = 0;
//            updateTime = 1595745828000;
//            updateUser = 0;
//            userId = 1287276711334928385;
//        },
//                {
//            amount = 196;
//            createTime = 1595745768000;
//            createUser = 0;
//            delete = 0;
//            goldType = 2;
//            id = 1287277169965293570;
//            inOutType = 0;
//            updateTime = 1595745768000;
//            updateUser = 0;
//            userId = 1287276711334928385;
//        },
//                {
//            amount = 100;
//            createTime = 1595745711000;
//            createUser = 0;
//            delete = 0;
//            goldType = 3;
//            id = 1287276927215755265;
//            inOutType = 0;
//            updateTime = 1595745711000;
//            updateUser = 0;
//            userId = 1287276711334928385;
//        }
//    );
//    navigateFirstPage = 1;
//    navigateLastPage = 1;
//    navigatePages = 8;
//    navigatepageNums =     (
//        1
//    );
//    nextPage = 0;
//    pageNum = 1;
//    pageSize = 10;
//    pages = 1;
//    prePage = 0;
//    size = 3;
//    startRow = 1;
//    total = 3;
//}
