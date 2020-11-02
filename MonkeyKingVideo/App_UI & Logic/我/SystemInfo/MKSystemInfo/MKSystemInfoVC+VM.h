//
//  MKSystemInfoVC+VM.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/13/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSystemInfoVC.h"
@class MKSysModel;

NS_ASSUME_NONNULL_BEGIN

@interface MKSystemInfoVC (VM)

- (void)getData:(MKDataBlock)block;
- (void)readData:(MKDataBlock)block WithData:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
