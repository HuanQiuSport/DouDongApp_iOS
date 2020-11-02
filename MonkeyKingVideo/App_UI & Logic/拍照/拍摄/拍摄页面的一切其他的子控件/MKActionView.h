//
//  MKActionView.h
//  MonkeyKingVideo
//
//  Created by george on 2020/9/15.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKActionViewDelegate <NSObject>

- (void)mkDeleteActionViewConfirm;

@end

@interface MKActionView : UIView

@property(nonatomic,weak)id delegate;

+ (instancetype) show:(id)delegate;

@end

NS_ASSUME_NONNULL_END
