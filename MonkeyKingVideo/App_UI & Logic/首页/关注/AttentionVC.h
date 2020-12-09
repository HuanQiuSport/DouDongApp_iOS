//
//  AttentionVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "MKHAttentionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AttentionVC : BaseViewController

@property(nonatomic,strong)UITableView * _Nullable tableView;
@property (strong,nonatomic) UICollectionView *mkCollectionView;
/// 数据
@property (strong,nonatomic) MKHAttentionModel *mkhAttentionModel;

@end

NS_ASSUME_NONNULL_END
