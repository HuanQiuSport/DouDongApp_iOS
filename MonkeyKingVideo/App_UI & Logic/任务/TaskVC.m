//
//  TaskVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "TaskVC.h"
#import "TaskVC+VM.h"
#import "MyWalletDetailVC.h"
#import "MyCoinVC.h"
#import "MKPaoMaView.h" // 跑马灯
#import "MKPMView.h" // 跑马灯
#import "MKNoticeView.h"

@interface TaskVC ()<UIScrollViewDelegate>

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;


@property (nonatomic, strong) UIView *walletView;   // 余额视图
@property (nonatomic, strong) UIButton *walletBtn;
@property (nonatomic, strong) UIView *coinView;     // 金币视图
@property (nonatomic, strong) UIButton *coinBtn;
@property (nonatomic, strong) UIView *signView;     // 签到视图
@property (nonatomic, strong) UIView *friendView;   // 好友视图
@property (nonatomic, strong) UIView *withdrawView; // 银行卡视图
@property (nonatomic, strong) UIView *rewardView; // 奖励视图

@property (nonatomic,strong) UILabel *walletTitleLab;
@property (nonatomic,strong) UILabel *coinTitleLab;

@property (nonatomic,strong) UILabel *invitetitleLab;
@property (nonatomic,strong) UILabel  *invitelineView;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *bgview;

@property (strong,nonatomic) UIImageView *topBgView;
@end

@implementation TaskVC

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    TaskVC *vc = TaskVC.new;
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
//            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

#pragma mark - Lifecycle
-(instancetype)init{
    
    if (self = [super init]) {
        
    }return self;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KLoginSuccessNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KRegisSuccessNotifaction object:nil];
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    #warning UserDefault存页面暂时解决上传页面返回问题
    SetUserDefaultKeyWithValue(@"selectedIndex", @"3");
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    
    _friendLab.textColor = RGBCOLOR(131,145,175);
    WeakSelf
    [self getData]; // 是否登录都可以获得签到信息以及通知数据
    if ([MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:NO]) {
//        NSLog(@"登录了");
        [self getDataUserData]; // 用户余额与金币
//        [self MKUserFriendFourList_GET]; // 好友
//        [self MKUserInfoSelectIdCard_GET]; // 绑卡信息
        [self friendAndCard];
        _withdrawView.hidden = YES;

    }
    else
    {
//        NSLog(@"未登录");
        // 未登录
        _withdrawView.hidden = YES;
        _walletLab.text = @"0";
//        _walletLab.textAlignment = NSTextAlignmentCenter;
        _coinLab.text = @"0";
//        _coinLab.textAlignment = NSTextAlignmentCenter;
        [_friendBtn setTitle:@"立即登录" forState:UIControlStateNormal];

        _friendLab.text = @"点击登录邀请好友帮你赚币哦～";
        _friendListView.hidden = YES;
        _friendBtn.hidden = !_friendListView.hidden;
        UIView *line = (UIView *)[self.view viewWithTag:999];
        line.hidden = !_friendListView.hidden;
        _friendListBtn.hidden = _friendListView.hidden;
        [_friendBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [_friendBtn addAction:^(UIButton *btn) {
//            NSLog(@"viewWillAppear _friendBtn 未登录");
            if ([MKTools mkLoginIsYESWith:weakSelf]){return;}
        }];

        /*
         make.top.equalTo(self.friendView.mas_bottom).offset(20);
                    make.right.equalTo(self.bgview).offset(-13);
                    make.left.equalTo(self.bgview).offset(13);
                    make.height.offset(120);
         */

    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.gk_navBackgroundColor = UIColor.clearColor;
    self.view.backgroundColor = HEXCOLOR(0x242a37);
    [self addViews];
    [self addNotifaction];
    [self refreshSkin];
}

-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        self.gk_navBackgroundColor = UIColor.clearColor;
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
        self.walletView.backgroundColor = UIColor.whiteColor;
        self.coinView.backgroundColor =  UIColor.whiteColor;
        self.walletTitleLab.textColor = UIColor.blackColor;
        self.coinTitleLab.textColor = UIColor.blackColor;
        self.walletLab.textColor = UIColor.blackColor;
        self.coinLab.textColor = UIColor.blackColor;
        self.walletView.layer.shadowColor = [UIColor clearColor].CGColor;
        self.coinView.layer.shadowColor = [UIColor clearColor].CGColor;
        // ---------------
        self.signView.backgroundColor = UIColor.whiteColor;
        self.signView.layer.shadowColor = [UIColor clearColor].CGColor;
        self.signTitleLab.textColor = UIColor.blackColor;
        self.signLab.textColor = UIColor.blackColor;
        //-----
        self.friendView.backgroundColor = UIColor.whiteColor;
        self.friendView.layer.shadowColor = [UIColor clearColor].CGColor;
        self.invitetitleLab.textColor = UIColor.blackColor;
        self.friendLab.textColor = HEXCOLOR(0x8391AF);
        self.invitelineView.backgroundColor = COLOR_HEX(0x000000, 0.2);
        //----
        self.rewardView.backgroundColor = UIColor.whiteColor;
        self.rewardView.layer.shadowColor = [UIColor clearColor].CGColor;
    } else {
        // ---------------
        self.view.backgroundColor = HEXCOLOR(0x242a37);
        self.walletView.backgroundColor = HEXCOLOR(0x242a37);
        self.coinView.backgroundColor = HEXCOLOR(0x242a37);
        self.walletTitleLab.textColor = RGBCOLOR(131,145,175);
        self.coinTitleLab.textColor = RGBCOLOR(131,145,175);
        self.walletLab.textColor = kWhiteColor;
        self.coinLab.textColor = kWhiteColor;
        self.walletView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.coinView.layer.shadowColor = [UIColor blackColor].CGColor;
        // ---------------
        self.signView.backgroundColor = HEXCOLOR(0x242a37);
        self.signView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.signTitleLab.textColor = kWhiteColor;
        self.signLab.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(40), 30)]];
        //------
        self.friendView.backgroundColor = HEXCOLOR(0x242a37);
        self.friendView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.invitetitleLab.textColor = UIColor.whiteColor;
        self.friendLab.textColor = RGBCOLOR(131,145,175);
        self.invitelineView.backgroundColor = kBlackColor;
        //----
        self.rewardView.backgroundColor = HEXCOLOR(0x242a37);
        self.rewardView.layer.shadowColor = [UIColor blackColor].CGColor;
        
    }
    [self.noticeView refreshSkin];
    [self.paomav refreshSkin];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Method
- (void)addViews {
    
    [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview).offset(0);
        make.left.equalTo(self.bgview).offset(21);
        make.right.equalTo(self.bgview.mas_centerX).offset(-8);
        make.height.offset(83);
    }];

    [self.coinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgview).offset(0);
        make.right.equalTo(self.bgview).offset(-21);
        make.left.equalTo(self.bgview.mas_centerX).offset(8);
        make.height.offset(83);
    }];
    
    [self.signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.walletView.mas_bottom).offset(26);
        make.right.equalTo(self.bgview).offset(-12);
        make.left.equalTo(self.bgview).offset(12);
        make.height.offset(158);
    }];
    
    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.signView.mas_bottom).offset(26);
        make.right.equalTo(self.bgview).offset(-16);
        make.left.equalTo(self.bgview).offset(16);
        make.height.offset(39);
    }];
    
    [self.friendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noticeView.mas_bottom).offset(21);
        make.right.equalTo(self.bgview).offset(-13);
        make.left.equalTo(self.bgview).offset(13);
        make.height.offset(134);
    }];
    
    [self.withdrawView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rewardView.mas_bottom).offset(20);
        make.right.equalTo(self.bgview).offset(-13);
        make.left.equalTo(self.bgview).offset(13);
        make.height.offset(86);
    }];
    
    [self.rewardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.friendView.mas_bottom).offset(20);
        make.right.equalTo(self.bgview).offset(-8);
        make.left.equalTo(self.bgview).offset(8);
        make.height.offset(210);
    }];
    
    [self topBgView];
}
#pragma mark 成功登陆/注册通知
- (void)addNotifaction {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:KLoginSuccessNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regisSuccess) name:KLoginOutNotifaction object:nil];
}

- (void)loginSuccess {
//    NSLog(@"通知登录成功");
}
- (void)regisSuccess {
//    NSLog(@"通知注册成功");
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize = CGSizeMake(SCREEN_W, SCREEN_H+164);
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        _scrollView.bounces = false;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}
- (UIView *)bgview
{
    if (!_bgview) {
        _bgview = [[UIView alloc] initWithFrame:CGRectMake(0, self.gk_navigationBar.size.height, SCREEN_W, SCREEN_H)];
        [self.scrollView addSubview:_bgview];
    }
    return _bgview;
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat maxY = CGRectGetMaxY(self.rewardView.frame);
    CGFloat tabbarHeight = isiPhoneX_series() ? (50 + isiPhoneX_seriesBottom) : 49;
    self.bgview.mj_h = maxY + tabbarHeight + 5 + self.gk_navigationBar.size.height;
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.bgview.mj_h);
}

- (UIView *)walletView{
    if (!_walletView) {
        _walletView = UIView.new;
        [self.bgview addSubview:_walletView];
        _walletView.backgroundColor = HEXCOLOR(0x242a37);
        _walletView.layer.cornerRadius = 6;
        _walletView.layer.shadowColor = [UIColor blackColor].CGColor;
        _walletView.layer.shadowOffset = CGSizeMake(0,0);
        _walletView.layer.shadowOpacity = 0.5;
        _walletView.layer.shadowRadius = 20;
        
        UILabel *titleLab = UILabel.new;
        _walletTitleLab = titleLab;
        [_walletView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.walletView).offset(12);
            make.left.equalTo(self.walletView).offset(16);
        }];
        titleLab.text = @"当前余额";
        titleLab.textColor = RGBCOLOR(131,145,175);
        titleLab.font = [UIFont systemFontOfSize:14];
        
        // 余额
        _walletLab = UILabel.new;
        [_walletView addSubview:_walletLab];
        [_walletLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).offset(4);
            make.left.equalTo(self.walletView).offset(16);
            make.right.equalTo(titleLab.mas_right).offset(0);
        }];
        _walletLab.textAlignment = NSTextAlignmentCenter;
        _walletLab.textColor = kWhiteColor;
        _walletLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        
        // 提现
        _walletBtn = UIButton.new;
        [_walletView addSubview:_walletBtn];
        [_walletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.walletLab.mas_bottom).offset(5);
            make.left.equalTo(self.walletView).offset(15);
            make.bottom.equalTo(self.walletView.mas_bottom).offset(-6);
            make.width.offset(54);
            make.height.offset(20);
        }];
        [_walletBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_walletBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _walletBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_walletBtn setTitle:@"提现" forState:UIControlStateNormal];
        _walletBtn.layer.cornerRadius = 10;
        _walletBtn.layer.masksToBounds = 1;
        @weakify(self)
        [[_walletBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (![MKTools mkLoginIsYESWith:weak_self WithiSNeedLogin:NO]) {
                if ([MKTools mkLoginIsYESWith:weak_self]){return;}
            } else {
                [MyWalletDetailVC ComingFromVC:weak_self
                      comingStyle:ComingStyle_PUSH
                presentationStyle:UIModalPresentationAutomatic
                    requestParams:@{
                        @"MyWalletStyle":@(MyWalletStyle_CURRENTBALANCE),
                        @"balance":self.walletStr,
                        @"goldNumber":self.coinStr
                    }
                          success:^(id data) {}
                         animated:YES];
            }
            
            
        }];
        
        UIImageView *imgeV = UIImageView.new;
        [_walletView addSubview:imgeV];
        [imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(self.walletView).offset(-4);
            make.bottom.equalTo(self.walletView.mas_bottom).offset(0);
            make.width.offset(40);
            make.height.offset(27);
        }];
        imgeV.image = KIMG(@"icon_task_wallet");
    }
    return _walletView;
}
- (UIView *)coinView{
    if (!_coinView) {
        _coinView = UIView.new;
        [self.bgview addSubview:_coinView];
        _coinView.backgroundColor = HEXCOLOR(0x242a37);
        _coinView.layer.cornerRadius = 6;
        _coinView.layer.shadowColor = [UIColor blackColor].CGColor;
        _coinView.layer.shadowOffset = CGSizeMake(0,0);
        _coinView.layer.shadowOpacity = 0.5;
        _coinView.layer.shadowRadius = 20;
        
        UILabel *titleLab = UILabel.new;
        _coinTitleLab = titleLab;
        [_coinView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coinView).offset(12);
            make.left.equalTo(self.coinView).offset(16);
        }];
        titleLab.text = @"我的抖币";
        titleLab.textColor = RGBCOLOR(131,145,175);
        titleLab.font = [UIFont systemFontOfSize:14];
        
        // 抖币
        _coinLab = UILabel.new;
        [_coinView addSubview:_coinLab];
        [_coinLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).offset(4);
            make.left.equalTo(self.coinView).offset(16);
            make.right.equalTo(titleLab.mas_right).offset(0);
        }];
        _coinLab.textAlignment = NSTextAlignmentCenter;
        _coinLab.textColor = kWhiteColor;
        _coinLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        
        // 兑换
        _coinBtn = UIButton.new;
        [_coinView addSubview:_coinBtn];
        [_coinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coinLab.mas_bottom).offset(5);
            make.left.equalTo(self.coinView).offset(15);
            make.bottom.equalTo(self.coinView.mas_bottom).offset(-6);
            make.width.offset(54);
            make.height.offset(20);
        }];
        [_coinBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_coinBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _coinBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_coinBtn setTitle:@"兑换" forState:UIControlStateNormal];
        _coinBtn.layer.cornerRadius = 10;
        _coinBtn.layer.masksToBounds = 1;
        @weakify(self)
        [[_coinBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (![MKTools mkLoginIsYESWith:weak_self WithiSNeedLogin:NO]) {
                if ([MKTools mkLoginIsYESWith:weak_self]){return;}
            } else {
               [MyCoinVC ComingFromVC:weak_self
                      comingStyle:ComingStyle_PUSH
                presentationStyle:UIModalPresentationAutomatic
                    requestParams:@{
                        @"MyWalletStyle":@(MyWalletStyle_CURRENTCOIN),
                        @"balance":self.walletStr,
                        @"goldNumber":self.coinStr
                    }
                          success:^(id data) {}
                         animated:YES];
            }
            
        }];
        
        UIImageView *imgeV = UIImageView.new;
        [_coinView addSubview:imgeV];
        [imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(self.coinView).offset(-4);
            make.bottom.equalTo(self.coinView.mas_bottom).offset(0);
            make.width.offset(40);
            make.height.offset(25);
        }];
        imgeV.image = KIMG(@"icon_task_coin");
        
    }
    return _coinView;
}
- (UIView *)friendView{
    if (!_friendView) {
        _friendView = UIView.new;
        [self.bgview addSubview:_friendView];
        _friendView.backgroundColor = HEXCOLOR(0x242a37);
        _friendView.layer.cornerRadius = 6;
        _friendView.layer.shadowColor = [UIColor blackColor].CGColor;
        _friendView.layer.shadowOffset = CGSizeMake(0,0);
        _friendView.layer.shadowOpacity = 0.5;
        _friendView.layer.shadowRadius = 20;
        
        
        UILabel *titleLab = UILabel.new;
        _invitetitleLab = titleLab;
        [_friendView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.friendView).offset(12);
            make.left.equalTo(self.friendView).offset(16);
        }];
        titleLab.text = @"邀请好友 狂赚";
        titleLab.textColor = kWhiteColor;
        titleLab.font = [UIFont systemFontOfSize:20];
        
        UILabel *titleLab2 = UILabel.new;
        [_friendView addSubview:titleLab2];
        [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.friendView).offset(12);
            make.left.equalTo(titleLab.mas_right).offset(1);
        }];
        titleLab2.text = @"37.6W抖币";
        titleLab2.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(40), 30)]];
        titleLab2.font = [UIFont systemFontOfSize:20];
        
        _friendLab = UILabel.new;
        [_friendView addSubview:_friendLab];
        [_friendLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab2.mas_bottom).offset(3);
            make.left.equalTo(self.friendView).offset(16);
        }];
        _friendLab.text = @"点击登录邀请好友帮你赚币哦～";
        _friendLab.textColor = RGBCOLOR(131,145,175);
        _friendLab.font = [UIFont systemFontOfSize:13];
        
        UIView *line = UIView.new;
        line.tag = 999;
        [_friendView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.friendLab.mas_bottom).offset(10);
            make.left.equalTo(self.friendView).offset(0);
            make.right.equalTo(self.friendView).offset(0);
            make.height.offset(1);
        }];
        line.backgroundColor = kBlackColor;
        _invitelineView = line;
        
        _friendBtn = UIButton.new;
        [_friendView addSubview:_friendBtn];
        [_friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(10);
            make.left.equalTo(self.friendView).offset(18);
            make.right.equalTo(self.friendView).offset(-18);
            make.bottom.equalTo(self.friendView.mas_bottom).offset(-14);
            
        }];
        [_friendBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_friendBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _friendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_friendBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        _friendBtn.layer.cornerRadius = 22;
        _friendBtn.layer.masksToBounds = 1;
        @weakify(self)
        [_friendBtn addAction:^(UIButton *btn) {
            @strongify(self)
            if ([MKTools mkLoginIsYESWith:self]){return;}
        }];
        
        _friendListView = UIView.new;
        [_friendView addSubview:_friendListView];
        [_friendListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).offset(10);
            make.left.equalTo(self.friendView).offset(0);
            make.right.equalTo(self.friendView).offset(0);
            make.bottom.equalTo(self.friendView.mas_bottom).offset(0);
            
        }];
        _friendListView.hidden = YES;
        
        // 邀请更多
        _friendListBtn = UIButton.new;
        [_friendView addSubview:_friendListBtn];
        [self.friendListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.friendListView.mas_bottom).offset(-28);
            make.right.equalTo(self.friendView.mas_right).offset(-12);
            make.width.offset(73);
            make.height.offset(27);
        }];
        [_friendListBtn setTitle:@"邀请更多" forState:UIControlStateNormal];
        [_friendListBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_friendListBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _friendListBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _friendListBtn.layer.cornerRadius = 27/2;
        _friendListBtn.layer.masksToBounds = 1;
        _friendListBtn.hidden = YES;
        
    }
    return _friendView;
}
- (MKNoticeView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[MKNoticeView alloc] initWithFrame:CGRectZero];
        [self.bgview addSubview:_noticeView];
//        _noticeView.backgroundColor = HEXCOLOR(0x242a37);
//        _noticeView.layer.cornerRadius = 19.5;
//        _noticeView.layer.shadowColor = [UIColor blackColor].CGColor;
//        _noticeView.layer.shadowOffset = CGSizeMake(0,0);
//        _noticeView.layer.shadowOpacity = 0.5;
//        _noticeView.layer.shadowRadius = 20;
//
//
//        UIImageView *imgeV = UIImageView.new;
//        [_noticeView addSubview:imgeV];
//        [imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.noticeView.mas_centerY);
//            make.left.equalTo(self.noticeView).offset(48);
//            make.width.offset(16);
//            make.height.offset(16);
//        }];
//        imgeV.image = KIMG(@"icon_proclamation");
//
//        _paomaView = [[MKPaoMaView alloc] initWithFrame:CGRectMake(67,0,SCREEN_W - 32 - 66 - 67,40) font:[UIFont systemFontOfSize:17] textColor:[UIColor redColor]];
//        _paomaView.textColor = [UIColor whiteColor];
//        _paomaView.font = [UIFont systemFontOfSize:13];// 字体大小
//        _paomaView.backgroundColor = kClearColor;
//        [_noticeView addSubview:_paomaView];
    }
    return _noticeView;
}
- (UIView *)signView{
    if (!_signView) {
        _signView = UIView.new;
        [self.bgview addSubview:_signView];
        _signView.backgroundColor = HEXCOLOR(0x242a37);
        _signView.layer.cornerRadius = 6;
        _signView.layer.shadowColor = [UIColor blackColor].CGColor;
        _signView.layer.shadowOffset = CGSizeMake(0,0);
        _signView.layer.shadowOpacity = 0.5;
        _signView.layer.shadowRadius = 20;
        
        
        _signTitleLab = UILabel.new;
        [_signView addSubview:_signTitleLab];
        [_signTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signView).offset(12);
            make.left.equalTo(self.signView).offset(16);
        }];
        _signTitleLab.text = @"今日签到可获得";
        _signTitleLab.textColor = kWhiteColor;
        _signTitleLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        
        _signLab = UILabel.new;
        [_signView addSubview:_signLab];
        [_signLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signView).offset(12);
            make.left.equalTo(self.signTitleLab.mas_right).offset(1);
        }];
        _signLab.text = @"88抖币";
        _signLab.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(40), 30)]];
        _signLab.font = [UIFont systemFontOfSize:15];
        
        
        // 签到
        _signBtn = UIButton.new;
        [_signView addSubview:_signBtn];
        [self.signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.signView).offset(12);
            make.right.equalTo(self.signView).offset(-12);
            make.width.offset(102);
            make.height.offset(30);
        }];
        [_signBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_signBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _signBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_signBtn setTitle:@"立即签到" forState:UIControlStateNormal];
        _signBtn.layer.cornerRadius = 15;
        _signBtn.layer.masksToBounds = 1;        
        for (int i = 0 ; i<7; i++) {
            UIView * bgV = [[UIView alloc] initWithFrame:CGRectMake(i*(SCREEN_W-24-16)/7, 61, (SCREEN_W-24-16)/7, 120)];
            [_signView addSubview:bgV];
            
            // 签到
            UIImageView *signImgeV = UIImageView.new;
            signImgeV.tag = i+200;
            signImgeV.image = KIMG(@"icon_redpackage_nor");
            [bgV addSubview:signImgeV];
            [signImgeV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgV).offset(0);
                make.left.equalTo(bgV).offset(18);
                make.bottom.equalTo(self.signView.mas_bottom).offset(-53);
                make.right.equalTo(bgV).offset(0);
            }];


            UILabel *titleLab = UILabel.new;
            [signImgeV addSubview:titleLab];
            titleLab.text = @"+188";
            titleLab.tag = i+100;
            titleLab.textColor = kBlackColor;
            titleLab.font = [UIFont systemFontOfSize:10];
            titleLab.textAlignment = NSTextAlignmentCenter;
            [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(signImgeV).offset(0);
                make.right.equalTo(signImgeV).offset(0);
                make.left.equalTo(signImgeV).offset(0);
            }];
            
            UIColor *textColor = kWhiteColor;
            if([SkinManager manager].skin == MKSkinWhite) {
                textColor = UIColor.blackColor;
            }
            
            UILabel *titleLab2 = UILabel.new;
            [_signView addSubview:titleLab2];
            titleLab2.text = [NSString stringWithFormat:@"%d天",i+1];
            titleLab2.textColor = textColor;
            titleLab2.font = [UIFont systemFontOfSize:10];
            titleLab2.textAlignment = NSTextAlignmentCenter;
            [titleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(signImgeV.mas_bottom).offset(2);
                make.right.equalTo(signImgeV).offset(0);
                make.left.equalTo(signImgeV).offset(0);
                make.bottom.equalTo(self.signView.mas_bottom).offset(-37);
            }];
            
            
            UILabel *titleLab3 = UILabel.new;
            [_signView addSubview:titleLab3];
            titleLab3.text = @"连续签到7天并且邀请1位好友可以获得一次提现资格";
            titleLab3.textColor = textColor;
            titleLab3.font = [UIFont systemFontOfSize:12];
            titleLab3.textAlignment = NSTextAlignmentCenter;
            [titleLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.signView).offset(0);
                make.left.equalTo(self.signView).offset(0);
                make.bottom.equalTo(self.signView.mas_bottom).offset(-12);
            }];
        }
    }
    return _signView;
}
- (UIView *)withdrawView{
    if (!_withdrawView) {
        _withdrawView = UIView.new;
        [self.bgview addSubview:_withdrawView];
        _withdrawView.backgroundColor = HEXCOLOR(0x242a37);
        _withdrawView.layer.cornerRadius = 6;
        _withdrawView.layer.shadowColor = [UIColor blackColor].CGColor;
        _withdrawView.layer.shadowOffset = CGSizeMake(0,0);
        _withdrawView.layer.shadowOpacity = 0.5;
        _withdrawView.layer.shadowRadius = 20;
        
        
        UIImageView *imgeV = UIImageView.new;
        [_withdrawView addSubview:imgeV];
        [imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.withdrawView).offset(20);
            make.left.equalTo(self.withdrawView).offset(12);
            make.bottom.equalTo(self.withdrawView).offset(-20);
            make.width.equalTo(imgeV.mas_height).multipliedBy(1);
        }];
        imgeV.image = KIMG(@"icon_withdraw");
        
        UILabel *titleLab = UILabel.new;
        [_withdrawView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.withdrawView).offset(25);
            make.left.equalTo(imgeV.mas_right).offset(8);
        }];
        titleLab.text = @"绑定提现账号";
        titleLab.textColor = kWhiteColor;
        titleLab.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        
        UILabel *subtitleLab = UILabel.new;
        [_withdrawView addSubview:subtitleLab];
        [subtitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.withdrawView).offset(-23);
            make.left.equalTo(imgeV.mas_right).offset(8);
        }];
        subtitleLab.text = @"提现快捷，秒到账";
        subtitleLab.textColor = RGBCOLOR(131,145,175);
        subtitleLab.font = [UIFont systemFontOfSize:12];
        
        UILabel *subtitleLab2 = UILabel.new;
        [_withdrawView addSubview:subtitleLab2];
        [subtitleLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.withdrawView).offset(-23);
            make.left.equalTo(titleLab.mas_right).offset(1);
        }];
        subtitleLab2.text = @"（+100抖币）";
        subtitleLab2.textColor = RGBCOLOR(255,202,0);
        subtitleLab2.font = [UIFont systemFontOfSize:12];
        
        
        // 绑卡
        _withdrawBtn = UIButton.new;
        [_withdrawView addSubview:_withdrawBtn];
        [self.withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(subtitleLab2.mas_centerY);
            make.right.equalTo(self.withdrawView.mas_right).offset(-12);
            make.width.offset(73);
            make.height.offset(27);
        }];
        [_withdrawBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _withdrawBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _withdrawBtn.layer.cornerRadius = 27/2;
        _withdrawBtn.layer.masksToBounds = 1;

    }
    return _withdrawView;
}
- (UIView *)rewardView
{
    if (!_rewardView) {
        _rewardView = UIView.new;
        [self.bgview addSubview:_rewardView];
        _rewardView.backgroundColor = HEXCOLOR(0x242a37);
        _rewardView.layer.cornerRadius = 6;
        _rewardView.layer.shadowColor = [UIColor blackColor].CGColor;
        _rewardView.layer.shadowOffset = CGSizeMake(0,0);
        _rewardView.layer.shadowOpacity = 0.5;
        _rewardView.layer.shadowRadius = 20;
    }
    return _rewardView;
}
- (MKPMView *)paomav
{
    if (!_paomav) {
        _paomav = MKPMView.new;
        [_rewardView addSubview:_paomav];
        [self.paomav mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rewardView).offset(8);
            make.left.equalTo(self.rewardView).offset(8);
            make.right.equalTo(self.rewardView).offset(-8);
            make.bottom.equalTo(self.rewardView).offset(0);
        }];
    }
    return _paomav;
}
-(UIImageView *)topBgView {
    if(_topBgView == nil) {
        _topBgView = [[UIImageView alloc]init];
        _topBgView.image = KIMG(@"task_top_bg");
        _topBgView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view insertSubview:_topBgView atIndex:0];
        [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(0);
        }];
    }
    return _topBgView;
}

- (NSMutableArray *)m_Signs
{
    if (!_m_Signs) {
        _m_Signs = NSMutableArray.new;
    }
    return _m_Signs;
}
- (NSMutableArray *)m_notices
{
    if (!_m_notices) {
        _m_notices = NSMutableArray.new;
    }
    return _m_notices;
}
- (NSMutableArray *)m_friends
{
    if (!_m_friends) {
        _m_friends = NSMutableArray.new;
    }
    return _m_friends;
}
- (NSString *)signDay
{
    if (!_signDay) {
        _signDay = NSString.new;
    }
    return _signDay;
}
- (NSMutableArray *)m_rewards
{
    if (!_m_rewards) {
        _m_rewards = NSMutableArray.new;
    }
    return _m_rewards;
}

@end
