//
//  MKLoginModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 用户信息数据模型
@interface MKLoginModel : JSONModel
@property(nonatomic,strong)NSString <Optional>*account;
@property(nonatomic,strong)NSString <Optional>*nickName;
@property(nonatomic,strong)NSString <Optional>*tel;
@property(nonatomic,strong)NSString <Optional>*token;
#pragma mark - 用户ID 用来获取 我的喜欢列表数据
@property(nonatomic,strong)NSString <Optional>*uid;
@property(nonatomic,strong)NSString <Optional>*age;
@property(nonatomic,strong)NSString <Optional>*area;
@property(nonatomic,strong)NSString <Optional>*sex;
@property(nonatomic,strong)NSString <Optional>*balance;
@property(nonatomic,strong)NSString <Optional>*constellation;
@property(nonatomic,strong)NSString <Optional>*goldNumber;
@property(nonatomic,strong)NSString <Optional>*remark;
@property(nonatomic,strong)NSString <Optional>*headImage;
@property(nonatomic,strong)NSString <Optional>*praiseNum;
@property(nonatomic,strong)NSString <Optional>*fansNum;
@property(nonatomic,strong)NSString <Optional>*focusNum;
@property(nonatomic,strong)NSString <Optional>*adPlayTime;
#pragma mark - 宝箱和宝盒配置数据
@property(nonatomic,strong)NSString <Optional>*boxRewardNums;
@property(nonatomic,strong)NSString <Optional>*consume;
@property(nonatomic,strong)NSString <Optional>*durationForBox;
@property(nonatomic,strong)NSString <Optional>*durationForRandom;
@property(nonatomic,strong)NSString <Optional>*randomRewardCount;
@property(nonatomic,strong)NSString <Optional>*randomRewardNums;
#pragma mark - 宝盒播放数据
@property(nonatomic,strong)NSMutableDictionary <Optional>*videoPlayInfo;
@property(nonatomic,strong)NSString <Optional>*coinStartPlayTime;
#pragma mark - 宝箱播放数据
@property(nonatomic,strong)NSString <Optional>*diamondsStartPlayTime;
@property(nonatomic,strong)NSMutableArray <Optional>*diamondsVideoPlayTime;
@property(nonatomic,strong)NSMutableArray <Optional>*videoPlayTime;

@end

NS_ASSUME_NONNULL_END
