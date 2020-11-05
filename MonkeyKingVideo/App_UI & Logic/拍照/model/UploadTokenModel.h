//
//  UploadTokenModel.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/2.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadTokenModel : NSObject
@property(nonatomic,copy) NSString *sign;
@property(nonatomic,copy) NSString *objectName;
@property(nonatomic,copy) NSString *region;
@property(nonatomic,copy) NSString *contentType;
@property(nonatomic,copy) NSString *bucketName;

@end

NS_ASSUME_NONNULL_END
