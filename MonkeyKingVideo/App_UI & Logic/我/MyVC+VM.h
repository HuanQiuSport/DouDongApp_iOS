//
//  MyVC+VM.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyVC (VM)

- (void)test;
///APP钱包相关接口 —— POST 获取用户信息
-(void)netWorking_MKWalletMyWalletPOST;

@end

NS_ASSUME_NONNULL_END
