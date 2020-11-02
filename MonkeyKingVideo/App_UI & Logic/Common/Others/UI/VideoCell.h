//
//  VedioCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoCell : UICollectionViewCell

///  videoType 普通视频播放类型
@property (assign,nonatomic) MKVideoType mkVideoType;

///  videoType  视频作品状态类型
@property (assign,nonatomic) MKVideoOfMineType  mkVideoOfMineType;

///  videoType  视频作品审核状态类型
@property (assign,nonatomic) MKVideoOfReviewType  mkVideoOfReviewType;

+(CGFloat)cellHeightWithModel:(id _Nullable)model;
-(void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
