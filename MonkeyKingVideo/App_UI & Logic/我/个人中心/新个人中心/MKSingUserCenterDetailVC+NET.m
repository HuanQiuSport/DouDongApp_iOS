//
//  MKSingUserCenterDetailVC+Net.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSingUserCenterDetailVC+NET.h"
#import "MKPersonalLikeModel.h"
@implementation MKSingUserCenterDetailVC (Net)
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize  WithUserID:(NSString *)userId   WithType:(NSString *)dataType   Block:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"pageNum":@(pageNumber),
        @"pageSize":@(pageSize),
        @"userId":userId,
        @"dataType":dataType
     };
    if (easyDict.allKeys.count != 4) { // 过滤一下不然很奇怪哎
        block(@(NO));
        return;
    }
     //
     FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                            path:[[URL_Manager sharedInstance] MKVideosLoadVideosPOST]
                                                      parameters:easyDict];
     self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
     @weakify(self)
     [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
         if (response.isSuccess){
             if (response.code == 200) {
                 
                 NSError *error;
           
                 MKPersonalLikeModel *model = [[MKPersonalLikeModel alloc]initWithDictionary:(NSDictionary *)response.reqResult error:&error];
                 if (model.list.count < 10 || model.total == model.list.count) {
                     weak_self.mjRefreshAutoGifFooter.hidden = 1;
                 } else {
                     weak_self.mjRefreshAutoGifFooter.hidden = 0;
                 }
                 if (error == nil) {
                     
                     if (pageNumber == 1) {
//                         weak_self.mkLikeModel = model;
                         [weak_self handleFristData:model];
                     } else {
                         
                         [weak_self handleData:model];
//                         [weak_self.mkLikeModel.list addObjectsFromArray:model.list];
                         
                     }
                     
                     if (weak_self.mkLikeModel.list.count == 0) {
                         
                         if(pageNumber >= 1){
                             
                             [WHToast showMessage:@"暂无更多数据"
                                                                duration:1
                                                           finishHandler:nil];
                             
                         }
                         
                         
                         block(@(NO));
                         
                     }else{
                         
                         block(@(YES));
                         
                     }
                     
                 }
                 else{
                     
                     block(@(NO));
                     
                 }
                 
             }
             else{
                 
                 block(@(NO));
             }
         }else{
             
    
             block(@(NO));
         }
     }];
}

-(void)handleFristData:(MKPersonalLikeModel *)model {
    [self.videidsSet removeAllObjects];
    NSMutableArray *tempArray = [[NSMutableArray array] init];
    for(NSUInteger index = 0; index < model.list.count; index++ ) {
        MKVideoDemandModel *item =  model.list[index];
        if(![self.videidsSet containsObject:item.videoId]) {
            [self.videidsSet addObject:item.videoId];
            [tempArray addObject:item];
        }
    }
    self.mkLikeModel = model;
    self.mkLikeModel.list = tempArray;
}

-(void)handleData:(MKPersonalLikeModel *)model {
    for(NSUInteger index = 0; index < model.list.count; index++ ) {
        MKVideoDemandModel *item =  model.list[index];
        if(![self.videidsSet containsObject:item.videoId]) {
            [self.videidsSet addObject:item.videoId];
            [self.mkLikeModel.list addObject:item];
        }
    }
}

// POST /app/videos/delAppVideo
- (void)MKDelAppVideo_POST_ViedoID:(NSString *)viedoID{
    //[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token
    ///
    NSDictionary *easyDict =
    @{
        @"videoId":viedoID
    };
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKVideosDelAppVideoPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        
        if (response.isSuccess) {
            
            [WHToast showMessage:@"删除成功"
                        duration:1
                   finishHandler:nil];
            
            [self refrushData];
        }
    }];
}

@end
