//
//  MKChangePersonalizedSignatureVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKChangePersonalizedSignatureVC : BaseViewController

@property(nonatomic,assign)BOOL isSave;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

-(void)actionChangePersonalizedSignatureBlock:(MKDataBlock)changePersonalizedSignatureBlock;

@end

NS_ASSUME_NONNULL_END
