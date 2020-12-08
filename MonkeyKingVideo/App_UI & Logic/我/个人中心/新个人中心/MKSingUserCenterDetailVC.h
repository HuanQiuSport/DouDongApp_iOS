//
//  MKSingUserCenterDetailVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class MKPersonalnfoModel;
@class MKPersonalLikeModel;

@interface MKSingUserCenterDetailVC : BaseViewController <JXPagerViewListViewDelegate>
@property (strong,nonatomic) MKPersonalLikeModel *mkLikeModel;
/// 用户信息model
@property (strong,nonatomic) MKPersonalnfoModel *mkPernalModel;
/// 2 ： 作品 ｜  1 ： 喜欢
@property (strong,nonatomic) NSString *type;
/// 1  ： 我   ｜  2 ：其他用户
@property (strong,nonatomic) NSString *type2;

@property (nonatomic,strong) NSMutableSet *videidsSet;
- (void)refrushData;
- (void)requestData;
@end

NS_ASSUME_NONNULL_END
