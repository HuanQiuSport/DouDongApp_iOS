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
                                                     parameters:@{@"channelUrl":[URL_Manager sharedInstance].channelUrl}];
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
                                                     parameters:@{@"originType":@"0",
                                                                  @"channelUrl":[URL_Manager sharedInstance].channelUrl}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            [self MKMessageNoticeListGET];
            if ([response.reqResult isKindOfClass:[NSDictionary class]]) {
                NSLog(@"%@",response.reqResult[@"versionName"]);
                NSString *storeVersion = response.reqResult[@"versionName"];
                NSString *nativeVersion = HDAppVersion;
                storeVersion = [storeVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                nativeVersion = [nativeVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
                if ([storeVersion floatValue] > [nativeVersion floatValue]) {
                    NSLog(@"本地版本与商店版本号相同，不需要更新");
                    // 检查更新
                    NSString *versionCode = response.reqResult[@"versionName"];
                    if(versionCode == nil) {
                        versionCode = @"";
                    }
                    [[MKTools shared] versionTip:weakSelf.view VisionContent:response.reqResult[@"versionContent"] versionCode:[NSString stringWithFormat:@"%@",versionCode] appUrl:response.reqResult[@"iosUrl"]];
                }
            }
        } else {
            [self MKMessageNoticeListGET];
        }
    }];
}

@end
