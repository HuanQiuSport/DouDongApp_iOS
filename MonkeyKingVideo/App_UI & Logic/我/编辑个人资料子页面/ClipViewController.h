//
//  ClipViewController.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "BaseViewController.h"
@protocol CropImageDelegate <NSObject>

- (void)cropImageDidFinishedWithImage:(UIImage *)image;

@end

@interface ClipViewController : BaseViewController
@property (nonatomic, weak) id <CropImageDelegate> delegate;
//圆形裁剪，默认NO;
@property (nonatomic, assign) BOOL ovalClip;
- (instancetype)initWithImage:(UIImage *)originalImage delegate:(id)delegate;

//+ (instancetype)ComingFromVC:(UIViewController *)rootVC
//      comingStyle:(ComingStyle)comingStyle
//presentationStyle:(UIModalPresentationStyle)presentationStyle
//    requestParams:(nullable id)requestParams
//          success:(MKDataBlock)block
//         animated:(BOOL)animated;
@end
