//
//  PersonalCenterVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class MKPersonalnfoModel;

@interface TipsV : UIView

-(instancetype)initWithTitle:(NSString *)titleStr
                  showNumber:(NSString *)showNumberStr;

@end

@interface PersonalCenterVC : BaseViewController
/// 用户信息model
@property(strong,nonatomic)MKPersonalnfoModel *mkPernalModel;

@end

NS_ASSUME_NONNULL_END
