//
//  MyCoinVC.m
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/4.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "MyCoinVC.h"
#import "DouCoinDetailVC.h"
#import "DouCoinDetailVC.h"
#import "MyWalletDetailVC+VM.h"
#import "MyCoinVC+VM.h"
@interface MyCoinVC ()
<
JXCategoryTitleViewDataSource,
JXCategoryListContainerViewDelegate,
JXCategoryViewDelegate,
TXScrollLabelViewDelegate
>

@property(nonatomic,strong)JXCategoryTitleView *categoryView;
@property(nonatomic,strong)JXCategoryIndicatorLineView *lineView;
@property(nonatomic,strong)JXCategoryListContainerView *listContainerView;
@property(nonatomic,strong)NSMutableArray *childVCMutArr;

@property(nonatomic,strong)FSCustomButton *coinBtn;

@property(nonatomic,strong)UIButton *btn_left;
@property(nonatomic,strong)UIButton *btn_right;
@property(nonatomic,strong)TXScrollLabelView *scrollLabelView;//tips
@property(nonatomic,strong)NSString *Str_1;//当前金币（个）、当前零钱（元）
@property(nonatomic,strong)NSString *Str_2;//兑换会员
@property(nonatomic,strong)NSString *Str_3;//兑换余额、立即提现


@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,assign)MyWalletStyle myWalletStyle;
@property(nonatomic,strong)NSString *balanceStr;
@property(nonatomic,strong)NSString *goldNumberStr;

@property (nonatomic, strong)UILabel *currentMoneyLab;
@property (nonatomic, strong)UILabel *currentMoneyContentLab;
@property (nonatomic, strong)UIView *tipsView;
@property (nonatomic, strong)UIImageView *tipsIcon;
@property (nonatomic, strong)UILabel *tipsContentLab;
@property (nonatomic, strong)UIButton *convertMemberBtn;

@property (nonatomic, strong)UIImageView *headbgV;

@property (nonatomic, strong) UIView *botView;

@property (nonatomic, strong) DouCoinDetailVC *douCoinDetailVC;
@end

@implementation MyCoinVC


- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MyCoinVC *vc = MyCoinVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    if ([requestParams isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)requestParams;
        NSLog(@"%@ | %@",dic,dic[@"balance"]);
        vc.myWalletStyle = [dic[@"MyWalletStyle"] intValue];
        vc.balanceStr = [NSString stringWithFormat:@"%@",dic[@"balance"]];//[dic[@"balance"] stringValue];
        vc.goldNumberStr = [NSString stringWithFormat:@"%@",dic[@"goldNumber"]];//[dic[@"goldNumber"] stringValue];
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
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.TipsStr = @"温馨提示: 若连续30天未登录，未提现收益将清空";
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.douCoinDetailVC = [[DouCoinDetailVC alloc] init];
    [self initUI];
    
    self.Str_1 = @"当前金币（个）";
    self.Str_3 = @"兑换余额";
    self.coinBtn.alpha = 1;
    self.btn_right.alpha = 1;
    self.btn_left.alpha = 0;
    self.scrollLabelView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
//    self.categoryView.alpha = 1;
    self.navigationController.navigationBar.hidden = NO;
    WeakSelf
    if ([MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:NO]) {
        [self getData];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}


#pragma mark —— 点击事件

-(void)abandon{
    WeakSelf
    // 调用扣除金币接口
    [self netWorking_MKWalletChargeGoldPOSTBlock:^(id data) {
        if ((Boolean)data) {
            [self getData];
            [self.douCoinDetailVC pullToRefresh];
             [[MKTools shared] showMBProgressViewOnlyTextInView:weakSelf.view text:@"兑换成功" dissmissAfterDeley:2.0f];
        }
    }];
}

- (void)loginSuccess {
    [self getData];
}

- (void)getData{
    [self netWorking_MKWalletMyWalletPOST];
    
}
#pragma mark JXCategoryTitleViewDataSource
//// 如果将JXCategoryTitleView嵌套进UITableView的cell，每次重用的时候，JXCategoryTitleView进行reloadData时，会重新计算所有的title宽度。所以该应用场景，需要UITableView的cellModel缓存titles的文字宽度，再通过该代理方法返回给JXCategoryTitleView。
//// 如果实现了该方法就以该方法返回的宽度为准，不触发内部默认的文字宽度计算。
//- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView
//               widthForTitle:(NSString *)title{
//
//    return 10;
//}

#pragma mark JXCategoryListContainerViewDelegate
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView{
    return 1;
}

/**
 根据index初始化一个对应列表实例，需要是遵从`JXCategoryListContentViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView
                                          initListForIndex:(NSInteger)index{
    return self.childVCMutArr[index];
}

#pragma mark JXCategoryViewDelegate
//传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

//传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView
scrollingFromLeftIndex:(NSInteger)leftIndex
        toRightIndex:(NSInteger)rightIndex
               ratio:(CGFloat)ratio {
//    [self.listContainerView scrollingFromLeftIndex:leftIndex
//                                      toRightIndex:rightIndex
//                                             ratio:ratio
//                                     selectedIndex:categoryView.selectedIndex];
}

#pragma mark —— TXScrollLabelViewDelegate
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView
       didClickWithText:(NSString *)text
                atIndex:(NSInteger)index{
}


#pragma mark --initUI
- (void)initUI {
    self.gk_navTitle = @"我的抖币";
    self.gk_navTitleFont = [UIFont systemFontOfSize:18];
    self.gk_navTitleColor = UIColor.blackColor;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.view.backgroundColor = HEXCOLOR(0xF7F7F7);
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
//    self.gk_backImage = [UIImage imageNamed:@"white_return"];
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    [self.view addSubview:self.headbgV];
    [self.headbgV addSubview:self.showNumLab];
    [self.view addSubview:self.botView];
    [self.view addSubview:self.currentMoneyLab];
    [self.view addSubview:self.currentMoneyContentLab];
    [self.view addSubview:self.convertMemberBtn];
    [self.view addSubview:self.tipsView];
    [self.headbgV addSubview:self.tipsIcon];
    [self.tipsView addSubview:self.tipsContentLab];
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    
    [self addMasonry];
}
#pragma mark —— lazyLoad
- (UILabel *)showNumLab
{
    if (!_showNumLab) {
        _showNumLab = UILabel.new;
        _showNumLab.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(20, 3)]];
        _showNumLab.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
        _showNumLab.textAlignment = NSTextAlignmentRight;
        _showNumLab.text = self.goldNumberStr;
    }return _showNumLab;
}
- (UIImageView *)headbgV
{
    if (!_headbgV) {
        _headbgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, kTabBarHeight + 22, SCREEN_W - 20, SCREEN_H * 0.175 - 20)];
        _headbgV.image = KIMG(@"wallet_info_bg");
    }return _headbgV;
}

-(NSMutableArray *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
        [self.childVCMutArr addObject:self.douCoinDetailVC];
    }return _childVCMutArr;
}

-(JXCategoryListContainerView *)listContainerView{
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView
                                                                      delegate:self];
        _listContainerView.defaultSelectedIndex = 0;
        _listContainerView.backgroundColor = kClearColor;//RGBCOLOR(36, 42, 55);
//        [_listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(self.view);
//            make.top.equalTo(self.tipsView.mas_bottom).offset(SCALING_RATIO(50));
//        }];
    }return _listContainerView;
}

-(JXCategoryIndicatorLineView *)lineView{
    if (!_lineView) {
        _lineView = JXCategoryIndicatorLineView.new;
        _lineView.indicatorWidth = 20;
        _lineView.indicatorHeight = 3;
        _lineView.indicatorColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(20, 3)]];
    }return _lineView;
}

-(JXCategoryTitleView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectZero];
        _categoryView.backgroundColor = kClearColor;//RGBCOLOR(36, 42, 55);
        _categoryView.titleSelectedColor = kWhiteColor;//[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(56, 20)]];
        _categoryView.titleColor = UIColor.clearColor;
        _categoryView.titleFont = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _categoryView.delegate = self;
        _categoryView.titleColorGradientEnabled = YES;
//        _categoryView.indicators = @[self.lineView];
        _categoryView.defaultSelectedIndex = 0;
        //关联cotentScrollView，关联之后才可以互相联动！！！
        _categoryView.contentScrollView = self.listContainerView.scrollView;
       
    }return _categoryView;
}


- (UILabel *)currentMoneyLab {
    if (!_currentMoneyLab) {
        _currentMoneyLab = UILabel.new;
        _currentMoneyLab.text = @"当前抖币(个)";
        _currentMoneyLab.textColor = UIColor.whiteColor;
        _currentMoneyLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    }
    return _currentMoneyLab;
}
- (UILabel *)currentMoneyContentLab {
    if (!_currentMoneyContentLab) {
        _currentMoneyContentLab = UILabel.new;
        _currentMoneyContentLab.textColor = UIColor.whiteColor;
        _currentMoneyContentLab.font = [UIFont systemFontOfSize:34];
    }
    return _currentMoneyContentLab;
}

- (UIButton *)convertMemberBtn {
    if (!_convertMemberBtn) {
        _convertMemberBtn = UIButton.new;
        [_convertMemberBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_convertMemberBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _convertMemberBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_convertMemberBtn setTitle:@"兑换余额" forState:UIControlStateNormal];
        _convertMemberBtn.layer.cornerRadius = 11;
        _convertMemberBtn.layer.masksToBounds = 1;
        @weakify(self)
        [[_convertMemberBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [NSObject checkAuthorityWithType:MKLoginAuthorityType_Money:^(id data) {
                if ([data isKindOfClass:NSNumber.class]) {
                    NSNumber *f = (NSNumber *)data;
                    if (f.boolValue) {
                    }else{
                        [NSObject showSYSAlertViewTitle:@"暂时没法使用此功能"
                                                message:@"请联系管理员开启此权限"
                                        isSeparateStyle:NO
                                            btnTitleArr:@[@"我知道了"]
                                         alertBtnAction:@[@""]
                                               targetVC:[SceneDelegate sharedInstance].customSYSUITabBarController
                                           alertVCBlock:^(id data) {
                            
                        }];
                        return;
                    }
                }
            }];
            
            if ([self.showNumLab.text floatValue] >= 100) {
                [self netWorking_ChargeBalanceTipsGET:^(id data) {
                    if ([data isKindOfClass:NSNumber.class]) {
                        NSNumber *f = (NSNumber *)data;
                        if (f.boolValue) {
                            [NSObject showSYSAlertViewTitle:@"兑换余额"
                                                    message:self.TipsStr
                                            isSeparateStyle:NO
                                                btnTitleArr:@[@"取消",@"确定"]
                                             alertBtnAction:@[@"",@"abandon"]
                                                   targetVC:self
                                               alertVCBlock:^(id data) {
                                //DIY
                            }];
                        }
                        else
                        {
                            [[MKTools shared] showMBProgressViewOnlyTextInView:self.view
                                                                          text:self.TipsStr
                            dissmissAfterDeley:1.0f];
                        }
                    }
                    
                    
                    
                }];

            } else {
                [[MKTools shared] showMBProgressViewOnlyTextInView:self.view
                                                              text:@"还没有那么多的抖币，赶快去赚吧"
                                                dissmissAfterDeley:1.5f];
            }
        }];
    }
    return _convertMemberBtn;
}
- (UIView *)tipsView {
    if (!_tipsView) {
        _tipsView = UIView.new;
    }
    return _tipsView;
}
- (UIImageView *)tipsIcon {
    if (!_tipsIcon) {
        _tipsIcon = UIImageView.new;
        _tipsIcon.image = KIMG(@"white_doucoin");
    }
    return _tipsIcon;
}
- (UILabel *)tipsContentLab {
    if (!_tipsContentLab) {
        _tipsContentLab = UILabel.new;
        _tipsContentLab.textColor = UIColor.whiteColor;
        _tipsContentLab.font = [UIFont systemFontOfSize:9];
//        _tipsContentLab.alpha = 1.0f;
        _tipsContentLab.text = @"温馨提示: 若连续30天未登录,未提现收益将清空";
    }
    return _tipsContentLab;
}
- (UIView *)botView {
    if (!_botView) {
        _botView = UIView.new;
        _botView.backgroundColor = HEXCOLOR(0xFFFFFF);
        _botView.layer.cornerRadius = 12;
//        _botView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _botView.layer.shadowOffset = CGSizeMake(0,0);
//        _botView.layer.shadowOpacity = 0.5;
//        _botView.layer.shadowRadius = 20;
        
        UIImageView *iconImageView = UIImageView.new;
        iconImageView.image = KIMG(@"wallet_title_bar");
        [_botView addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(16);
            make.centerX.offset(0);
        }];
        
        UILabel *lab = UILabel.new;
        [_botView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(13);
            make.centerX.offset(0);
            make.height.offset(22);
            make.width.mas_lessThanOrEqualTo(70);
        }];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        lab.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(60), 30)]];
        lab.text = @"抖币流水";
        UIView *leftLine = UIView.new;
        [_botView addSubview:leftLine];
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(lab.mas_left).offset(-18);
            make.height.offset(1);
            make.width.offset(40);
            make.centerY.mas_equalTo(lab.mas_centerY).offset(0);
        }];
        leftLine.backgroundColor = UIColor.whiteColor;
        
        UIView *rightLine = UIView.new;
        [_botView addSubview:rightLine];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lab.mas_right).offset(18);
            make.height.offset(1);
            make.width.offset(40);
            make.centerY.mas_equalTo(lab.mas_centerY).offset(0);
        }];
        rightLine.backgroundColor = UIColor.whiteColor;
        UILabel *botLab = UILabel.new;
        [_botView addSubview:botLab];
        [botLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-10);
            make.height.offset(12);
        }];
        botLab.textColor = COLOR_HEX(0x999999, 1);
        botLab.font = [UIFont systemFontOfSize:12];
        botLab.text = @"仅显示当天的抖币流水";
        
//        [_botView addSubview:self.mTab];
//        [self.mTab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.offset(49);
//            make.left.right.offset(0);
//            make.bottom.offset(-22);
//        }];
    }
    return _botView;
}

#pragma mark --addMasonry
- (void)addMasonry {
    [self.currentMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipsIcon.mas_right).offset(32);
        make.height.offset(20);
        make.width.mas_lessThanOrEqualTo(100);
        make.top.mas_equalTo(self.headbgV.mas_top).offset(30);
    }];
    [self.currentMoneyContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(114);
        make.height.offset(34);
        make.top.mas_equalTo(self.currentMoneyLab.mas_bottom).offset(14);
        make.width.mas_lessThanOrEqualTo(150);
    }];
    [self.convertMemberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentMoneyLab.mas_left).offset(0);
        make.height.offset(22);
        make.width.offset(141);
        make.centerY.mas_equalTo(self.currentMoneyContentLab.mas_centerY).offset(0);
    }];
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(self.convertMemberBtn.mas_bottom).offset(17);
        make.height.offset(39);
    }];
    [self.tipsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(42);
        make.centerY.equalTo(self.headbgV);
        make.height.offset(56);
        make.width.offset(56);
    }];
    [self.tipsContentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.currentMoneyLab.mas_left).offset(0);
        make.right.mas_equalTo(self.headbgV).offset(0);
        make.height.offset(18);
        make.top.equalTo(self.convertMemberBtn.mas_bottom).offset(12);
    }];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.tipsView.mas_bottom).offset(3);
        make.height.offset(54);
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.right.offset(-14);
        make.bottom.offset(-45);
        make.top.mas_equalTo(self.categoryView.mas_bottom).offset(0);
    }];
    [self.showNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentMoneyLab.mas_right).offset(8);
        make.right.offset(-39);
        make.centerY.equalTo(self.currentMoneyLab);
        make.height.offset(20);
    }];
    [self.botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(-15);
        make.top.mas_equalTo(self.headbgV.mas_bottom).offset(15);
    }];
}
@end
