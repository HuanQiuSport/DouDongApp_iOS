//
//  MKWithdrawSucessVC.m
//  MonkeyKingVideo
//
//  Created by george on 2020/9/23.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKWithdrawSucessVC.h"
#import "MKWithdrawSucessView.h"
#import "MKExchangeBalanceModel.h"
///余额兑换成功界面

@interface MKWithdrawSucessVC ()

@end

@implementation MKWithdrawSucessVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    
    self.gk_navTitle = @"提现详情";
    self.gk_navTitleFont = [UIFont systemFontOfSize:18];
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.gk_backImage = [UIImage imageNamed:@"white_return"];
    
    [self setSubview];
}

- (void)setSubview{
    SuccessBalanceModel *model =  [SuccessBalanceModel mj_objectWithKeyValues:self.requestParams];;
    MKWithdrawSucessView *view = [[MKWithdrawSucessView alloc]init];
    view.model = model;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view);
    }];
}

@end


