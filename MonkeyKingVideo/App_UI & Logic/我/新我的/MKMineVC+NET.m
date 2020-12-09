//
//  MKMineVC+NET.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKMineVC+NET.h"

@implementation MKMineVC (NET)
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
//
//        if (response.isSuccess) {
//            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
//                self.myVCModel = [MyVCModel mj_objectWithKeyValues:response.reqResult];
//                //pubLishVideoListMutArr -> PubLishVideoListModel
//                self.myVCModel.pubLishVideoListMutArr = [PubLishVideoListModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"pubLishVideoList"]];
//                PubLishVideoListModel *pubLishVideoListModel = nil;
//                for (int i = 0; i < self.myVCModel.pubLishVideoListMutArr.count; i++) {
//                    pubLishVideoListModel = self.myVCModel.pubLishVideoListMutArr[i];
//                }
//                //enjoyVideoListMutArr -> EnjoyVideoListModel
//                self.myVCModel.enjoyVideoListMutArr = [EnjoyVideoListModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"enjoyVideoList"]];
//                EnjoyVideoListModel *enjoyVideoListModel = nil;
//                for (int i = 0; i < self.myVCModel.enjoyVideoListMutArr.count; i++) {
//                    enjoyVideoListModel = self.myVCModel.enjoyVideoListMutArr[i];
//                }
//            }
//            [self.tableView reloadData];
//            [self.tableView.mj_header endRefreshing];
//            [self.tableView.mj_footer endRefreshing];
//            self.tableView.mj_footer.hidden = YES;
//        }
    }];
}
#pragma mark - 获取基本信息
- (void)getDataUserData:(NSString *)authorId
                  Block:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"userId":authorId
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKUserInfoGET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {

            MKPersonalnfoModel *model = [[MKPersonalnfoModel alloc] initWithDictionary:(NSDictionary *)response.reqResult
                                                                                 error:nil];
//            if ([model.headImage rangeOfString:@"headimg"].location != NSNotFound) {
//                model.headImage = @"headimg";
//            }
            
            self.mkPernalModel = model;
            block(@(YES));
        }else{

            [WHToast showMessage:@"没有哦oooo～"
                        duration:1
                   finishHandler:nil];
            
            block(@(NO));
        }
    }];
}

@end
