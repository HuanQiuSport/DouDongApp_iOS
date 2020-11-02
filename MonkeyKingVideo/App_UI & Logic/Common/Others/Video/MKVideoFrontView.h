//
//  MKVideoFrontView.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKPlayUserInfoView;
@class MKVideoDemandModel;
NS_ASSUME_NONNULL_BEGIN

@interface MKVideoFrontView : UIView
///  当前model
@property (strong,nonatomic) MKVideoDemandModel *mkLive;
///  当前model  封面图片
@property (strong,nonatomic) UIImageView *mkImageView;

///  当前 用户信息
@property (strong,nonatomic) MKPlayUserInfoView *mkUserInfoView;

- (void)updatePageInfo:(MKPlayUserInfoView *)playerScrollView WithModel:(MKVideoDemandModel *)live;
@end

NS_ASSUME_NONNULL_END
