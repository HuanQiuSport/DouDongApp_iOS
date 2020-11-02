//
//  MKEditUserInfoCell.h
//  MonkeyKingVideo
//
//  Created by blank blank on 2020/9/10.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKUserInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKEditUserInfoCell : UITableViewCell
@property (nonatomic, strong) UILabel *leftLab;
@property (nonatomic, strong) UILabel *rightLab;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIView *line;
- (void)hideIcon:(BOOL)hidden;
@end

NS_ASSUME_NONNULL_END
