//

//  AnotherTBVCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TBVCell_style_02.h"

NS_ASSUME_NONNULL_BEGIN

/// 个人中心——其他
@interface AnotherTBVCell : TBVCell_style_02
@property(nonatomic,strong)FSCustomButton *btn_1;
@property(nonatomic,strong)FSCustomButton *btn_2;
@property(nonatomic,strong)FSCustomButton *btn_3;
@property(nonatomic,copy)MKDataBlock actionBlock;

+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;

-(void)action:(MKDataBlock)actionBlock;

@end

NS_ASSUME_NONNULL_END
