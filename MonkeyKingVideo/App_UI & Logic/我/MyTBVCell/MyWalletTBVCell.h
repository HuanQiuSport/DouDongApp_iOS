//
//  MyWalletTBVCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TBVCell_style_02.h"

NS_ASSUME_NONNULL_BEGIN

/// 个人中心——我的钱包
@interface Coin : UIView

@property(nonatomic,strong)UIImageView *coinIMGV;
@property(nonatomic,copy)MKDataBlock actionBlock;
@property(nonatomic,strong)UILabel *showNumLab;
@property(nonatomic,copy)NSString *tagStr;

-(instancetype)initWithTitleStr:(NSString *)titleStr;
-(void)action:(MKDataBlock)actionBlock;

@end

@interface MyWalletTBVCell : TBVCell_style_02

@property(nonatomic,strong)Coin *coin_1_V;
@property(nonatomic,strong)Coin *coin_2_V;
@property(nonatomic,copy)MKDataBlock actionBlock;

+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;
-(void)action:(MKDataBlock)actionBlock;

@end

NS_ASSUME_NONNULL_END
