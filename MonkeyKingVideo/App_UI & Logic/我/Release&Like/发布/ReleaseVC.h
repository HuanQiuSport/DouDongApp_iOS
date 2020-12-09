//
//  ReleaseVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewController.h"
#import "MKPersonMadeVideoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReleaseVC : BaseViewController
/// 用户作品信息 model
@property (strong,nonatomic) MKPersonMadeVideoModel *mkMadeModel;

@end

NS_ASSUME_NONNULL_END
