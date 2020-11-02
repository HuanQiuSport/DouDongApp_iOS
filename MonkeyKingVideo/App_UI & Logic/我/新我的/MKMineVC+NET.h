//
//  MKMineVC+NET.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKMineVC.h"
#import "MKPersonalnfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKMineVC (NET)
#pragma mark - 获取基本信息
- (void)getDataUserData:(NSString *)authorId
                  Block:(MKDataBlock)block;
-(void)netWorking_MKWalletMyWalletPOST;
@end

NS_ASSUME_NONNULL_END
