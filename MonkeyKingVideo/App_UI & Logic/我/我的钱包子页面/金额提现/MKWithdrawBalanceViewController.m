//
//  MKWithdrawBalanceViewController.m
//  MonkeyKingVideo
//
//  Created by blank blank on 2020/9/8.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKWithdrawBalanceViewController.h"
#import "ExchangeVipVC+VM.h"
#import "MKExchangeBalanceModel.h"
#import "MKWithdrawSucessVC.h"

@interface MKWithdrawBalanceViewController ()
@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UILabel *tiplab2;
@property (nonatomic, strong) NSMutableArray *botLabs;
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *topLabs;
@property (nonatomic, strong) MKExchangeBalanceModel *model;
@property (nonatomic, strong) SelectBalanceModelVo *selectBalanceModel;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) UIButton *convertBtn;

@end

@implementation MKWithdrawBalanceViewController

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MKWithdrawBalanceViewController *vc = MKWithdrawBalanceViewController.new;
    vc.successBlock = block;
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

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"余额提现";
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

#pragma mark -
- (void)loadData {
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_GET
                                                           path:[URL_Manager sharedInstance].MKgetWithdrawTypeGET
                                                     parameters:nil];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            NSLog(@"%@",response.reqResult);
            self.model = [MKExchangeBalanceModel mj_objectWithKeyValues:response.reqResult];
            [self selectButtons];
            self.selectBalanceModel = self.model.selectVo[0];
            if ([[NSString stringWithFormat:@"%@",self.model.balance] isEqualToString:@"0.00"]) {
                self.model.balance = @"0";
            }
            self.statusLab.text = self.model.balance;
            self.tiplab2.text = self.model.withDrawTips;
            if (self.model.lessCount > 0) {
                self.convertBtn.userInteractionEnabled = YES;
            } else {
                self.convertBtn.userInteractionEnabled = NO;
                self.convertBtn.alpha = 0.4f;
            }
        } else {
        }
    }];
}

- (void)convertClick {
    if([self.selectBalanceModel.value doubleValue] > [self.model.balance doubleValue]){
        [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:@"还没有那么多的余额，赶快去赚吧" dissmissAfterDeley:2.0f];
        return;
    }
    
    if([self.selectBalanceModel.needDays intValue]>0 || [self.selectBalanceModel.needFriends intValue]>0){
        [NSObject showSYSAlertViewTitle:@"兑换余额"
                                message:[NSString stringWithFormat:@"此金额的提现,你还需要连续签到 %@ 天,邀请 %@ 位好友后,即可进行提现。",self.selectBalanceModel.needDays,self.selectBalanceModel.needFriends]
                        isSeparateStyle:NO
                            btnTitleArr:@[@"我知道了"]
                         alertBtnAction:@[@""]
                               targetVC:self
                           alertVCBlock:^(id data) {
        }];
        return;
    }

//    [[MKTools shared] showLoadingView:self.view];

    NSDictionary *dic = @{@"drawType":self.selectBalanceModel.key};
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKWalletWithdrawBalancePOST
                                                     parameters:dic];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)

//        [[MKTools shared] dissmissLoadingInView:self.view animated:YES];
        if (response.code == 200) {
            [MKWithdrawSucessVC ComingFromVC:weak_self
                                 comingStyle:ComingStyle_PUSH
                           presentationStyle:UIModalPresentationAutomatic
                               requestParams:response.reqResult
                                     success:^(id data) {}
                                    animated:YES];
            [self loadData];

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
    
    self.selectBalanceModel = self.model.selectVo[sender.tag];
}

#pragma mark - subview
- (void) selectButtons{
    for (int i = 0;i < self.model.selectVo.count; i++) {
        if (!(self.btns.count == self.model.selectVo.count)){
            SelectBalanceModelVo *selectM = self.model.selectVo[i];
            
            CGFloat leftMargin = 26;
            CGFloat height = 37;
            CGFloat width = 99;
            CGFloat margin = (SCREEN_W - leftMargin * 2 - width * 3) / 2;
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(leftMargin + i % 3 * (width + margin), 187 + i/3 *(37+12), width, height)];
            [self.mScrollView addSubview:btn];
            [btn addTarget:self action:@selector(dayClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setBackgroundImage:KIMG(@"frame") forState:UIControlStateSelected];
            [btn setBackgroundImage:KIMG(@"unframe") forState:UIControlStateNormal];
            btn.selected = i == 0 ? YES : NO;
            btn.tag = i;
            [self.btns addObject:btn];
            
            UILabel *botLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
            [btn addSubview:botLab];
            botLab.text = [NSString stringWithFormat:@"￥ %@元",selectM.value];
            botLab.textAlignment = NSTextAlignmentCenter;
            botLab.textColor = i == 0 ? UIColor.whiteColor : COLOR_HEX(0xffffff, 0.4);
            botLab.font = [UIFont systemFontOfSize:12.8];
            [self.botLabs addObject:botLab];
        }
    }
}

#pragma mark -
- (UIScrollView *)mScrollView {
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.gk_navigationBar.height, SCREEN_W, 603)];
        _mScrollView.showsVerticalScrollIndicator = 0;
        _mScrollView.contentSize = CGSizeMake(SCREEN_W, 603);
        _mScrollView.backgroundColor = HEXCOLOR(0x242a37);
        
        // 背景
        UIView *igv = [[UIView alloc]init];
//        igv.backgroundColor = kRedColor;
        igv.frame = CGRectMake(15, 12, SCREEN_W-30, 94);
        igv.backgroundColor = HEXCOLOR(0x242a37);
        igv.layer.cornerRadius = 12;
        igv.layer.shadowColor = [UIColor blackColor].CGColor;
        igv.layer.shadowOffset = CGSizeMake(0,0);
        igv.layer.shadowOpacity = 0.5;
        igv.layer.shadowRadius = 20;
        [_mScrollView addSubview:igv];

        igv.contentMode = UIViewContentModeScaleToFill;
        
        // icon
        UIImageView *imgeV = [[UIImageView alloc]init];
        imgeV.frame = CGRectMake(58, 34, 60, 60);
        imgeV.image = KIMG(@"icon_balance_money");
        [_mScrollView addSubview:imgeV];
        
        // 余额
        self.statusLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2, 26, SCREEN_W/4, 20)];
        [igv addSubview:self.statusLab];
        self.statusLab.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(100), 30)]];
        self.statusLab.font = [UIFont systemFontOfSize:20];
        self.statusLab.textAlignment = NSTextAlignmentCenter;
                   
        // 提示
        UILabel *tiplab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2+15, 73, SCREEN_W/4, 20)];
        [_mScrollView addSubview:tiplab];
        tiplab.textColor = UIColor.whiteColor;
        tiplab.textAlignment = NSTextAlignmentCenter;
        tiplab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        tiplab.text = @"可提现金额(元)";
        
        UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(16, 12+117+20, 90, 18)];
        [_mScrollView addSubview:lab1];
        lab1.textColor = UIColor.whiteColor;
        lab1.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12.8];
        lab1.text = @"选择提现金额";
        
        _convertBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 173) / 2, 348, 173, 32)];
        [_mScrollView addSubview:_convertBtn];
        _convertBtn.layer.cornerRadius = 16;
        _convertBtn.layer.masksToBounds = 1;
        [_convertBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_convertBtn setTitle:@"立即提现" forState:UIControlStateNormal];
        [_convertBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _convertBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_convertBtn addTarget:self action:@selector(convertClick) forControlEvents:UIControlEventTouchUpInside];
    
        _tiplab2 = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth - 150) / 2, 400, 150, 28)];
        [_mScrollView addSubview:_tiplab2];
        _tiplab2.textColor = UIColor.whiteColor;
        _tiplab2.alpha = .6f;
        _tiplab2.textAlignment = NSTextAlignmentCenter;
        _tiplab2.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        _tiplab2.text = @"今日已提现1次，剩余0次";

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
