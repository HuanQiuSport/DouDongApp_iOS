//
//  MKNoticeAlertView.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/12/4.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHNoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKNoticeAlertView : UIView
@property(nonatomic,weak) UIViewController *rootVc;
-(void)show:(NSArray<MKHNoticeModel *> *)dataSource;

@end

NS_ASSUME_NONNULL_END
