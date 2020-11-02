//
//  MyWalletDetailVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyWalletDetailVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyWalletDetailVC (VM)

// POST /app/wallet/withdrawBalance 余额提现
-(void)MKWalletWithdrawBalance_POST;
// GET /app/wallet/getWithdrawType MKgetWithdrawTypeGET 提现类型
-(void)MKWalletWithdrawBalance_GET;
// 获取用户信息
-(void)netWorking_MKWalletMyWalletPOST;
@end

NS_ASSUME_NONNULL_END
