//
//  EditUserInfoVC+VM.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "EditUserInfoVC+VM.h"

@implementation EditUserInfoVC (VM)
///POST 上传头像
-(void)netWorking_MKUserInfoUploadImagePOST:(UIImage *)img{
    NSData *userHeader = [NSData dataWithData: [YQImageCompressTool OnlyCompressToDataWithImage:img
                                                                                       FileSize:200]];
    self.reqSignal = [[FMARCNetwork sharedInstance] uploadNetworkPath:[URL_Manager sharedInstance].MKUserInfoUploadImagePOST
                                                               params:nil
                                                            fileDatas:@[userHeader]
                                                              nameArr:@[@"file"]
                                                             mimeType:@"image/png"];
//    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
//        @strongify(self)
        NSLog(@"%@",response);
        WeakSelf
        dispatch_async(dispatch_get_main_queue() , ^{
            [[MKTools shared] dimssLoadingHUB];
        });
        MKLoginModel *model = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
        model.headImage = response.reqResult[@"data"];
        [[NSNotificationCenter defaultCenter] postNotificationName:MKRefreshHeadImgNotification object:nil];
        [[MKLoginModel getUsingLKDBHelper] insertToDB:model];
        
        [self netWorking_MKUserInfoGET];
    }];
}
///POST 编辑个人资料
- (void)requestWithUserID:(NSString *)userData
                 WithType:(UpdateUserInfoType)dataType
                    Block:(MKDataBlock)block{
    NSMutableDictionary *easyDict = NSMutableDictionary.dictionary;
    switch (dataType) {
        case UpdateUserInfoType_NickName:{
            [easyDict setValue:userData forKey:@"nickName"];
        }
            break;
        case UpdateUserInfoType_Remark:{
            [easyDict setValue:userData forKey:@"remark"];
        }
            break;
        case UpdateUserInfoType_Sex:{
            [easyDict setValue:userData forKey:@"sex"];
        }
            break;
        case UpdateUserInfoType_Birthday:{
            [easyDict setValue:userData forKey:@"birthday"];
        }
            break;
        case UpdateUserInfoType_Area:{
            [easyDict setValue:userData forKey:@"area"];
        }
            break;
    }
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                            path:[[URL_Manager sharedInstance] MKUserInfoUpdatePOST]
                                                      parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
         @strongify(self)
         if (response.isSuccess){
             [MBProgressHUD wj_showPlainText:@"设置成功"
                                        view:nil];
             block(@(YES));
             switch (dataType) {
                 case UpdateUserInfoType_NickName:{
                     NSLog(@"");
                     self.changeNickNameVC.isSave = YES;
                     if (self.changeNickNameVC.navigationController) {
                         [self.changeNickNameVC.navigationController popViewControllerAnimated:YES];
                     }else{
                         [self.changeNickNameVC dismissViewControllerAnimated:YES
                                                                   completion:nil];
                     }
                 }
                     break;
                 case UpdateUserInfoType_Remark:{
                     NSLog(@"");
                     self.changePersonalizedSignatureVC.isSave = YES;
                     if (self.changePersonalizedSignatureVC.navigationController) {
                         [self.changePersonalizedSignatureVC.navigationController popViewControllerAnimated:YES];
                     }else{
                         [self.changePersonalizedSignatureVC dismissViewControllerAnimated:YES
                                                                                completion:nil];
                     }
                 }
                     break;
                 case UpdateUserInfoType_Sex:{
                     MKLoginModel *model = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
                     model.sex = self.sex.intValue ? @"女" :@"男";
                     [[MKLoginModel getUsingLKDBHelper] insertToDB:model];
                     [self.detailTitleMutArr insertObject:model.sex atIndex:2];
                     
                     [self.detailTitleMutArr removeObjectAtIndex:3];
                     [self.tableView reloadData];
                 }
                     break;
                 case UpdateUserInfoType_Birthday:{
                     NSLog(@"");
                 }
                     break;
                 case UpdateUserInfoType_Area:{
                     NSLog(@"");
                 }
                     break;
             }
             [self netWorking_MKUserInfoGET];
         }else{
             block(@(NO));
         }
     }];
}
///GET 获取用户详情
-(void)netWorking_MKUserInfoGET{
    /// 
    NSDictionary *easyDict = @{
        @"userId":[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid
    };
    /// 
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKuserInfoMyUserInfoGET
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            NSLog(@"%p",response.reqResult);
            NSLog(@"用户详情--%@",response.reqResult);
            self.userInfoModel = [MKUserInfoModel mj_objectWithKeyValues:response.reqResult];
            self.userInfoModel.sex = self.userInfoModel.sex.intValue ? @"女" :@"男";
            [self.headerBtn sd_setBackgroundImageWithURL:[NSURL URLWithString: self.userInfoModel.headImage]
                                                forState:UIControlStateNormal
                                        placeholderImage:KIMG(@"用户头像")];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

-(void)changeSex{
    //网络
    [self requestWithUserID:self.sex
                   WithType:UpdateUserInfoType_Sex
                      Block:^(id data) {
        if ((Boolean)data) {
        }else{
        }
    }];
}


@end
