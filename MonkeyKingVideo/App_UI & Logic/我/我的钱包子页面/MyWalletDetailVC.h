//
//  MyWalletVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "WalletInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyWalletDetailVC : BaseVC

@property (nonatomic, strong) UILabel *balanceCount;
@property(nonatomic,copy)NSString *canWithdrawNub;

@property(nonatomic,copy)NSString *siginNumb;

@property(nonatomic,copy)NSString *friendNumb;

@property(nonatomic,copy)NSString *withdrawNumb;

@property(nonatomic,strong) WalletInfoModel *walletModel;

- (void)initUI;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
