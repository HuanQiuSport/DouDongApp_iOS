//
//  MyFansTBVCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TBVCell_style_02.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyFansTBVCell : TBVCell_style_02

+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
