//
//  MakeCoinRuleView.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/12/4.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SeeCoinBlock)(void);
@interface MakeCoinRuleView : UIView
@property(nonatomic,copy) SeeCoinBlock seeCoinBlock;
+(MakeCoinRuleView *)ruleView;
-(void)show:(UIViewController *)rootVc;
-(void)dismiss:(UIViewController *)rootVc;

@end

NS_ASSUME_NONNULL_END
