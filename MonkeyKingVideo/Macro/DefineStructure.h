//
//  DefineStructure.h
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#ifndef DefineStructure_h
#define DefineStructure_h

#import <UIKit/UIKit.h>
/*
 这个类只放置用户自定义的定义的枚举值
 */
typedef enum : int {
      /// 加载中
      MKVideoStatus_loading = 0,
      /// 播放中
      MKVideoStatus_playing,
      /// 暂停中
      MKVideoStatus_pause,
      /// 播放失败
      MKVideoStatus_faile,
} MKVideoStatus;

typedef enum : int {
      /// 加载中
      MKGoToPersonalType_A = 0,
      /// 播放中
      MKGoToPersonalType_B,
      /// 暂停中
      MKGoToPersonalType_C,
      /// 播放失败
      MKGoToPersonalType_D,
} MKGoToPersonalType;
////
/// 视频模型类型 考虑视图复用方面 暂先定义三个关注 ｜ 喜欢 ｜ 作品
typedef enum : NSUInteger {
    /// 关注
    MKVideoType_Attention = 0,
    /// 喜欢
    MKVideoType_Like ,
    /// 作品
    MKVideoType_MadeInMe ,
    /// 我的 喜欢
    MKVideoType_MyLike ,
    /// 我的 作品
    MKVideoType_MyMadeByMe ,
    ///  我喜欢的
    MKVideoType_LikeMy,
} MKVideoType;
///  视频发布类型 由于考虑流程的未知和后面修改，所以用A，B，C，D 来表示一个视频发布的历程
typedef enum : NSUInteger {
    MKVideoPublishType_A,
    MKVideoPublishType_B,
    MKVideoPublishType_C,
    MKVideoPublishType_D
} MKVideoPublishType;

typedef enum : NSUInteger {
    MKVideoListType_A, // 推荐列表
    MKVideoListType_B, // 关注列表
    MKVideoListType_C, // 作品列表
    MKVideoListType_D  // 喜欢列表
} MKVideoListType;
///流水类型为
typedef enum : NSUInteger {
    MyWalletStyle_CURRENTCOIN = 0,// 金币流水
    MyWalletStyle_CURRENTBALANCE,//  余额流水
    MyWalletStyle_CURRENTDOUCOIN//  抖币流水
} MyWalletStyle;

typedef enum : NSUInteger {
    /// 修改昵称
    UpdateUserInfoType_NickName, // 关注列表
    /// 修改签名
    UpdateUserInfoType_Remark,
    /// 修改性别
    UpdateUserInfoType_Sex,
    /// 修改生日
    UpdateUserInfoType_Birthday,
    /// 修改地区
    UpdateUserInfoType_Area,
} UpdateUserInfoType;


typedef enum : NSUInteger {
    ///  发布成功
    MKVideoOfMineTypeA = 0,
    ///  发布失败
    MKVideoOfMineTypeB ,
    ///  审核通过
    MKVideoOfMineTypeC ,
    ///  审核未通过
    MKVideoOfMineTypeD ,
    ///  正在审核中
    MKVideoOfMineTypeE ,
    ///  被强制下架
    MKVideoOfMineTypeF,
} MKVideoOfMineType;


/// 登陆权限校验判断类型
typedef enum : NSUInteger {
    ///评论
    MKLoginAuthorityType_Conment = 0,
    ///抖币转余额
    MKLoginAuthorityType_Money,
    ///提现
    MKLoginAuthorityType_Reflect,
    ///上传视频,
    MKLoginAuthorityType_Upload
} MKLoginAuthorityType;

typedef enum : NSUInteger {
    originType_Apple = 0,
    originType_Android,
    originType_H5
} originType;


typedef enum : NSUInteger {
    ///  待审核
    MKVideoOfReviewType_review = 0,
    ///  审核通过
    MKVideoOfReviewType_success ,
    ///  审核失败
    MKVideoOfReviewType_fail ,
} MKVideoOfReviewType;


///// 请求数据返回的状态码、根据自己的服务端数据来
//typedef NS_ENUM(NSUInteger, HTTPResponseCode) {//KKK
//    ///请求成功 200
//    HTTPResponseCodeSuccess = 200,
//    ///未登录 & 被踢 401
//    HTTPResponseCodeNotLogin = 401,
//    ///失效Token 402
//    HTTPResponseCodeFailureToken = 402,
//    ///550 后台业务代码参数异常 参数异常
//    HTTPResponseCodeAnomalous = 550,
//    ///后台代码异常 999
//    HTTPResponseCodeError = 999,
//    ///app 更新提示
//    HTTPResponseCodeUpdateApp = 990,
//};
//
//NSString *const HTTPServiceErrorDomain = @"HTTPServiceErrorDomain";/// The Http request error domain
//NSString *const HTTPServiceErrorResponseCodeKey = @"HTTPServiceErrorResponseCodeKey";/// 请求成功，但statusCode != 0
//NSString *const HTTPServiceErrorRequestURLKey = @"HTTPServiceErrorRequestURLKey";//请求地址错误
//NSString *const HTTPServiceErrorHTTPStatusCodeKey = @"HTTPServiceErrorHTTPStatusCodeKey";//请求错误的code码key: 请求成功了，但code码是错误提示的code,比如参数错误
//NSString *const HTTPServiceErrorDescriptionKey = @"HTTPServiceErrorDescriptionKey";//请求错误，详细描述key
//NSString *const HTTPServiceErrorMessagesKey = @"HTTPServiceErrorMessagesKey";//服务端错误提示，信息key

#endif /* DefineStructure_h */
