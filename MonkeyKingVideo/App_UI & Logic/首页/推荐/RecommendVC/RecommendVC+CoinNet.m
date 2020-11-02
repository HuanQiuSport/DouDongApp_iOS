//
//  RecommendVC+CoinNet.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/8/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+CoinNet.h"
#pragma clang diagnostic push

#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@implementation RecommendVC (CoinNet)
-(void)OpenDiamonds{

    MKLoginModel *model = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for (NSDictionary *temp in  self.playRecordArray) {
        [dic setValue:temp.allValues.firstObject forKey:temp.allKeys.firstObject];
    }
    if (self.playRecordArray.count == 0) {
        return;
    }
    NSString *timeStr = [MKKeyAndSecreetTool getNowTimeTimestamp3];
    timeStr = [NSString stringWithFormat:@"%@%@",timeStr,@"niGMYaqV6r"];
    NSDictionary *easyDict2 = @{@"durationByTime": model.durationForBox,
                                @"param_play":model.diamondsStartPlayTime,
                                @"param_stop": [MKKeyAndSecreetTool encodeString:timeStr],
                                @"rewardNums": model.boxRewardNums,
                                @"userId": model.uid,
                                @"videos": dic,
                                @"deviceId":[[[UIDevice currentDevice] identifierForVendor] UUIDString]
    }.copy;
    model.diamondsStartPlayTime =  [MKKeyAndSecreetTool encodeString:timeStr];

    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:easyDict2 options:NSJSONWritingFragmentsAllowed error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *easyDict = @{@"rewardParam":jsonString};
    ///
//    NSLog(@"开宝箱请求参数%@",easyDict);
    if(parseError != nil){return;}
    if(![NSString ensureNonnullString:jsonString ReplaceStr:@"nil"]){return;}
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKRewardBoxRewardPOST
                                                     parameters:easyDict];
    @weakify(self)
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if(response.isSuccess){
            NSError *error;
            if(response.code == 200){
                MKLoginModel *model = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
                
                NSDictionary *dic = [(NSDictionary *)response.reqResult mutableCopy];
                model.boxRewardNums  = dic[@"goldNum"];
                model.durationForBox  = dic[@"randomRewardCount"];
                [[MKLoginModel getUsingLKDBHelper] insertToDB:model callback:^(BOOL result) { }];
//                NSLog(@"宝箱获取成功 💰%@ ⌚️%@" ,model.boxRewardNums,model.durationForBox);
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    id  randomReward = dic[@"randomReward"];
                    id  boxReward =  dic[@"boxReward"];
                    
                    if ([randomReward boolValue]) {
                        if(self.mkShuaCoinView.hidden){
//                            [self GetCoinConfig];
                        }
                        self.mkShuaCoinView.hidden = NO;
                    }else{
                        self.mkShuaCoinView.hidden = YES;
                    }
//                    if ([boxReward boolValue]) {
//                        self.mkDiamondsView.hidden = NO;
//                    }else{
//                        self.mkDiamondsView.hidden = YES;
//                        return;
//                    }
                    
                });
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    @strongify(self)
//                    [self.mkDiamondsView mkSetDiamondNumber:model.boxRewardNums WithDecountTime:model.durationForBox];
//
//                });
            }
        }
    }];
}
//首页看视频得抖币配置
-(void)GetCoinConfig{
    if([self mkIsCanGetCoin]){
        
    }else{
        return;
    }
    
    NSDictionary *easyDict = @{@"deviceId":[[[UIDevice currentDevice] identifierForVendor] UUIDString]}.mutableCopy;
    ///
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKRewardRewardSnapshotPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if(response.isSuccess){
            NSError *error;
            if(response.code == 200){
//                NSLog(@"%@",response.reqResult);
                
                MKLoginModel *model = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
                NSDictionary *dic = [(NSDictionary *)response.reqResult mutableCopy];
                model.boxRewardNums  = dic[@"boxRewardNums"];
                model.durationForBox  = dic[@"durationForBox"];
                model.durationForRandom  = dic[@"durationForRandom"];
                model.randomRewardNums  = dic[@"randomRewardNums"];
                [[MKLoginModel getUsingLKDBHelper] insertToDB:model callback:^(BOOL result) {}];
                
//                NSLog(@"宝箱｜刷币 配置获取成功");
                if (!self.mkShuaCoinView.hidden) {
                    [self.mkShuaCoinView mkSetRedpackCoinNumber:model.randomRewardNums WithDecountTime:model.durationForRandom];
                }
//                if (!self.mkDiamondsView.hidden) {
//                   [self.mkDiamondsView mkSetDiamondNumber:model.boxRewardNums WithDecountTime:model.durationForBox];
//                }
                                 
            }else{
//                NSLog(@"配置获取失败");
            }
        }
    }];
}
-(void)OpenCoin{
    if([self mkIsCanGetCoin]){
        
    }else{
        return;
    }
    MKLoginModel *model = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    for (NSDictionary *temp in  self.playRecordArray) {
        [dic setValue:temp.allValues.firstObject forKey:temp.allKeys.firstObject];
    }
    /*
     durationByTime
     param_play
     param_stop
     rewardNums
     userId
     videos
     deviceId
     */
    NSString *timeStr = [MKKeyAndSecreetTool getNowTimeTimestamp3];
    timeStr = [NSString stringWithFormat:@"%@%@",timeStr,@"niGMYaqV6r"];
    NSDictionary *easyDict2 = @{@"durationByTime": model.durationForRandom,
                                @"param_play":model.coinStartPlayTime,
                                @"param_stop": [MKKeyAndSecreetTool encodeString:timeStr],
                                @"rewardNums": model.randomRewardNums,
                                @"userId": model.uid,
                                @"videos": dic,
                                @"deviceId":[[[UIDevice currentDevice] identifierForVendor] UUIDString]
    };
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:easyDict2 options:NSJSONWritingFragmentsAllowed error:&parseError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *easyDict = @{@"rewardParam":jsonString};
    ///
//    NSLog(@"刷金币请求参数%@",easyDict.allValues.firstObject);
    
    if(parseError != nil){ NSLog(@"刷金币json序列化失败"); return; }
    
    if(![NSString ensureNonnullString:jsonString ReplaceStr:@"nil"]){  NSLog(@"刷金币请求参数是空的"); return;}
    
    if ([jsonString isEqualToString:@"{}"]) {return;}
    
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKRewardRandomRewardPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if(response.isSuccess){
            
            if(response.code == 200){
                MKLoginModel *model = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
                 NSLog(@"刷币获取成功");
//                [self.mkShuaCoinView cotinueAddCoin];
//                [[NSNotificationCenter defaultCenter] removeObserver:self name:MKCanCoinNotification object:nil];
                NSDictionary *dic = [(NSDictionary *)response.reqResult mutableCopy];
                model.randomRewardNums  = dic[@"goldNum"];
                model.durationForRandom  = dic[@"randomRewardCount"];
                NSLog(@"获取成功 goldNum=%@ randomRewardCount=%@",dic[@"goldNum"],dic[@"randomRewardCount"]);
                [[MKLoginModel getUsingLKDBHelper] insertToDB:model callback:^(BOOL result) {}];
//                NSLog(@"刷币获取成功");
//                NSLog(@"刷币获取成功 💰%@ ⌚️%@" ,model.randomRewardNums,model.durationForRandom);
                dispatch_async(dispatch_get_main_queue(), ^{
                    @strongify(self)
                    id  randomReward = dic[@"randomReward"];
                    id  boxReward =  dic[@"boxReward"];
                    
                    if ([randomReward boolValue]) {
                        self.mkShuaCoinView.hidden = NO;
                    }else{
                        self.mkShuaCoinView.hidden = YES;
                        return;
                    }
//                    if ([boxReward boolValue]) {
//                        if(self.mkDiamondsView.hidden){
//                            [self GetCoinConfig];
//                        }
//                        self.mkDiamondsView.hidden = NO;
//                    }else{
//                        self.mkDiamondsView.hidden = YES;
//                        return;
//                    }
                });
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    @strongify(self)
                    [self.mkShuaCoinView mkSetRedpackCoinNumber:model.randomRewardNums WithDecountTime:model.durationForRandom];
                });
                                
            }
            else
            {
                NSLog(@"22 -- %ld %@ ",response.code,response.reqResult);
            }
            
        }
        else
        {
            NSLog(@"%ld",response.code);
        }
    }];
    
}
- (void)changeCheck{
    
}
- (void)goldNumSwitch{
    NSDictionary *easyDict = @{}.mutableCopy;
        ///
        FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                               path:@"/app/reward/goldSwitch"
                                                         parameters:easyDict];
        self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
        [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
            if(response.isSuccess){
                if(response.code == 200){
    //                NSLog(@"%@",response.reqResult);
                    NSDictionary *dic = [(NSDictionary *)response.reqResult mutableCopy];
                    @weakify(self)
                    dispatch_async(dispatch_get_main_queue(), ^{
                        @strongify(self)
                        id  randomReward = dic[@"randomReward"];
                        id  boxReward =  dic[@"boxReward"];
                        
                        if ([randomReward boolValue]) {
                            self.mkShuaCoinView.hidden = NO;
                        }else{
                            self.mkShuaCoinView.hidden = YES;
                        }
                        if ([boxReward boolValue]) {
                            self.mkDiamondsView.hidden = NO;
                        }else{
                            self.mkDiamondsView.hidden = YES;
                        }
                        if(randomReward == NO && boxReward == NO){
                            
                        }else{
                             [self GetCoinConfig];// 刷金币 ｜ 宝箱配置
                        }
                    });
    //                NSLog(@"后台配置 抖币左边%@ 宝箱左边%@",dic[@"randomReward"],dic[@"boxReward"]);
                    
                }else{
                    
                }
            }
        }];
    
}

@end
#pragma clang diagnostic pop
