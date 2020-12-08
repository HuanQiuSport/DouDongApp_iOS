//
//  MKHTTPTool.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/2.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKHTTPTool : NSObject

+(instancetype)shareTool;

//上传图片
-(void)uploadVideoData:(NSData *)data
                  path:(NSString *)path
              progress:(void(^)(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend))uploadProgress
              callBack:(void(^)(bool status, NSError *error))callBack;


@end

NS_ASSUME_NONNULL_END
