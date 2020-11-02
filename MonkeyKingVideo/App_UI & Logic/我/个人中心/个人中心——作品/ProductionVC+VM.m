//
//  ProductionVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ProductionVC+VM.h"
#import "MKPersonMadeVideoModel.h"
@implementation ProductionVC (VM)

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
           
                 MKPersonMadeVideoModel *model = [[MKPersonMadeVideoModel alloc]initWithDictionary:(NSDictionary *)response.reqResult error:&error];
                 
                 if (error == nil) {
                     
                     if (pageNumber == 1) {
                         
                         weak_self.mkMadeModel = model;
                         
                     }else{
                         
                         [weak_self.mkMadeModel.list addObjectsFromArray:model.list];
                         
                     }
                     
                     if (weak_self.mkMadeModel.list.count == 0) {
                         
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
@end
