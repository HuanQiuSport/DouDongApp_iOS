//
//  MKAdLoadView.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/28/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKAdLoadView : UIView
@property (strong,nonatomic) UIImageView *mkImageView;
@property (strong,nonatomic) UILabel  *mkTitleLabel;
@property (strong,nonatomic) UILabel  *mkDecribeLabel;
@property (strong,nonatomic) UIButton  *mkButton;
@end

NS_ASSUME_NONNULL_END
