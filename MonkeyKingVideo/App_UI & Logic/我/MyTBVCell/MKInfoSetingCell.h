//
//  MKInfoSetingCell.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol  MKInfoSetingCellDelegate <NSObject>

- (void)didClickDelegate:(UIView *)superView WithIndex:(NSIndexPath *)indexPath;

@end


@interface MKInfoSetingCell : UITableViewCell
///  标题
@property (strong,nonatomic) UILabel  *mkTitleLable;

///  开关
@property (strong,nonatomic) UISwitch *mkSwich;

/// 代理
@property (weak,nonatomic) id<MKInfoSetingCellDelegate> mkDelegate;

///
@property (strong,nonatomic) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
