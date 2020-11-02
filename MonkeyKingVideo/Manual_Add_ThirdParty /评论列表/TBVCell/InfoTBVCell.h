//
//  InfoTBVCell.h
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoTBVCell : UITableViewCell

@property(nonatomic,strong)RBCLikeButton *LikeBtn;
@property(nonatomic,strong)MKChildCommentModel *childCommentModel;
@property(nonatomic, strong)UIButton *supportBtn;
@property(nonatomic, strong)UIImageView *heartIcon;
@property(nonatomic, strong)UILabel *countLab;
@property(nonatomic, strong)UIImageView *vipImageView;
@property(nonatomic, copy) void (^btnBlock)(UIButton *sender,UILabel *lab,UIImageView *icon);
@property(nonatomic, copy) void (^headerBlock)(NSDictionary *dic);
+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;
-(void)action:(MKDataBlock)actionBlock;


@end

NS_ASSUME_NONNULL_END
