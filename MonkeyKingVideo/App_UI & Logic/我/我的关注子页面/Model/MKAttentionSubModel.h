//
//  MKAttentionSubModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MKAttentionSubModel <NSObject>
@end
@interface MKAttentionSubModel : JSONModel
///
@property (strong,nonatomic) NSString <Optional>*id;
@property (strong,nonatomic) NSString <Optional>*userId;
@property (strong,nonatomic) NSString <Optional>*userFansId;
@property (strong,nonatomic) NSString <Optional>*createTime;
@property (strong,nonatomic) NSString <Optional>*createUser;
@property (strong,nonatomic) NSString <Optional>*updateTime;
@property (strong,nonatomic) NSString <Optional>*updateUser;
@property (strong,nonatomic) NSString <Optional>*account;
@property (strong,nonatomic) NSString <Optional>*headImage;
@property (strong,nonatomic) NSString <Optional>*remark;
@property (strong,nonatomic) NSString <Optional>*fansNum;
@property (strong,nonatomic) NSString <Optional>*constellation;
@property (strong,nonatomic) NSString <Optional>*birthday;
@property (strong,nonatomic) NSString <Optional>*area;
@property (strong,nonatomic) NSString <Optional>*focusNum;
@property (strong,nonatomic) NSString <Optional>*praiseNum;
@property (strong,nonatomic) NSString <Optional>*nickName;
@property (strong,nonatomic) NSString <Optional>*isVip;
@property (strong,nonatomic) NSString <Optional>*areSelf;
///  0  没有关注 ｜  1  关注了
@property (strong,nonatomic) NSString <Optional>*attention;

@end

NS_ASSUME_NONNULL_END
