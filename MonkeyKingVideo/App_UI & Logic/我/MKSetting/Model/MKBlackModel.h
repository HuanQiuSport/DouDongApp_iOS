//
//  MKBlackModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/13/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MKBlackSubModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKBlackModel : JSONModel

/// 列表
@property (strong,nonatomic) NSMutableArray<MKBlackSubModel,Optional> *list;

@property (assign,nonatomic) NSInteger total;
@end

NS_ASSUME_NONNULL_END
