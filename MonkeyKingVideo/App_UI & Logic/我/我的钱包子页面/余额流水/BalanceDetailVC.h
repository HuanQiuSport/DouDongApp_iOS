//
//  BalanceDetailVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "MyWalletDetailTBVCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BalanceDetailVC : BaseVC

@property(nonatomic,strong)UITableView * _Nullable tableView;
@property(nonatomic,strong)MKWalletMyFlowsModel *walletMyFlowsModel;
@property(nonatomic,strong)NSMutableArray <MKWalletMyFlowsListModel *>*walletMyFlowsListModelMutArr;
@property(nonatomic,assign)MyWalletStyle walletStyle;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
