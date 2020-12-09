//
//  MKSystemInfoVC+VM.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/13/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSystemInfoVC+VM.h"

@implementation MKSystemInfoVC (VM)

- (void)getData:(MKDataBlock)block{
    /// 
    NSMutableDictionary *easyDict = [NSMutableDictionary dictionary];
    ///  #define MH_GET_LIVE_ROOM_LIST  @"Room/GetHotLive_v2"
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKMessageList_1_GET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    WeakSelf
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {

            if (response.code == 200) {
                NSMutableArray *data = response.reqResult;
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
                [weakSelf.mkDataArray removeAllObjects];
                [weakSelf.mkDataArray addObjectsFromArray:modelData];
                
                block(@(YES));
                
            }else{
                
                block(@(NO));
                
            }
            
            
        }
    }];
}
- (void)readData:(MKDataBlock)block WithData:(NSString *)type{
    
    NSMutableDictionary *easyDict = @{@"type":type}.mutableCopy;
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:@"/app/messageStatus/add"
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    WeakSelf
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
