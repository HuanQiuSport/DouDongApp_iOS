//
//  MKInfoDetailCell.h
//  MonkeyKingVideo
//
//  Created by hansong on 6/30/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKSysModel;

NS_ASSUME_NONNULL_BEGIN

@interface MKInfoDetailCell : UITableViewCell

@property (strong,nonatomic) MKSysModel *model;

+ (instancetype) MKInfoDetailCellWith:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
