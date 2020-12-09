//
//  LikeVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LikeVC+VM.h"
#import "MKPersonalLikeModel.h"
@implementation LikeVC (VM)

-(void)value{
    
}
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize  WithUserID:(NSString *)userId   WithType:(NSString *)dataType   Block:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"pageNum":@(pageNumber),
        @"pageSize":@(pageSize),
        @"userId":userId,
        @"dataType":dataType
     };
     /// 
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
                 
                 if (error == nil) {
                     
                     if (pageNumber == 1) {
                         
                         weak_self.mkLikeModel = model;
                         
                     }else{
                         
                         [weak_self.mkLikeModel.list addObjectsFromArray:model.list];
                         
                     }
                     
                     if (weak_self.mkLikeModel.list.count == 0) {
                         
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

             [WHToast showMessage:@"没有哦oooo～"
                         duration:1
                    finishHandler:nil];
             block(@(NO));
         }
     }];
}
@end
