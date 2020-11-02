//
//  MyCoinVC+VM.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyCoinVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyCoinVC (VM)
//  POST /app/wallet/chargeGold 兑换金币
-(void)netWorking_MKWalletChargeGoldPOSTBlock:(MKDataBlock)block;
// POST /app/wallet/myWallet // 获取用户金币信息
-(void)netWorking_MKWalletMyWalletPOST;
// GET /app/wallet/chargeBalanceTips // 提示框
-(void)netWorking_ChargeBalanceTipsGET:(MKDataBlock)block;
@end

NS_ASSUME_NONNULL_END
