//
//  MKInfoListVC+VM.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKInfoListVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKInfoListVC (VM)

- (void)getDataWithID:(NSString *)idstr
            WithBlock:(MKDataBlock)block;

@end

NS_ASSUME_NONNULL_END
