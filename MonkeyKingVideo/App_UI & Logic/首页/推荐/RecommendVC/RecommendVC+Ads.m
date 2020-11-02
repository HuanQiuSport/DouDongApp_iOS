//
//  RecommendVC+Ads.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+Ads.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"

@implementation RecommendVC (Ads)
// 广告不要禁用
- (void)gotoAD{
    return;
    @weakify(self)
    MKAdVC *adVC = [MKAdVC ComingFromVC:weak_self
                         comingStyle:ComingStyle_PUSH
                   presentationStyle:UIModalPresentationFullScreen
                       requestParams:nil
                             success:^(id data) {
    }  animated:YES];
    
    [adVC MKAdActionBlock:^(id data) {
        @strongify(self)
        self.isBackFromPopAdVC = YES;
    }];
}
- (void)luanchAD{
    self.mkPageNumber = 1;
    [self performSelector:@selector(gotoAD) withObject:nil afterDelay:100];
    [self requestAdBlock:^(id data) {}];
}

@end

#pragma clang diagnostic pop
