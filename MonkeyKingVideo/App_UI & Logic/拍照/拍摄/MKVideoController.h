//
//  MKVideoController.h
//  MonkeyKingVideo
//
//  Created by Mose on 2020/9/23.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "BaseViewController.h"
#import "SDVideoConfig.h"
#import "SDVideoCameraController.h"
//#import "<#header#>"

NS_ASSUME_NONNULL_BEGIN

@interface MKVideoController : UINavigationController

// SDVideoController 是仿写抖音录制一个库

- (instancetype)initWithCameraConfig:(SDVideoConfig *)config;

@property(nonatomic,strong)SDVideoCameraController *cameraController;

@end

NS_ASSUME_NONNULL_END
