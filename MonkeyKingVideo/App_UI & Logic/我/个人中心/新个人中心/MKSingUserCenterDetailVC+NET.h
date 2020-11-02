//
//  MKSingUserCenterDetailVC+Net.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSingUserCenterDetailVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSingUserCenterDetailVC (Net)
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize  WithUserID:(NSString *)userId  WithType:(NSString *)dataType   Block:(MKDataBlock)block;

// 删除视频
- (void)MKDelAppVideo_POST_ViedoID:(NSString *)viedoID;
@end

NS_ASSUME_NONNULL_END
