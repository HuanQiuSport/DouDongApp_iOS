//
//  MKVideoController.m
//  MonkeyKingVideo
//
//  Created by Mose on 2020/9/23.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKVideoController.h"

@interface MKVideoController ()

@end

@implementation MKVideoController

- (instancetype)initWithCameraConfig:(SDVideoConfig *)config {
    
    if (config.returnViewController == nil) {
        NSString *exceptionContent = [NSString stringWithFormat:@"需要设置根控制器,以便于dismiss使用"];
        @throw [NSException exceptionWithName:@"returnViewController has not Setting" reason:exceptionContent userInfo:nil];
    }
    
    SDVideoCameraController *cameraController = [[SDVideoCameraController alloc] initWithCameraConfig:config];
    
    if (self = [super initWithRootViewController:cameraController]) {
        self.cameraController = cameraController;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}


@end
