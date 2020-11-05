//
//  MKUploadingVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKUploadingVC+VM.h"
#import <MJExtension/MJExtension.h>
#import "UploadTokenModel.h"
#import "MKHTTPTool.h"
#import "MKTools.h"

@implementation MKUploadingVC (VM)
/*
 视频大小（单位B，非必传） videoSize
 视频文案（非必传） videoArticle
 视频地址（必传）file
 视频标签(可多选，标签id，以逗号分隔)（非必传） ids
 */
- (void)videosUploadNetworkingWithData:(NSData *)data
                          videoArticle:(NSString *)videoArticle
                              urlAsset:(AVURLAsset *)urlAsset videoTime:(CGFloat)videoTime {
 
    NSInteger videoInt = (NSInteger)videoTime;
    self.reqSignal = [[FMARCNetwork sharedInstance] uploadViedoNetworkPath:[URL_Manager sharedInstance].MKVideoUploadVideoAppTempPOST
                                                                    params:@{
                                                                        @"videoSize":@(data.length),
                                                                        @"videoArticle":videoArticle,
                                                                        @"videoTime":@(videoInt)//获取视频文件的总时长
                                                                    }
                                                                 fileDatas:@[data]
                                                                   nameArr:@[@"file"]
                                                                  mimeType:@"mp4"];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
//        NSLog(@"%@",response.reqResult);
        dispatch_async(dispatch_get_main_queue() , ^{
            [[MKTools shared] dimssLoadingHUB];
        });
        if (response.isSuccess) {
            if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                
                 [MBProgressHUD wj_showPlainText:@"发布成功" view:getMainWindow()];
                
                 [self afterRelease];
            }
            else
            {
                [MBProgressHUD wj_showPlainText:response.reqResult view:getMainWindow()];
            }
        }
        else
        {
            [MBProgressHUD wj_showPlainText:response.reqResult view:getMainWindow()];
        }
    }];
}


/*
 视频大小（单位B，非必传） videoSize
 视频文案（非必传） videoArticle
 视频地址（必传）file
 视频标签(可多选，标签id，以逗号分隔)（非必传） ids
 */
- (void)presignedUploadUrl:(NSString *)fileName
                videoTitle:(NSString *)videoTitle
                    data:(NSData *)data{
 
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].presignedUploadUrl
                                                     parameters:@{
                                                         @"fileName":fileName,
                                                         @"fileSize":@(data.length)
                                                     }];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if ([response.reqResult isKindOfClass:NSArray.class]) {
                 NSArray *models = [UploadTokenModel mj_objectArrayWithKeyValuesArray:response.reqResult];
                  UploadTokenModel *model = models.firstObject;
                if(model != nil) {
                    [[MKHTTPTool shareTool] uploadVideoData:data path:model.region progress:^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
                                            
                                        } callBack:^(bool status, NSError *error) {
                                            if(status) {
                                                [self videosUploadWithSign:model.sign bucketName:model.bucketName videoTitle:videoTitle objectName:model.objectName];
                                            } else {
                                                [MBProgressHUD wj_showPlainText:@"上传失败，请重试" view:getMainWindow()];
                                            }
                                        }];
                }
            }
            
        }
    }];
}


/*
 视频大小（单位B，非必传） videoSize
 视频文案（非必传） videoArticle
 视频地址（必传）file
 视频标签(可多选，标签id，以逗号分隔)（非必传） ids
 */
- (void)videosUploadWithSign:(NSString *)sign
                  bucketName:(NSString *)bucketName
                  videoTitle:(NSString *)videoTitle
                  objectName:(NSString *)objectName {
 
    NSDictionary *param = @{@"sign":sign,@"bucketName":bucketName,@"videoTitle":videoTitle,@"objectName":objectName};
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].uploadVideo
                                                     parameters:param];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        dispatch_async(dispatch_get_main_queue() , ^{
            [[MKTools shared] dimssLoadingHUB];
        });
        if (response.isSuccess) {
            [MBProgressHUD wj_showPlainText:@"发布成功" view:getMainWindow()];
            [self afterRelease];
        } else {
            [MBProgressHUD wj_showPlainText:response.reqResult view:getMainWindow()];
        }
    }];
}



@end
