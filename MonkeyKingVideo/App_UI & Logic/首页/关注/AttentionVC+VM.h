//
//  AttentionVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AttentionVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttentionVC (VM)
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize  WithUserId:(NSString *)userID Block:(MKDataBlock)block;
@end

NS_ASSUME_NONNULL_END
