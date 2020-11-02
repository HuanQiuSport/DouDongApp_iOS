//
//  MKBaseVC.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/9/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 独立使用鸡肋VC  又不得不使用 哎
@interface MKBaseVC : UIViewController

@property (strong,nonatomic) UIView *navView;

@property (strong,nonatomic) UILabel * navTitleLb;
/// 返回
@property (strong,nonatomic) UIButton *navBackBt;
/// 說明;
@property (strong,nonatomic) UIButton  *delegateBt;

@property (strong,nonatomic) UIView *statusView;
@end

NS_ASSUME_NONNULL_END
