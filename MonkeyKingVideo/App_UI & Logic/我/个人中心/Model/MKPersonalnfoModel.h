//
//  MKPersonalnfoModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPersonalnfoModel : JSONModel
/// id
@property (strong,nonatomic) NSString <Optional>*id;
/// 用户id
@property (strong,nonatomic) NSString <Optional>*userId;
/// 账户
@property (strong,nonatomic) NSString <Optional>*account;
/// 头像
@property (strong,nonatomic) NSString <Optional>*headImage;
/// 签名
@property (strong,nonatomic) NSString <Optional>*remark;
/// 粉丝
@property (strong,nonatomic) NSString <Optional>*fansNum;
/// 星座
@property (strong,nonatomic) NSString <Optional>*constellation;
/// 生日
@property (strong,nonatomic) NSString <Optional>*birthday;
/// 省
@property (strong,nonatomic) NSString <Optional>*area;
/// 点赞数量
@property (strong,nonatomic) NSString <Optional>*praiseNum;
/// 昵称
@property (strong,nonatomic) NSString <Optional>*nickName;
/// 性别
@property (strong,nonatomic) NSNumber <Optional>*sex;
/// 年龄
@property (strong,nonatomic) NSString <Optional>*age;
/// 是否关注
@property (strong,nonatomic) NSString <Optional>*attention;

/// 关注数量
@property (strong,nonatomic) NSString <Optional>*focusNum;


/// 喜欢视频数量
@property (strong,nonatomic) NSString <Optional>*videoPraiseNum;


/// 发布视频数量
@property (strong,nonatomic) NSString <Optional>*publicVideoNum;

/// 是不是自己
@property (strong,nonatomic) NSString <Optional>*areSelf;


///  余额
@property (strong,nonatomic) NSString <Optional>*balance;


///  金币数
@property (strong,nonatomic) NSString <Optional>*goldNumber;

///  金币数
@property (strong,nonatomic) NSString <Optional>*isVip;


@end

NS_ASSUME_NONNULL_END
