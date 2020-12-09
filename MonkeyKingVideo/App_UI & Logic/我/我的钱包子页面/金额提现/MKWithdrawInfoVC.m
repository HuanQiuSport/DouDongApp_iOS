//
//  MKWithdrawInfoVC.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/29.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKWithdrawInfoVC.h"

@interface MKWithdrawInfoVC ()

@end

@implementation MKWithdrawInfoVC
- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(void)loadView{
    [super loadView];
    if ([self.requestParams isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)self.requestParams;
        NSLog(@"%@ | %@",dic,dic[@"balance"]);
        self.balance = dic[@"balance"];
        self.time = dic[@"time"];
        self.qq = dic[@"qq"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.gk_navTitle = @"提现详情";
    self.gk_navTitleFont = [UIFont systemFontOfSize:18];
    self.gk_navTitleColor = UIColor.blackColor;
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.view.backgroundColor = HEXCOLOR(0xF7F7F7);
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    
    UILabel *titleLab = UILabel.new;
    [self.view addSubview: titleLab ];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(37);
        make.left.equalTo(self.view).offset(36);
        make.right.equalTo(self.view).offset(-36);
    }];
    titleLab.numberOfLines = 0;
    titleLab.textColor = UIColor.blackColor;
    titleLab.font = [UIFont systemFontOfSize:15];
    NSString *text = @"请下载环球体育APP，并用抖动的账号进行登录，通过游戏进行提现\n请加客服QQ号：";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSAttributedString *qqAttr = [[NSAttributedString alloc] initWithString:self.qq attributes:@{
        NSForegroundColorAttributeName: [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(100, 30)]]
    }];
    [attributedString appendAttributedString:qqAttr];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(100, 30)]] range:NSMakeRange(40, 9)];
    
    NSString *endText = @"\n请联系客服进行充值\n于6小时内到账，请在环球体育app中查收";
    NSAttributedString *endTextAttr = [[NSAttributedString alloc] initWithString:endText attributes:@{
        NSForegroundColorAttributeName: [UIColor blackColor]
    }];
    [attributedString appendAttributedString:endTextAttr];
    titleLab.attributedText = attributedString;
    
    
    UILabel *contextLab = UILabel.new;
    [self.view addSubview: contextLab];
    [contextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset(21);
        make.left.equalTo(self.view).offset(36);
        make.right.equalTo(self.view).offset(-36);
    }];
    contextLab.numberOfLines = 0;
    contextLab.textColor = UIColor.blackColor;
    contextLab.font = [UIFont boldSystemFontOfSize:16];
    self.balance = [self.balance stringByReplacingOccurrencesOfString:@"-" withString:@""];
    text = [NSString stringWithFormat:@"提现金额：\n￥%@",self.balance];
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(6, self.balance.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(100, 30)]] range:NSMakeRange(6, self.balance.length+1)];
    contextLab.attributedText = attributedString;
    
    UILabel *contextLab2 = UILabel.new;
    [self.view addSubview: contextLab2];
    [contextLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contextLab.mas_bottom).offset(18);
        make.left.equalTo(self.view).offset(36);
        make.right.equalTo(self.view).offset(-36);
    }];
    contextLab2.numberOfLines = 0;
    contextLab2.textColor = UIColor.blackColor;
    contextLab2.font = [UIFont boldSystemFontOfSize:16];
    self.time = self.time;
    text = [NSString stringWithFormat:@"提现日期：\n%@",self.time];
    attributedString = [[NSMutableAttributedString alloc] initWithString:text];

    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(6, self.time.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(100, 30)]] range:NSMakeRange(6, self.time.length)];
    contextLab2.attributedText = attributedString;
    
}


@end
