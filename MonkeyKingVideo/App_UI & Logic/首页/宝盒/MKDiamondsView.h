//
//  MKDiamondsView.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/10/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
#import "MKHomeCoinView.h"
NS_ASSUME_NONNULL_BEGIN

/// 钻石宝盒view
@interface MKDiamondsView : UIView
@property (strong,nonatomic) UIImageView *mkImageView;
//@property (strong,nonatomic) UIImageView *mkCoinImageView;
//@property (strong,nonatomic) UILabel *mkCoinNumberImageView;
@property (strong,nonatomic) MZTimerLabel *timerExample3;
///
@property (strong,nonatomic) MKHomeCoinView *mkHomeCoinView;
- (void)resetTime:(NSInteger)time;

-(void)stopAddDiamond;
-(void)cotinueDiamond;
- (void)startAddDiamond;
- (void)resetTime;
- (void)mkSetDiamondNumber:(NSString *)floatNumber;
- (void)mkSetDiamondNumber:(NSString *)floatNumber WithDecountTime:(NSString *)timeFloatNumber;
@end

NS_ASSUME_NONNULL_END
