//
//  MyVideoVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyVideoVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyVideoVC (VM)

-(void)value;
- (void)requestWith:(NSInteger)type WithPageNumber:(NSInteger)pageNumber WithPageSize:(NSInteger)pageSize  WithUserID:(NSString *)userId   WithType:(NSString *)dataType   Block:(MKDataBlock)block;
@end

NS_ASSUME_NONNULL_END
