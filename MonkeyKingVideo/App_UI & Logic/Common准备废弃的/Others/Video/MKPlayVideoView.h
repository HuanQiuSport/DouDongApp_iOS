//
//  MKPlayVideoView.h
//  KSPlayer
//
//  Created by hansong on 7/3/20.
//  Copyright © 2020 hansong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MKPlayUserInfoView.h"
#import "MKVideoPlayDelegate.h"
#import "MKVideoDemandModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MKVideoPlayDelegate;
@interface MKPlayVideoView : UIView

/// 用户信息
@property (strong,nonatomic) MKPlayUserInfoView *mkPlayUserView;
/// videoView
@property (strong,nonatomic) UIView *mkVideoView;

@property (strong,nonatomic) UIImageView *mkFontImageView;
/// 代理
@property (weak,nonatomic) id<MKVideoPlayDelegate> mkDelegate;

@property (nonatomic, strong) MKVideoDemandModel *mkModelLive;

@property (assign,nonatomic) NSInteger index;
-(void)mkReload:(NSString *)urlStr;

-(void)initPlayer:(NSString *)urlStr;
//+ (MKPlayVideoView *)shareMKPlayVideoView;
@end

NS_ASSUME_NONNULL_END
