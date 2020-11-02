//
//  SDVideoCameraMenuView.h
//  FamilyClassroom
//
//  Created by 王巍栋 on 2020/1/13.
//  Copyright © 2020 Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDVideoCameraHeader.h"
#import "SDVideoConfig.h"

#import "YQNumberSlideView.h"

typedef enum : int {
      /// 拍摄1分钟
      MKPlayerTimeType_A = 0,
      /// 拍摄3分钟
      MKPlayerTimeType_B,
      /// 拍摄5分钟
      MKPlayerTimeType_C,
     
} MKPlayerTimeType;

@protocol SDVideoCameraMenuDelegate <NSObject>

@optional

// 用户把视频合并完成,需要跳转下一个界面了
- (void)userFinishMergeVideoAction;

// 用户改变摄像头的变焦程度
- (void)userChangeVideoZoomFactorWithScale:(CGFloat)scale orientation:(TouchMoveOrientation)orientation;

// 用户停止改变摄像头的变焦程度(结束拖拽时)
- (void)userEndChangeVideoZoomFactor;

// 回删某个分段视频
- (void)deleteLaseVideoDataAction;

// 用户点击菜单按钮
- (void)userClickOutMenuButtonWithButtonType:(VideoMenuType)menuType;

// 用户点击展示相册事件
- (void)userClickAlbumAction;

// 用户打开了所有设备权限回调
- (void)userOpenAllDerviceAuthoAction;

@end

@interface SDVideoCameraMenuView : UIView

// SDVideoCameraMenuView 是视频录制界面控制层视图

- (instancetype)initWithFrame:(CGRect)frame cameraConfig:(SDVideoConfig *)config;

@property(nonatomic,weak)id <SDVideoCameraMenuDelegate>delegate;

@property(nonatomic,weak)UIViewController *superViewController;

@property(nonatomic,strong)UIButton *closeButton;

- (BOOL)isOpenAllDeviceAuthoStateAction;
/// 拍摄时间
@property (assign,nonatomic) MKPlayerTimeType mkPlayerTimeType;

@property(nonatomic,strong)UIView *progressView;
@property(nonatomic,strong)UIView *progressCurrentView;
@property(nonatomic,strong) UILabel  *lineLabel;
@property(nonatomic,strong) UILabel  *timeLabel;
@property (nonatomic,strong) YQNumberSlideView *slideView;
@property(nonatomic,strong)UIView *indexView;

@property(nonatomic,strong)UIButton *deleteVideoButton;
@property(nonatomic,strong)UIButton *finishButton;


@end

