//
//  PersonalCenterVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PersonalCenterVC+VM.h"
#import "MKPersonalnfoModel.h"

@implementation PersonalCenterVC (VM)

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
            DLog(@"用户关注详情%@",response.reqResult);
            MKPersonalnfoModel *model = [[MKPersonalnfoModel alloc] initWithDictionary:(NSDictionary *)response.reqResult
                                                                                 error:nil];
            self.mkPernalModel = model;
            block(@(YES));
        }else{
     
            block(@(NO));
        }
    }];
}

#pragma mark - 视频列表数据
-(void)requestWith:(NSInteger)type
    WithPageNumber:(NSInteger)pageNumber
      WithPageSize:(NSInteger)pageSize
             Block:(MKDataBlock)block{
    
}
/// 添加关注
- (void)requestAttentionWith:(NSString*)userID
                   WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"followUserId":userID,
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKUserFocusAddPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
//    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
//        @strongify(self)
        if (response.isSuccess) {
            block(@(YES));
        }
    }];
}
/// 取消关注
- (void)requestDeleteAttentionWith:(NSString*)userID
                         WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"userId":userID,
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKUserFocusDeleteGET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
//    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
//        @strongify(self)
        if (response.isSuccess) {
            block(@(YES));
        }
    }];
}
#pragma mark - 添加黑名单
- (void)requestAddBlackListWith:(NSString*)userID
                      WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"blackId":userID,
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKBlackAddPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            block(@(YES));
        }else{
            block(@(NO));
        }
    }];
}
#pragma mark - 获取用户关注详情
- (void)requestAttentionDetailWith:(NSString*)userID WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"followUserId":userID,
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[[URL_Manager sharedInstance] MKUserFocusFocusInfoGET]
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            DLog(@"用户关注详情%@",response.reqResult);
            if (response.code == 200) {
                NSError *error;
                block(@(YES));
            }
            else{
                block(@(NO));
            }
        }else{
            block(@(NO));
        }
    }];
}
@end
