//
//  MKHomeCoinView.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/14/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKHomeCoinView : UIView
///  金币图片
@property (strong,nonatomic) UIImageView *mkImageView;
///  金币数量
@property (strong,nonatomic) UILabel *mkCoinNumberLabel;
@end

NS_ASSUME_NONNULL_END
