//
//  MKNetWork.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/28/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKNetWork.h"
@interface MKNetWork()
@property(nonatomic,strong)RACSignal *reqSignal;
@end
@implementation MKNetWork

static MKNetWork *_tools = nil;
+ (MKNetWork *)shared{
    @synchronized(self){
        if (!_tools) {
            _tools = MKNetWork.new;
        }
    }return _tools;
}
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

@end
