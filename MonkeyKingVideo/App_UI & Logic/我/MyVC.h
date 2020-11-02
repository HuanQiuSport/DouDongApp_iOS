//
//  MyVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyVC : BaseVC

@property(nonatomic,strong)UITableView * _Nullable tableView;
@property(nonatomic,strong)MyVCModel *myVCModel;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
