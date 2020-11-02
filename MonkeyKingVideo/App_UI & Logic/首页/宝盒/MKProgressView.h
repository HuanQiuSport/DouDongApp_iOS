//
//  MKProgressView.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/4/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKProgressView : UIView
//@property(nonatomic,assign)CGFloat value ;
/////
//@property (strong,nonatomic) UIColor *mkColor;

- (void)drawProgress:(CGFloat )progress;
@end

NS_ASSUME_NONNULL_END
