//
//  MKDouCoinTBCell.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/5.
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
///抖币流水类型为
typedef enum : NSUInteger {
    CoinDetail_Style1 = 0,// 视频收入
    CoinDetail_Style2,//完善身份信息收入
    CoinDetail_Style3,//邀请的好友看视频帮自己赚的收入
    CoinDetail_Style4,//绑定支付宝收入
    CoinDetail_Style5,//签到收入
    CoinDetail_Style6,//金币转换余额
} CoinDetailStyle;
typedef enum : NSUInteger {
    InOutType_in = 0,//收入
    InOutType_out,//支出
} InOutType;


@interface MKDouCoinTBCell : TBVCell_style_02
+(instancetype)cellWith:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
