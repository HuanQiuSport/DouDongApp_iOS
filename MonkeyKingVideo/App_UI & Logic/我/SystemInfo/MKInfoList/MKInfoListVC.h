//
//  MKInfoListVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@class MKSysModel;

@interface MKInfoListVC : BaseVC
/// MKSysModel
@property (strong,nonatomic) MKSysModel *mkParamModle;
/// data
@property (strong,nonatomic) NSMutableArray <MKSysModel*>*mkDataArray;

@end

NS_ASSUME_NONNULL_END
