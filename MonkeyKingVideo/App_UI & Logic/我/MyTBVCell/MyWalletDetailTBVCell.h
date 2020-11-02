//
//  MyWalletDetailTBVCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TBVCell_style_02.h"

NS_ASSUME_NONNULL_BEGIN
///金币流水的收入类型
typedef enum : NSUInteger {
    BalanceType_Style1 = 0,//视频收入
    BalanceType_Style2,//完善身份信息收入
    BalanceType_Style3,//填写邀请码收入、
    BalanceType_Style4,//完善实名信息收入、
    BalanceType_Style5//签到收入、
} BalanceType;
///余额流水类型为
typedef enum : NSUInteger {
    BalanceDetail_Style1 = 0,// 新人礼包
    BalanceDetail_Style2,//金币转换零钱
    BalanceDetail_Style3,//余额兑换会员
    BalanceDetail_Style4,//活跃用户收入
} BalanceDetailStyle;

typedef enum : NSUInteger {
    InOutType_in = 0,//收入
    InOutType_out,//支出
} InOutType;

@interface MyWalletDetailTBVCell : TBVCell_style_02

+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END

//一、金币流水的收入类型包含：
//
//1、视频收入、
//2、完善身份信息收入、
//3、填写邀请码收入、
//4、完善实名信息收入、
//5、签到收入、
//
//二、金币的支出类型为：金币转余额；

//余额流水类型为：
//1、新人礼包（0.38元）;
//2、金币转零钱;
//3、金币兑换会员;
