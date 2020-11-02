//
//  MKSettingCell.h
//  MonkeyKingVideo
//
//  Created by hansong on 6/26/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKSetingView.h"
NS_ASSUME_NONNULL_BEGIN

/// 设置cell
@interface MKSettingCell : UITableViewCell
///  set 子视图
@property (strong,nonatomic) MKSetingView *mkSettingView;
@end

NS_ASSUME_NONNULL_END
