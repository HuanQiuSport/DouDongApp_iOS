//
//  MKWithdrawInfoVC.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/29.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKWithdrawInfoVC.h"

@interface MKWithdrawInfoVC ()
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@end

@implementation MKWithdrawInfoVC
- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MKWithdrawInfoVC *vc = MKWithdrawInfoVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    if ([requestParams isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)requestParams;
        NSLog(@"%@ | %@",dic,dic[@"balance"]);
        vc.balance = dic[@"balance"];
        vc.time = dic[@"time"];
    }
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
    // Do any additional setup after loading the view.
    self.gk_navTitle = @"提现详情";
    self.gk_navTitleFont = [UIFont systemFontOfSize:18];
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.view.backgroundColor = HEXCOLOR(0x242a37);
    self.gk_backImage = [UIImage imageNamed:@"white_return"];
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    
    UILabel *titleLab = UILabel.new;
    [self.view addSubview: titleLab ];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(37);
        make.left.equalTo(self.view).offset(36);
        make.right.equalTo(self.view).offset(-36);
    }];
    titleLab.numberOfLines = 0;
    titleLab.textColor = kWhiteColor;
    titleLab.font = [UIFont systemFontOfSize:15];
    NSString *text = @"请下载环球体育APP，并用抖动的账号进行登录，通过游戏进行提现\n请加客服QQ号：254526327\n请联系客服进行充值\n于6小时内到账，请在环球体育app中查收";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(100), 30)]] range:NSMakeRange(40, 9)];
    titleLab.attributedText = attributedString;
    
    UILabel *contextLab = UILabel.new;
    [self.view addSubview: contextLab];
    [contextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(21);
        make.left.equalTo(self.view).offset(36);
        make.right.equalTo(self.view).offset(-36);
    }];
    contextLab.numberOfLines = 0;
    contextLab.textColor = kWhiteColor;
    contextLab.font = [UIFont boldSystemFontOfSize:16];
    self.balance = @"9999.99";
    text = [NSString stringWithFormat:@"提现金额：\n￥%@",self.balance];
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(6, self.balance.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(100), 30)]] range:NSMakeRange(6, self.balance.length+1)];
    contextLab.attributedText = attributedString;
    
    UILabel *contextLab2 = UILabel.new;
    [self.view addSubview: contextLab2];
    [contextLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contextLab.mas_bottom).offset(18);
        make.left.equalTo(self.view).offset(36);
        make.right.equalTo(self.view).offset(-36);
    }];
    contextLab2.numberOfLines = 0;
    contextLab2.textColor = kWhiteColor;
    contextLab2.font = [UIFont boldSystemFontOfSize:16];
    self.time = @"2020-10-28 17:00:30";
    text = [NSString stringWithFormat:@"提现日期：\n%@",self.time];
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(6, self.time.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(100), 30)]] range:NSMakeRange(6, self.time.length)];
    contextLab2.attributedText = attributedString;
    
}


@end
