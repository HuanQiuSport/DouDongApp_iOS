//
//  MKRevisePasswordViewController+VM.m
//  MonkeyKingVideo
//
//  Created by george on 2020/9/16.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKRevisePasswordViewController+VM.h"

@implementation MKRevisePasswordViewController (VM)
- (FMHttpRequest *)extracted:(NSMutableDictionary *)dic {
    return [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                             path:[URL_Manager sharedInstance].MKLoginResetPasswordPOST
                                       parameters:dic];
}

//修改密码
-(void)resetPasswordWith:(NSString *)oldPassword
             newPassword:(NSString *)newPassword
         confirmPassword:(NSString*)confirmPassword
                    data:(MKDataBlock)block{
    
    NSMutableDictionary *dic = [[ NSMutableDictionary alloc]init];
    dic[@"oldPassword"] = [oldPassword md5String];
    dic[@"newPassword"] = [newPassword md5String];
    dic[@"confirmPassword"] = [confirmPassword md5String];
    
    FMHttpRequest *req = [self extracted:dic];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        if (response.isSuccess) {
            if (response.code == 200) {
                block(@(YES));
                [MBProgressHUD wj_showPlainText:@"修改成功" view:nil];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                block(@(NO));
            }
        }
    }];
}
@end
