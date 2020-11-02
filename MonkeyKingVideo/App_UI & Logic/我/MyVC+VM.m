//
//  MyVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyVC+VM.h"

@implementation MyVC (VM)

- (void)test{
    /// 
    NSMutableDictionary *easyDict = [NSMutableDictionary dictionary];
    /// 
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:@"Room/GetHotLive_v2"
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSLog(@"%p",response.reqResult);
            NSLog(@"--%@",response.reqResult);
        }
    }];
}
///APP钱包相关接口 —— POST 获取用户信息
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
                self.myVCModel = [MyVCModel mj_objectWithKeyValues:response.reqResult];
                //pubLishVideoListMutArr -> PubLishVideoListModel
                self.myVCModel.pubLishVideoListMutArr = [PubLishVideoListModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"pubLishVideoList"]];
                PubLishVideoListModel *pubLishVideoListModel = nil;
                for (int i = 0; i < self.myVCModel.pubLishVideoListMutArr.count; i++) {
                    pubLishVideoListModel = self.myVCModel.pubLishVideoListMutArr[i];
                }
                //enjoyVideoListMutArr -> EnjoyVideoListModel
                self.myVCModel.enjoyVideoListMutArr = [EnjoyVideoListModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"enjoyVideoList"]];
                EnjoyVideoListModel *enjoyVideoListModel = nil;
                for (int i = 0; i < self.myVCModel.enjoyVideoListMutArr.count; i++) {
                    enjoyVideoListModel = self.myVCModel.enjoyVideoListMutArr[i];
                }
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = YES;
        }
    }];
}

@end
