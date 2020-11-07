//
//  HomeVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "HomeVC+VM.h"

@implementation HomeVC (VM)
// GET /app/message/noticeList
#pragma mark - MKMessageNoticeListGET 获取公告数据
-(void)MKMessageNoticeListGET{

    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKMessageNoticeListGET
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if ([response.reqResult isKindOfClass:NSArray.class]) {
                [self.m_annoContents removeAllObjects];
                [self.m_annoTitles removeAllObjects];
                if (!self.m_annoContents) {
                    self.m_annoContents = NSMutableArray.new;
                }
                if (!self.m_annoTitles) {
                    self.m_annoTitles = NSMutableArray.new;
                }
                for (NSDictionary *dic in response.reqResult) {
                    [self.m_annoContents addObject:dic[@"content"]];
                    [self.m_annoTitles addObject:dic[@"title"]];
                }
                
                [self anno];
            }
            
        }
    }];
}
#pragma mark - MKVersionInfoGET 获取更新
-(void)MKVersionInfo_GET{
    WeakSelf
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKVersionInfoGET
                                                     parameters:@{@"originType":@"0"}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            [self MKMessageNoticeListGET];
            if ([response.reqResult isKindOfClass:[NSDictionary class]]) {
                NSLog(@"%@",response.reqResult[@"versionCode"]);
                NSString *storeVersion = response.reqResult[@"versionCode"];
                NSString *nativeVersion = HDAppVersion;
                if ([storeVersion intValue] > [nativeVersion intValue]) {
                    NSLog(@"本地版本与商店版本号相同，不需要更新");
                } else {
                    // 检查更新
                    NSString *versionCode = response.reqResult[@"versionCode"];
                    if(versionCode == nil) {
                        versionCode = @"";
                    }
                    [[MKTools shared] versionTip:weakSelf.view VisionContent:response.reqResult[@"versionContent"] versionCode:[NSString stringWithFormat:@"%@",versionCode]];
                }
            }
        } else {
            [self MKMessageNoticeListGET];
        }
    }];
}

@end
