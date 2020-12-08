//
//  MKChangeNameController.h
//  MonkeyKingVideo
//
//  Created by Mose on 2020/9/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKChangeNameController : BaseViewController

@property(nonatomic,assign)BOOL isSave;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

-(void)actionChangeNickNameBlock:(MKDataBlock)changeNickNameBlock;

@end

NS_ASSUME_NONNULL_END
