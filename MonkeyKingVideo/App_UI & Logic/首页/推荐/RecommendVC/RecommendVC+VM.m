//
//  RecommendVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+VM.h"
#import "MKRecommentModel.h"
#import "MKVideoAdModel.h"
#import "MKNetWorkTest.h"
@implementation RecommendVC (VM)
#pragma mark - 推荐视频列表
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize Block:(MKDataBlock)block{
    if(([NSDate date].timeIntervalSince1970 - self.lastListRefreshTime) < 5) {
        block(@(NO));
        return;
    }
    NSMutableDictionary *easyDict = @{
         @"pageNum":@(pageNumber),
         @"pageSize":@(pageSize)
    }.mutableCopy;
    NSString *urlstring =[[URL_Manager sharedInstance] MKVideosRecommendVideosPOST];
    @try {
        //Code that can potentially throw an exception
        // 此处可能有异常
        switch (self.mkVideoListType)
        {
            case MKVideoListType_A:
            { }break;
                
            case MKVideoListType_B:
            {
                [easyDict setValue:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid forKey:@"userId"];
                urlstring = [[URL_Manager sharedInstance] MKVideosLoadVideosPOST];
            }
                break;
            case MKVideoListType_C:
            { // 作品列表需要一个用户ID
                [easyDict setValue:self.requestParams[@"userId"] forKey:@"userId"];
                [easyDict setValue:self.requestParams[@"type"] forKey:@"dataType"];
                urlstring = [[URL_Manager sharedInstance] MKVideosLoadVideosPOST];
            }
                break;
            case MKVideoListType_D:
            {
                [easyDict setValue:self.requestParams[@"userId"] forKey:@"userId"];
                [easyDict setValue:self.requestParams[@"type"] forKey:@"dataType"];
                urlstring = [[URL_Manager sharedInstance] MKVideosLoadVideosPOST];
            }
                break;
        }
    } @catch (NSException *exception) {
//        NSLog(@"%s %@",__func__,exception.reason);
    } @finally {}
    MKNetWorkTest *test = [[MKNetWorkTest alloc] init];
    [test gotoNetWorkTest];
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                            path:urlstring
                                                      parameters:easyDict];
     self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
     @weakify(self)
    self.showEmpty = NO;
    self.noNetwork = NO;
     [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
         @strongify(self)
         self.showEmpty = 1;
         if (response.isSuccess) {
             if (response.code == 200) {
                 self.lastListRefreshTime = [NSDate date].timeIntervalSince1970;
                 NSError *error;
                 MKRecommentModel *model = [[MKRecommentModel alloc]initWithDictionary:(NSDictionary *)response.reqResult  error:&error];
                 // 测试 使用
//                 MKVideoDemandModel *modelq = [[MKVideoDemandModel alloc]init];
//                 [model.list removeLastObject];
//                 modelq.videoIdcUrl = @"http://www.akixr.top:9000/bucket1-dev/test/9a99d076d763491984bef369d1d89a77.mp4";
//                 [model.list addObject:modelq];
//                 self.mkRecommend = model;
//                 block(@(YES));
//                 return;
                 if (error == nil) {
                     if (pageNumber == 1) {
                         self.mkRecommend = model;
                     }else{
                         [self.mkRecommend.list addObjectsFromArray:model.list];
                     }
                     if (self.mkRecommend.list.count == 0) {
                          block(@(NO));
                     }else{
                          block(@(YES));
                     }
                 }else{
                      block(@(NO));
                 }
             }else{
                 block(@(NO));
             }
         }else{
             self.noNetwork = YES;
             block(@(NO));
         }
     }];
}
#pragma mark - 点赞
- (void)requestZanWith:(NSString*)videoID WithPraise:(NSString*)isPraise WithBlock:(TwoDataBlock)block{

    
    NSDictionary *easyDict = @{
        @"videoId":videoID,
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[[URL_Manager sharedInstance] MKVideosPraiseVideoPOST]
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if (response.code == 200) {
                NSError *error;
                
                block(@(YES),response.reqResult);
            }
            else{
                block(@(NO),@"1");
            }
        }else{
          
            block(@(NO),@"1");
        }
    }];
}

#pragma mark - 关注
- (void)requestAttentionWith:(NSString*)userID WithBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"followUserId":userID,
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[[URL_Manager sharedInstance] MKUserFocusAddPOST]
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if (response.code == 200) {
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

#pragma mark - 广告
- (void)requestAdBlock:(MKDataBlock)block{
    NSDictionary *easyDict = @{
        @"adType":@(1),
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[[URL_Manager sharedInstance] MKadInfoAdInfoGET]
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if (response.code == 200) {
                NSError *error;
                MKVideoAdModel *model = [[MKVideoAdModel alloc]initWithDictionary:(NSDictionary *)response.reqResult error:&error];
                if (error == nil) {
                    weak_self.mkVideoAd = model;
                    block(@(YES));
                }else{
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

#pragma mark - 查询单个视频的接口
- (void)requestVideoWithID:(NSString *)videoID WithBackData:(TwoDataBlock)block{
    NSDictionary *easyDict = @{
           @"videoId":videoID
       };
       ///
       FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                              path:@"/app/videos/getVideo"
                                                        parameters:easyDict];
       self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
       [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
           if (response.isSuccess) {
               if (response.code == 200) {
                   NSError *error;
                   MKVideoDemandModel  *model = [[MKVideoDemandModel alloc]initWithDictionary:(NSDictionary *)response.reqResult error:&error];
                   if (error == nil) {
                       block(@(YES),model);
                   }else{
                       block(@(NO),@"no model");
                   }
               }
               else{
                   block(@(NO),@"no model");
               }
           }else{
       
               block(@(NO),@"no model");
           }
       }];
}
- (void)reuestShareData:(TwoDataBlock)block{
//
    NSDictionary *easyDict = @{};
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:@"/app/userFriend/friendUrl"
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
          [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
              if (response.isSuccess) {
                  if (response.code == 200) {
                      block(@(YES),response.reqResult);
                  }
                  else{
                      block(@(NO),@"no model");
                  }
              }else{
              
                  block(@(NO),@"no model");
              }
          }];
}

#pragma mark - 单日超过10分钟判定为活跃用户
- (void)sendActiveUser{
    NSDictionary *easyDict = @{
        @"origin":@(originType_Apple),
        @"version":HDAppVersion
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKActiveUserPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
//         NSLog(@"%@",response.reqResult);
    }];
}
@end
