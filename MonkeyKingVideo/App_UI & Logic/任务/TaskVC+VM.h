//
//  TaskVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TaskVC.h"

NS_ASSUME_NONNULL_BEGIN
@interface TaskVC (VM)
// 签到 MKUserInfoDoSignPOST
-(void)MKUserInfoDoSign_POST;
-(void)getData;
// MKuserInfoRollDateGET 获取通知数据
-(void)MKuserInfoRollDate_GET;
// APP钱包相关接口 —— POST 获取用户信息 获取余额和抖币数据
- (void)getDataUserData;
// 签到列表
-(void)MKUserInfoSignList_GET;

 /* 银行卡和好友接口不能同时调用，因为会引发接口回调401登录异常触发跳转重复登录页面
// 银行卡 MKUserInfoSelectIdCardGET
-(void)MKUserInfoSelectIdCard_GET;
// 好友MKUserFriendFourListGET
-(void)MKUserFriendFourList_GET;
  */
-(void)friendAndCard;
@end

NS_ASSUME_NONNULL_END
