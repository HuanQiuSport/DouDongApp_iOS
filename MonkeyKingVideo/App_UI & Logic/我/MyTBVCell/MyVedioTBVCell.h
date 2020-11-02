//
//  MyVedioTBVCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TBVCell_style_02.h"
#import "Release&LikeVC.h"
NS_ASSUME_NONNULL_BEGIN

/// 个人中心——我的视频
@interface MyVedioTBVCell : TBVCell_style_02

@property(nonatomic,copy)MKDataBlock actionBlock;
@property(nonatomic,strong)Release_LikeVC  *release_LikeVC;
+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;

-(void)action:(MKDataBlock)actionBlock;

@end

NS_ASSUME_NONNULL_END
