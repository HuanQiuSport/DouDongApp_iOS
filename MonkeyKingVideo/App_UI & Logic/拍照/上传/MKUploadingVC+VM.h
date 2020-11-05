//
//  MKUploadingVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKUploadingVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKUploadingVC (VM)

- (void)videosUploadNetworkingWithData:(NSData *)data
                          videoArticle:(NSString *)videoArticle
                              urlAsset:(AVURLAsset *)urlAsset videoTime:(CGFloat)videoTime;

- (void)presignedUploadUrl:(NSString *)fileName
                videoTitle:(NSString *)videoTitle
                    data:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
