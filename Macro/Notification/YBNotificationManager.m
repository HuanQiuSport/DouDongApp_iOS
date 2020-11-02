//
//  YBNotificationManager.m
//  Created by Aalto on 2018/12/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import "YBNotificationManager.h"

NSString *const kUserAssert = @"kUserAssert";
NSString *const kNotify_IsBackExchangeRefresh = @"kNotify_IsBackExchangeRefresh";

NSString *const KLockMaxNotifaction = @"KLockMaxNotifaction";
NSString *const KLockWillShowNotifaction = @"KLockWillShowNotifaction"; //手势密码将会显示
NSString *const KLoginSuccessNotifaction = @"KLoginSuccessNotifaction"; //登录成功通知
NSString *const KRegisSuccessNotifaction = @"KRegisSuccessNotifaction"; //注册成功通知
NSString *const KLoginOutNotifaction = @"KLoginOutNotifaction"; //退出登录通知
NSString *const KLoginExitNotifaction = @"KLoginExitNotifaction";//先去逛逛发出的通知
NSString *const MKAFNReachability = @"AFNReachability";

NSString *const ZYTextFiledClearText = @"ZYTextFiledClearText";

NSString *const MKRecordStartNotification = @"MKRecordStartNotification";
NSString *const MKRefreshHeadImgNotification = @"MKRefreshHeadImgNotification";
NSString *const MKRefreshCommentNotification = @"MKRefreshCommentNotification";

NSString *const MKCanCoinNotification = @"MKCanCoinNotification";
NSString *const MKOpenDiamondNotification = @"MKOpenDiamondNotification";

NSString *const MKPhotoPushNotification = @"MKPhotoPushNotification";
NSString *const MKVideoTimeNotification = @"MKVideoTimeNotification";


NSString *const MKHomeNotification = @"MKHomeNotification";  // 点击首页按钮
NSString *const MKCommunityNotification = @"MKCommunityNotification";  //点击社区按钮
NSString *const MKShotNotification = @"MKShotNotification";//点击拍摄按钮
NSString *const MKLucrativeNotification = @"MKLucrativeNotification"; //点击赚钱按钮
NSString *const MKMineNotification = @"MKMineNotification";//点击我的按钮


NSString *const MKLockScreenNotification = @"MKLockScreenNotification";
NSString *const MKNoLockScreenNotification = @"MKNoLockScreenNotification";

NSString *const MKSingleTapNotification = @"MKSingleTapNotification"; //单点视频通知
NSString *const MKSingleHanderNotification = @"MKSingleHanderNotification"; //刷新首页推荐列表通知  在推荐列表子页面 或者其他页面进行点赞 评论 分享 关注等操作 


//销毁定时器
NSString *const MKDeleteTimerNotification = @"MKDeleteTimerNotification";

@implementation YBNotificationManager


@end
