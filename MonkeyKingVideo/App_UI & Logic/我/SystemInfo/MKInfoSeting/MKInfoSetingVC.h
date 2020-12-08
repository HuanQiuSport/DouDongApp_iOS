//
//  MKInfoSetingVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
@class MKSysModel;

NS_ASSUME_NONNULL_BEGIN

@interface MKInfoSetingVC : BaseViewController
/// data
@property (strong,nonatomic) NSMutableArray <MKSysModel*>*mkDataArray;

@end

NS_ASSUME_NONNULL_END
