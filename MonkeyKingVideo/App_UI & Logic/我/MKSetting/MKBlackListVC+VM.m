
//
//  MKBlackListVC+VM.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/13/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "MKBlackModel.h"
#import "MKBlackListVC+VM.h"

@implementation MKBlackListVC (VM)
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize Block:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"pageNum":@(pageNumber),
        @"pageSize":@(pageSize)
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKBlackListGET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if (response.code == 200) {
                NSError *error;
                self.mkBlackModel = [[MKBlackModel alloc]initWithDictionary:response.reqResult error:&error];
                if (error == nil) {
                    block(@(YES));
                }else{
                    block(@(NO));
                }
            }else{
                block(@(NO));
            }
            
            
        }
    }];
}
-(void)deleteBalckNameList:(NSString *)blackId WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"id":blackId,
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKBlackDeleteGET
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
