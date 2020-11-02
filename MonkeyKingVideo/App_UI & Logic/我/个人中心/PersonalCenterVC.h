//
//  PersonalCenterVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@class MKPersonalnfoModel;

@interface TipsV : UIView

-(instancetype)initWithTitle:(NSString *)titleStr
                  showNumber:(NSString *)showNumberStr;

@end

@interface PersonalCenterVC : BaseVC
/// 用户信息model
@property(strong,nonatomic)MKPersonalnfoModel *mkPernalModel;

@property(nonatomic,strong)id requestParams;

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
