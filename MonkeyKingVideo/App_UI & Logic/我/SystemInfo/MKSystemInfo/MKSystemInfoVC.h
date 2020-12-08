//
//  MKSystemInfoVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 6/29/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "MKSysModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSystemInfoVC : BaseViewController
/// data
@property (strong,nonatomic) NSMutableArray <MKSysModel*>*mkDataArray;

@end

NS_ASSUME_NONNULL_END
