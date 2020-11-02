//
//  MKBlackListVC+VM.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/13/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKBlackListVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKBlackListVC (VM)
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize Block:(MKDataBlock)block;
-(void)deleteBalckNameList:(NSString *)blackId WithBlock:(MKDataBlock)block;
@end

NS_ASSUME_NONNULL_END
