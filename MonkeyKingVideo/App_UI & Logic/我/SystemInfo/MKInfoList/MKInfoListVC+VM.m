//
//  MKInfoListVC+VM.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoListVC+VM.h"
#import "MKSysModel.h"
@implementation MKInfoListVC (VM)

- (void)getDataWithID:(NSString *)idstr
            WithBlock:(MKDataBlock)block{
    /// 
    NSMutableDictionary *easyDict = [NSMutableDictionary dictionary];
    [easyDict setValue:idstr forKey:@"type"];
    [easyDict setValue:@(1) forKey:@"pageNum"];
    [easyDict setValue:@(10000) forKey:@"pageSize"];
    ///  #define MH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKMessageList_2_GET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    WeakSelf
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            DLog(@"系统消息请求结果%@",response.reqResult);
            if (response.code == 200) {
                NSMutableArray *data = response.reqResult[@"list"];
                NSMutableArray *modelData = NSMutableArray.new;
                for (NSDictionary *dic in data) {
                    NSError *error;
                    MKSysModel *model = [[MKSysModel alloc]initWithDictionary:dic error:&error];
                    if (error == nil) {
                        
                        [modelData addObject:model];
                        
                    }else{
                        
                        block(@(NO));
                        
                    }
                    
                }
                
                [weakSelf.mkDataArray addObjectsFromArray:modelData];
                
                
                block(@(YES));
                
                
                
                
            }else{
                block(@(NO));
                
            }
            
            
        }
    }];
}

@end
