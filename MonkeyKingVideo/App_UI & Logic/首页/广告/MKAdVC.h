//
//  MKAdVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/23/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "MKVideoAdModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKAdVC : BaseViewController

@property(strong,nonatomic)MKVideoAdModel *mkVideoAd;

-(void)MKAdActionBlock:(MKDataBlock)adActionBlock;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
