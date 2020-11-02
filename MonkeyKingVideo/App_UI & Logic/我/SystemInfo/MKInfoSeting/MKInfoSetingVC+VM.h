//
//  MKInfoSetingVC+VM.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/15/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoSetingVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKInfoSetingVC (VM)

- (void)getDataWithDict:(NSMutableDictionary *)easyDict
              WithBlock:(MKDataBlock)block;

@end

NS_ASSUME_NONNULL_END
