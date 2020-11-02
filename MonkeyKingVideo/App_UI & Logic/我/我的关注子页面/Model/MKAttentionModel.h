//
//  MKAttentionModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MKAttentionSubModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKAttentionModel : JSONModel
/// 列表
@property (strong,nonatomic) NSMutableArray<MKAttentionSubModel,Optional> *list;
@property (assign,nonatomic) NSInteger total;
@end

NS_ASSUME_NONNULL_END
