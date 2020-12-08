//
//  MKInfoListVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class MKSysModel;

@interface MKInfoListVC : BaseViewController
/// MKSysModel
@property (strong,nonatomic) MKSysModel *mkParamModle;
/// data
@property (strong,nonatomic) NSMutableArray <MKSysModel*>*mkDataArray;

@end

NS_ASSUME_NONNULL_END
