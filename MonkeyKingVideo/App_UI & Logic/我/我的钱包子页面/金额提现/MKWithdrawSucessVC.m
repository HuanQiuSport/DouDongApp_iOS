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
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation MKWithdrawSucessVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MKWithdrawSucessVC *vc = MKWithdrawSucessVC.new;
    vc.requestParams = requestParams;
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MKBakcColor;
    
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


