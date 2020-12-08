//
//  MKBlackListVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "MKBlackModel.h"
NS_ASSUME_NONNULL_BEGIN

/// 黑名单
@interface MKBlackListVC : BaseViewController
///
@property (strong,nonatomic) MKBlackModel *mkBlackModel;
@end

NS_ASSUME_NONNULL_END
