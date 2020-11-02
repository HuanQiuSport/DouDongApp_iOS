//
//  AttentionVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AttentionVC+VM.h"
#import "MKHAttentionModel.h"
@implementation AttentionVC (VM)
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize WithUserId:(NSString *)userID Block:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"pageNum":@(pageNumber),
        @"pageSize":@(pageSize),
        @"userId":userID,
        @"dataType":@"0"
    };
    NSString *url = [[URL_Manager sharedInstance]MKVideosLoadVideosPOST];
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:url
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        NSLog(@"%@",response.reqResult);
        if (response.isSuccess) {
            if (response.code == 200) {
                NSError *error;
                MKHAttentionModel * model  = [[MKHAttentionModel alloc]initWithDictionary:(NSDictionary *)response.reqResult error:&error];
                if (pageNumber == 1) {
                    self.mkhAttentionModel = model;
                    self.mkCollectionView.mj_footer.hidden = 0;
                    [self.mkCollectionView.mj_footer endRefreshing];
                }else{
                    [self.mkhAttentionModel.list addObjectsFromArray:model.list];
                    [self.mkCollectionView.mj_footer endRefreshing];
                }
                if (model.list.count < 2 || self.mkhAttentionModel.list.count == model.total) {
                    [self.mkCollectionView.mj_footer endRefreshingWithNoMoreData];
                }
                if (self.mkhAttentionModel.list.count <= 0 ){
                    self.mkCollectionView.mj_footer.hidden = 1;
                }
                block(@(YES));
            }else{
                block(@(NO));
            }
        }else{
            [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:@"没有哦oooo～" dissmissAfterDeley:1.2];
            block(@(NO));
        }   
    }];
}

@end
