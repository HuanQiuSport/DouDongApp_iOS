//
//  MKNetWork.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/28/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN
@interface MKNetWork : NSObject

+ (MKNetWork *)shared;
- (void)requestZanWith:(NSString*)videoID WithPraise:(NSString*)isPraise WithBlock:(TwoDataBlock)block;
@end

NS_ASSUME_NONNULL_END
