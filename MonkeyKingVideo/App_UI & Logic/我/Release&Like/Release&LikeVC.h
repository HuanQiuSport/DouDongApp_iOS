//
//  Release&LikeVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"
#import "LikeVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface Release_LikeVC : BaseVC
@property (strong,nonatomic) LikeVC *mkLiked;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
