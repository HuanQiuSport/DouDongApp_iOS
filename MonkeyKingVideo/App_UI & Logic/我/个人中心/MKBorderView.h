//
//  MKBorderView.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKMineDidDelegate.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MKMineDidDelegate;
@interface MKBorderView : UIView
///  按钮数组
@property (strong,nonatomic) NSArray *mkDataTitleArray;
@property (strong,nonatomic) NSArray *mkDataImageArray;
///  delegate
@property (weak,nonatomic) id<MKMineDidDelegate> mkDelegate;
@end

NS_ASSUME_NONNULL_END
