//
//  UserInfoTBVCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TBVCell_style_02.h"

NS_ASSUME_NONNULL_BEGIN

/// 个人中心——用户信息
@interface UserInfoTBVCell : TBVCell_style_02
@property(nonatomic,strong)UIImageView *headPortraitIMGV;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UILabel *userOtherInfoLab;
@property(nonatomic,strong)UILabel *userSignatureLab;
@property(nonatomic,strong)UIImageView *editIMGV;
@property(nonatomic,strong)FSCustomButton *attentionBtn;
@property(nonatomic,strong)FSCustomButton *fansBtn;
@property(nonatomic,strong)FSCustomButton *likeBtn;
@property(nonatomic,copy)MKDataBlock actionBlock;

+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;
-(void)action:(MKDataBlock)actionBlock;

@end

NS_ASSUME_NONNULL_END
