//
//  MKBtnLabelView.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBtnLabelView : UIView
///  number
@property (strong,nonatomic) UILabel *mkNumberLabel;

///  标题
@property (strong,nonatomic) UILabel *mkTitleLabel;


///  按钮
@property (strong,nonatomic) UIButton *mkButton;

-(void)refreshSkin;
@end

NS_ASSUME_NONNULL_END
