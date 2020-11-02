//
//  DouCoinDetailVC.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/5.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DouCoinDetailVC : BaseVC
@property(nonatomic,strong)UITableView * _Nullable tableView;
@property(nonatomic,strong)MKWalletMyFlowsModel *walletMyFlowsModel;
@property (nonatomic, assign) NSInteger page;// 分页
@property(nonatomic,strong)NSMutableArray <MKWalletMyFlowsListModel *>*walletMyFlowsListModelMutArr;
@property(nonatomic,assign)MyWalletStyle walletStyle;
- (void)pullToRefresh;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
