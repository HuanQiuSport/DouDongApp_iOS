//
//  MKRevisePasswordViewController+VM.h
//  MonkeyKingVideo
//
//  Created by george on 2020/9/16.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKRevisePasswordViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKRevisePasswordViewController (VM)
-(void)resetPasswordWith:(NSString *)oldPassword
    newPassword:(NSString *)newPassword
confirmPassword:(NSString*)confirmPassword
                    data:(MKDataBlock)block;
@end

NS_ASSUME_NONNULL_END
