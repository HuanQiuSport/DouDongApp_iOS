//
//  YBNotificationManager.h
//  Created by Aalto on 2018/12/19.
//  Copyright © 2018 Aalto. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kUserAssert;
extern NSString *const MKPhotoPushNotification;
extern NSString *const MKVideoTimeNotification;
extern NSString * const MKDeleteTimerNotification;

FOUNDATION_EXTERN NSString *const kNotify_IsBackExchangeRefresh;

FOUNDATION_EXTERN NSString *const KLockMaxNotifaction;
FOUNDATION_EXTERN NSString *const KLockWillShowNotifaction;
FOUNDATION_EXTERN NSString *const KLoginSuccessNotifaction;
FOUNDATION_EXTERN NSString *const KRegisSuccessNotifaction;
FOUNDATION_EXTERN NSString *const KLoginOutNotifaction;
FOUNDATION_EXTERN NSString *const KLoginExitNotifaction;

FOUNDATION_EXTERN NSString *const ZYTextFiledClearText;

FOUNDATION_EXTERN NSString *const MKAFNReachability;
FOUNDATION_EXTERN NSString *const MKRecordStartNotification;
FOUNDATION_EXTERN NSString *const MKRefreshHeadImgNotification;
FOUNDATION_EXTERN NSString *const MKRefreshCommentNotification;
FOUNDATION_EXTERN NSString *const MKOpenDiamondNotification;
FOUNDATION_EXTERN NSString *const MKCanCoinNotification;


FOUNDATION_EXTERN NSString *const MKHomeNotification;
FOUNDATION_EXTERN NSString *const MKCommunityNotification;
FOUNDATION_EXTERN NSString *const MKShotNotification;
FOUNDATION_EXTERN NSString *const MKLucrativeNotification;
FOUNDATION_EXTERN NSString *const MKMineNotification;
FOUNDATION_EXTERN NSString *const MKLockScreenNotification;
FOUNDATION_EXTERN NSString *const MKNoLockScreenNotification;
FOUNDATION_EXTERN NSString *const MKSingleTapNotification;
FOUNDATION_EXTERN NSString *const MKSingleHanderNotification;
NS_ASSUME_NONNULL_BEGIN

@interface YBNotificationManager : NSObject

@end

NS_ASSUME_NONNULL_END
