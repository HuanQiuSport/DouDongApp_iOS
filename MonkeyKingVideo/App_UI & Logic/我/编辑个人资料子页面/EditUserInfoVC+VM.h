//
//  EditUserInfoVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "EditUserInfoVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditUserInfoVC (VM)
///POST 上传头像
-(void)netWorking_MKUserInfoUploadImagePOST:(UIImage *)img;
///POST 编辑个人资料
- (void)requestWithUserID:(NSString *)userData
                 WithType:(UpdateUserInfoType)dataType
                    Block:(MKDataBlock)block;
///GET 获取用户详情
-(void)netWorking_MKUserInfoGET;

-(void)uploadIphoneRequest:(NSString *)iphoneNumber
                   verCode:(NSString *)code;
-(void)changeSex;



@end

NS_ASSUME_NONNULL_END
