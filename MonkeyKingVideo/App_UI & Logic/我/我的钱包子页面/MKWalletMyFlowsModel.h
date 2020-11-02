//
//  MKWalletMyFlows.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/22.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKWalletMyFlowsListModel : BaseModel

@property(nonatomic,strong)NSString *amount;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSNumber *Delete;
///0、视频收入；1、完善身份信息收入；2、填写邀请码收入；3、完善实名信息收入；4、签到收入
@property(nonatomic,strong)NSNumber *goldType;//CoinDetail_income_Style
@property(nonatomic,strong)NSString *moneyType;//DouCoinDetail_income_Style
@property(nonatomic,strong)NSString *ID;
///0、收入；1、支出
@property(nonatomic,strong)NSNumber *inOutType;//InOutType 
///0、视频收入；1、完善身份信息收入；2、完善实名信息收入；3、签到收入；4、金币转换余额
@property(nonatomic,strong)NSNumber *balanceType;//BalanceType
@property(nonatomic,strong)NSString *updateTime;
@property(nonatomic,strong)NSString *userId;

@end

@interface MKWalletMyFlowsModel : BaseModel

@property(nonatomic,strong)MKWalletMyFlowsListModel *listModel;

@end

NS_ASSUME_NONNULL_END

//{余额流水账
//    amount = "0.380000";
//    balanceType = 2;
//    createTime = 1595429953000;
//    delete = 0;
//    id = 1282328666894753795;
//    inOutType = 1;
//    updateTime = 1594565953000;
//    userId = 1285820000662298625;
//}

//{金币流水账
//    amount = "100.00";
//    createTime = 1595420690000;
//    delete = 0;
//    goldType = 3;
//    id = 1284464139901542403;
//    inOutType = 0;
//    updateTime = 1595075090000;
//    userId = 1285820000662298625;
//}

//{
//    endRow = 2;
//    hasNextPage = 0;
//    hasPreviousPage = 0;
//    isFirstPage = 1;
//    isLastPage = 1;
//    list =     (
//                {
//            amount = "100.00";
//            createTime = 1595420690000;
//            delete = 0;
//            goldType = 3;
//            id = 1284464139901542403;
//            inOutType = 0;
//            updateTime = 1595075090000;
//            userId = 1285820000662298625;
//        },
//                {
//            amount = "123.00";
//            createTime = 1595420690000;
//            delete = 0;
//            goldType = 5;
//            id = 1284464139901542404;
//            inOutType = 1;
//            updateTime = 1595075090000;
//            userId = 1285820000662298625;
//        }
//    );
//    navigateFirstPage = 1;
//    navigateLastPage = 1;
//    navigatePages = 8;
//    navigatepageNums =     (
//        1
//    );
//    nextPage = 0;
//    pageNum = 1;
//    pageSize = 10;
//    pages = 1;
//    prePage = 0;
//    size = 2;
//    startRow = 1;
//    total = 2;
//}
