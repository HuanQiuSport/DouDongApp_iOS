//
//  BalanceDetailVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "MyWalletDetailTBVCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface BalanceDetailVC : BaseViewController

@property(nonatomic,strong)UITableView * _Nullable tableView;
@property(nonatomic,strong)MKWalletMyFlowsModel *walletMyFlowsModel;
@property(nonatomic,strong)NSMutableArray <MKWalletMyFlowsListModel *>*walletMyFlowsListModelMutArr;
@property(nonatomic,assign)MyWalletStyle walletStyle;

@end

NS_ASSUME_NONNULL_END
