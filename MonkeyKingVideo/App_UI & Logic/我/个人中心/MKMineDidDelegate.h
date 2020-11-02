//
//  MKMineDidDelegate.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKMineDidDelegate <NSObject>


@optional;

- (void)didClickMineView:(UIView *)superView WithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
