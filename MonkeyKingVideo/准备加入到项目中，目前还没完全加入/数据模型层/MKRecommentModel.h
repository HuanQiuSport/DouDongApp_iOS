//
//  MKRecommentModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/13/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "MKVideoDemandModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKRecommentModel : JSONModel
@property (strong,nonatomic) NSMutableArray<MKVideoDemandModel,Optional> *list;
@property (assign,nonatomic) NSInteger total;
@end

NS_ASSUME_NONNULL_END
