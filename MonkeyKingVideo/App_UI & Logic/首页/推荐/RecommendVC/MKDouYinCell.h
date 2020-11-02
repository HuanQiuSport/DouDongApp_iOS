//
//  MKDouYinCell.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKVideoDemandModel.h"
#import "MKRightBtnView.h"
#import "GKDoubleLikeView.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,DouYinCellActionType) {
    /// 评论
    type_comment,
    /// 点赞
    type_support,
    /// 分享
    type_share,
    /// 用户信息
    type_userInfo,
    ///关注
    type_focus,
};
@protocol MKDouYinDelegate <NSObject>

- (void)cellAction:(MKVideoDemandModel *)model type:(DouYinCellActionType)actionType view:(UIView *__nullable)view withIndexPath:(NSIndexPath *)indexPath;

@end
@interface MKDouYinCell : UITableViewCell
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) MKRightBtnView *rightBtnView;
@property (nonatomic, strong) UIButton *getPointBtn;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIButton *focusBtn;
@property (nonatomic, strong) UILabel *content;
@property (nonatomic, strong) UIImage *placeholderImage;
///
@property (strong,nonatomic) UIImageView *mkVipImage;
@property (nonatomic, strong) MKVideoDemandModel *videoModel;
@property (nonatomic, strong) GKDoubleLikeView *doubleLikeView;
@property (nonatomic, strong)MKVideoDemandModel *model;
@property (nonatomic, weak)id <MKDouYinDelegate> delegate;
///
@property (strong,nonatomic) NSIndexPath *mkCellIndex;
///
@property (assign,nonatomic) MKVideoListType mkListType;
@end

NS_ASSUME_NONNULL_END
