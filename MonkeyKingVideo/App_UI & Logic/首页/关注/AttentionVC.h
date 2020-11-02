//
//  AttentionVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "MKHAttentionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AttentionVC : BaseVC

@property(nonatomic,strong)UITableView * _Nullable tableView;
@property (strong,nonatomic) UICollectionView *mkCollectionView;
/// 数据
@property (strong,nonatomic) MKHAttentionModel *mkhAttentionModel;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
