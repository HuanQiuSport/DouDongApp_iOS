//
//  ExchangeVipVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ExchangeVipVC.h"
#import "ExchangeVipVC+VM.h"
#import "MKExchangeVipModel.h"
@interface ExchangeVipVC ()

@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) NSMutableArray *botLabs;
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *topLabs;
@property (nonatomic, strong) MKExchangeVipModel *model;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *money;

@property (nonatomic, strong) NSString *myBalance;
@end

@implementation ExchangeVipVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)loadData {
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKGetToMemTypeGET
                                                     parameters:nil];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            self.model = [MKExchangeVipModel mj_objectWithKeyValues:response.reqResult];
            CGFloat leftMargin = 26;
            CGFloat height = 63;
            CGFloat width = 95;
            CGFloat margin = (MAINSCREEN_WIDTH - leftMargin * 2 - width * 3) / 2;
            for (int i = 0;i < self.model.selectVo.count; i++) {
                SelectVo *selectM = self.model.selectVo[i];
                UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(leftMargin + i % 3 * (width + margin), 187 + i/3 *(63+12), width, height)];
                [self.mScrollView addSubview:btn];
                [btn addTarget:self action:@selector(dayClick:) forControlEvents:UIControlEventTouchUpInside];
                [btn setBackgroundImage:KIMG(@"frame") forState:UIControlStateSelected];
                [btn setBackgroundImage:KIMG(@"unframe") forState:UIControlStateNormal];
                btn.selected = i == 0 ? YES : NO;
                btn.tag = i;
                [self.btns addObject:btn];
                UILabel *topLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, 75, 18)];
                [btn addSubview:topLab];
                topLab.text = [NSString stringWithFormat:@"%@天",selectM.key];
                topLab.textColor = UIColor.whiteColor;
                topLab.font = [UIFont systemFontOfSize:12.8];
                topLab.textAlignment = NSTextAlignmentCenter;
                [self.topLabs addObject:topLab];
                
                UILabel *botLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 31, 75, 18)];
                [btn addSubview:botLab];
                botLab.text = [NSString stringWithFormat:@"%@元",selectM.value];
                botLab.textAlignment = NSTextAlignmentCenter;
                botLab.textColor = i == 0 ? UIColor.whiteColor : COLOR_HEX(0xffffff, 0.4);
                botLab.font = [UIFont systemFontOfSize:12.8];
                [self.botLabs addObject:botLab];
                if (i == 0) {
                    self.money = botLab.text; // 初始化self.money
                    self.key = topLab.text;
                }
            }
            self.statusLab.text = self.model.isVip ? [NSString stringWithFormat:@"%@ 到期",self.model.validDate] : @"未开通";

        } else {

        }
    }];
}
#pragma mark - Lifecycle

-(void)loadView{
    [super loadView];
    if ([self.requestParams isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)self.requestParams;
        NSLog(@"%@ | %@",dic,dic[@"balanceStr"]);
        self.myBalance = [NSString stringWithFormat:@"%@",dic[@"balanceStr"]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"兑换会员";
    self.gk_navTitleFont = [UIFont systemFontOfSize:18];
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.view.backgroundColor = HEXCOLOR(0x242a37);
    self.gk_backImage = [UIImage imageNamed:@"white_return"];
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    [self.view addSubview:self.mScrollView];
    [self loadData];
}
- (void)convertClick {

    if ([self.myBalance floatValue] < [self.money floatValue]) {

        [WHToast showMessage:@"还没有那么多的余额，赶快去赚吧"
                    duration:1
               finishHandler:nil];
        
        return;
    }
    [NSObject showSYSAlertViewTitle:@"兑换会员"
                            message:[NSString stringWithFormat:@"您确定要用%@,兑换%@会员吗？",self.money,self.key]
                    isSeparateStyle:NO
                        btnTitleArr:@[@"取消",@"确定"]
                     alertBtnAction:@[@"",@"chargeVIP"]
                           targetVC:self
                       alertVCBlock:^(id data) {
        //DIY
    }];

}
- (void)chargeVIP
{
    
    NSString *newStr = [self.key substringToIndex:[ self.key length] - 1];
    NSDictionary *dic = @{@"vipDay":newStr};
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                              path:[URL_Manager sharedInstance].MKWalletChargeVIPPOST
                                                        parameters:dic];
       self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
       @weakify(self)
       [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
           @strongify(self)
           if (response.isSuccess) {
               /*
                {
                  "code": 200,
                  "msg": "",
                  "data": {
                    "validDate": "0.01",  —会员到期时间
                    "balance": "100", —余额
                  }
                }
                */
               if ([response.reqResult isKindOfClass:NSDictionary.class]) {
                   WeakSelf
                   dispatch_async(dispatch_get_main_queue() , ^{
                       weakSelf.statusLab.text = [NSString stringWithFormat:@"%@ 到期",response.reqResult[@"validDate"]];
                   });
                   
                   [WHToast showMessage:@"兑换成功"
                               duration:1
                          finishHandler:nil];
               }
               else
               {
                   [WHToast showMessage:response.reqResult
                               duration:1
                          finishHandler:nil];
               }
               
               
           } else {

           }
       }];
}
- (void)dayClick:(UIButton *)sender {
    for (UIButton *btn in self.btns) {
        btn.selected = 0;
    }
    for (UILabel *lab in self.botLabs) {
        lab.textColor = COLOR_HEX(0xffffff, 0.4);
    }
    UIButton *btn = self.btns[sender.tag];
    UILabel *lab = self.botLabs[sender.tag];
    btn.selected = 1;
    lab.textColor = UIColor.whiteColor;
    UILabel *topLab = self.topLabs[sender.tag];
    self.key = topLab.text;
    
    UILabel *botLab = self.botLabs[sender.tag];
    NSLog(@"%@",botLab.text);
    self.money = botLab.text;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

- (UIScrollView *)mScrollView {
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.gk_navigationBar.height, MAINSCREEN_WIDTH, 603)];
        _mScrollView.showsVerticalScrollIndicator = 0;
        _mScrollView.contentSize = CGSizeMake(MAINSCREEN_WIDTH, 603);
        _mScrollView.backgroundColor = HEXCOLOR(0x242a37);
        
        UIImageView *igv = [[UIImageView alloc]init];
       
        igv.frame = CGRectMake(0, 12, MAINSCREEN_WIDTH, 135);
        [_mScrollView addSubview:igv];

        igv.contentMode = UIViewContentModeScaleToFill;
        igv.image = KIMG(@"VIP");
        self.statusLab = [[UILabel alloc]initWithFrame:CGRectMake(22, 91, 150, 15.6)];
        [igv addSubview:self.statusLab];
        self.statusLab.textColor = COLOR_HEX(0xffffff, 0.9);
        self.statusLab.font = [UIFont systemFontOfSize:12.8];
        self.statusLab.text = @"";
        self.statusLab.layer.cornerRadius = 2;
        self.statusLab.layer.masksToBounds = 1;
        self.statusLab.backgroundColor = COLOR_HEX(0x000000, 0.7);
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 12+117+20, 90, 18)];
        [_mScrollView addSubview:lab1];
        lab1.textColor = UIColor.whiteColor;
        lab1.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12.8];
        lab1.text = @"选择会员天数";

        UIButton *convertBtn = [[UIButton alloc]initWithFrame:CGRectMake((MAINSCREEN_WIDTH - 150) / 2, 348, 150, 28)];
        [_mScrollView addSubview:convertBtn];
        convertBtn.layer.cornerRadius = 14;
        convertBtn.layer.masksToBounds = 1;
        [convertBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [convertBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        [convertBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        convertBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [convertBtn addTarget:self action:@selector(convertClick) forControlEvents:UIControlEventTouchUpInside];
        UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(26, 484, 60, 18)];
        [_mScrollView addSubview:lab2];
        lab2.textColor = UIColor.whiteColor;
        lab2.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12.8];
        lab2.text = @"会员权益";
        
        NSArray *labTitles = @[@"1.成为会员后观看视频时,可极速减少广告时间.",@"2.会员用户可以对视频进行无限制评论.",@"3.更多会员特权尽情期待."];
        for (int i = 0;i < labTitles.count; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(26, 514+i*18, MAINSCREEN_WIDTH - 40, 14)];
            [_mScrollView addSubview:label];
            label.textColor = COLOR_HEX(0xffffff, 0.4);
            label.font = [UIFont systemFontOfSize:10];
            label.text = labTitles[i];
        }
    }
    return _mScrollView;
}
- (NSMutableArray *)btns {
    if (!_btns) {
        _btns = [NSMutableArray new];
    }
    return _btns;
}
- (NSMutableArray *)botLabs {
    if (!_botLabs) {
        _botLabs = [NSMutableArray new];
    }
    return _botLabs;
}
- (NSMutableArray *)topLabs {
    if (!_topLabs) {
        _topLabs = [NSMutableArray new];
    }
    return _topLabs;
}
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];

    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (NSString *)key{
    
    if (!_key) {
        
        _key = [[NSString alloc]init];
    }
    return _key;
}
@end
