//
//  HomeAdView.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/9.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeAdView : UIView
@property (nonatomic, copy) void(^tapClickBlock)(void);
@property (nonatomic, copy) void(^timerEndBlock)(void);
-(void)showTo:(UIView *)view;
-(void)remove;
@end

NS_ASSUME_NONNULL_END
