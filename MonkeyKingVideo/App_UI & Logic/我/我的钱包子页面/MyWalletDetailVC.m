//
//  MyWalletVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BalanceDetailVC.h"
#import "CoinDetailVC.h"
#import "ExchangeVipVC.h"
#import "MyWalletDetailVC.h"
#import "MyWalletDetailVC+VM.h"
#import "MKBanlanceCell.h"
#import "MKWalletMyFlowsModel.h"
#import "MKWithdrawBalanceViewController.h"

#import "MKWithdrawInfoVC.h"
@interface MyWalletDetailVC ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>


@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
@property(nonatomic,assign)MyWalletStyle myWalletStyle;

@property(nonatomic,strong)NSString *goldNumberStr;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *botView;
@property (nonatomic, strong) UIView *tipView;

@property (nonatomic, strong) UITableView *mTab;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UILabel *noDataLab;
@property (nonatomic, assign) BOOL showEmpty;

@property (nonatomic, strong) UILabel *topRightLab;
@property (nonatomic, strong) UILabel *topRightLab2;
@property (nonatomic, strong) UILabel *topRightLab3;
@property (nonatomic, strong) UILabel *canWithdrawLab;
@property (nonatomic, strong) UIButton *withdrawBtn;


@end

@implementation MyWalletDetailVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MyWalletDetailVC *vc = MyWalletDetailVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    if ([requestParams isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)requestParams;
        NSLog(@"%@ | %@",dic,dic[@"balance"]);
        vc.myWalletStyle = [dic[@"MyWalletStyle"] intValue];
//        vc.balanceStr = [NSString stringWithFormat:@"%@",dic[@"balance"]];//[dic[@"balance"] stringValue];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navTitle = @"我的余额";
    self.gk_navTitleFont = [UIFont systemFontOfSize:18];
    self.gk_navTitleColor = UIColor.whiteColor;
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.view.backgroundColor = HEXCOLOR(0x242a37);
    self.gk_backImage = [UIImage imageNamed:@"white_return"];
}

- (void)initUI {
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.botView];
    [self.view addSubview:self.tipView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.right.offset(-14);
        make.height.offset(147);
        make.top.mas_equalTo(self.gk_navigationBar.mas_bottom).offset(12);
    }];
    [self.botView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.right.offset(-14);
        make.bottom.offset(-15);
        make.top.mas_equalTo(self.tipView.mas_bottom).offset(20);
    }];
//    self.page = 1;
//    [self loadData];
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(14);
        make.right.offset(-14);
        make.height.offset(39);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(16);
    }];
}
- (void)updateData:(WalletInfoModel *)info {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"本月剩余可提现 "];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.0f",info.drawBalance] attributes:@{NSForegroundColorAttributeName : kRedColor}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" 元" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor}]];
    [attributedString appendString:@" 元"];
    self.canWithdrawLab.attributedText = attributedString;
    
    
    attributedString = [[NSMutableAttributedString alloc] initWithString:@"已连续签到 "];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",info.signCount] attributes:@{NSForegroundColorAttributeName : KYellowColor}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" 天" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor}]];
    self.topRightLab.attributedText = attributedString;
    
    attributedString = [[NSMutableAttributedString alloc] initWithString:@"已邀请 "];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",info.friendCount] attributes:@{NSForegroundColorAttributeName : KYellowColor}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" 位好友 " attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor}]];
    self.topRightLab2.attributedText = attributedString;
    
    attributedString = [[NSMutableAttributedString alloc] initWithString:@"可提现次数 "];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d",info.drawCount] attributes:@{NSForegroundColorAttributeName : KYellowColor}]];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@" 次" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor}]];
    
    self.topRightLab3.attributedText = attributedString;
    if(info.balance == 0) {
        self.balanceCount.text = @"0";
    } else {
        [NSString stringWithFormat:@"%.0f",info.balance];
    }
    
   
    if (info.drawBalance != 0) {
        self.withdrawBtn.userInteractionEnabled = YES;
    } else {
        self.withdrawBtn.userInteractionEnabled = NO;
        self.withdrawBtn.alpha = 0.4f;
    }
    
}
- (void)setWalletModel:(WalletInfoModel *)walletModel {
    _walletModel = walletModel;
    [self updateData:walletModel];
}


- (void)withdrawClick {
//    [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:@"正在开发中的功能" dissmissAfterDeley:2.5];
    
//    WeakSelf
//    [MKWithdrawBalanceViewController ComingFromVC:weakSelf
//                    comingStyle:ComingStyle_PUSH
//              presentationStyle:UIModalPresentationAutomatic
//                  requestParams:nil
//                        success:^(id data) {}
//                       animated:YES];

    if(self.walletModel == nil) {
        return;
    }
    NSString *tip;
    if (self.walletModel.balance < 1) {
        tip = [NSString stringWithFormat:@"最低可提现金额为1元"];
        [NSObject showSYSAlertViewTitle:@"提示"
                        message:tip
                isSeparateStyle:NO
                    btnTitleArr:@[@"我知道了"]
                 alertBtnAction:@[@""]
                       targetVC:self
                   alertVCBlock:^(id data) {
        }];
    } else if(self.walletModel.drawBalance == 0) {
        [NSObject showSYSAlertViewTitle:@"提示"
                       message:@"您本月已提现100元，剩余可提现金额为0.00元，请下个月再进行提现"
               isSeparateStyle:NO
                   btnTitleArr:@[@"我知道了"]
                alertBtnAction:@[@""]
                      targetVC:self
                  alertVCBlock:^(id data) {
               }];
    } else if(self.walletModel.drawCount > 0 && self.walletModel.balance >= 1 && self.walletModel.drawBalance >= 1) {
        tip = [NSString stringWithFormat:@"本次提现金额为%.0f元，确认进行提现吗？", MIN(self.walletModel.balance, self.walletModel.drawBalance)];
        [NSObject showSYSAlertViewTitle:@"提示"
                        message:tip
                isSeparateStyle:NO
                    btnTitleArr:@[@"取消",@"确认"]
                 alertBtnAction:@[@"",@"goWithdraw"]
                       targetVC:self
                   alertVCBlock:^(id data) {
            
        }];
    }
//    else {
//        if ([self.balanceCount.text intValue] > 0 && [self.balanceCount.text intValue] <= 100) {
//
//        }
//        else if ([self.balanceCount.text intValue] > 100)
//        {
//            tip = @"本月最多提现金额为100元，确认进行提现吗？";
//            [NSObject showSYSAlertViewTitle:@"提示"
//                            message:tip
//                    isSeparateStyle:NO
//                        btnTitleArr:@[@"取消",@"确认"]
//                     alertBtnAction:@[@"",@"goWithdraw"]
//                           targetVC:self
//                       alertVCBlock:^(id data) {
//            }];
//        }
//        else {
//             [NSObject showSYSAlertViewTitle:@"提示"
//                    message:@"您本月已提现100元，剩余可提现金额为0.00元，请下个月再进行提现"
//            isSeparateStyle:NO
//                btnTitleArr:@[@"我知道了"]
//             alertBtnAction:@[@""]
//                   targetVC:self
//               alertVCBlock:^(id data) {
//            }];
//        }
//
//    }

}
- (void)goWithdraw {
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKWalletWithdrawBalancePOST
                                                     parameters:@{}];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)

//        [[MKTools shared] dissmissLoadingInView:self.view animated:YES];
        if (response.code == 200) {
            NSString *createTime = response.reqResult[@"createTime"];
            NSString *money = response.reqResult[@"money"];
            @weakify(self)
            [MKWithdrawInfoVC ComingFromVC:weak_self
                                 comingStyle:ComingStyle_PUSH
                           presentationStyle:UIModalPresentationAutomatic
                             requestParams:@{@"balance":money,@"time":createTime}
                                     success:^(id data) {}
                                    animated:YES];
            [self loadData];

        }
    }];

}
- (void)pullToRefresh {
    self.page = 1;
    [self loadData];
    [self.mTab.mj_header endRefreshing];
}
- (void)loadMoreRefresh {
    DLog(@"上拉加载更多");
    self.page ++;
    [self loadData];
    [self.mTab.mj_footer endRefreshing];
}
-(void)loadData{
    NSDictionary *easyDict = @{
        @"type":@(1),
        @"beginDate":[NSObject getToday],
        @"pageSize":@(10),
        @"pageNum":@(self.page)
    };
    FMHttpRequest *req = [FMHttpRequest urlParametersWithMethod:HTTTP_METHOD_POST
                                                           path:[URL_Manager sharedInstance].MKWalletMyFlowsPOST
                                                     parameters:easyDict];
    self.reqSignal = [[FMARCNetwork sharedInstance] requestNetworkData:req];
    @weakify(self)
    [self.reqSignal subscribeNext:^(FMHttpResonse *response) {
        @strongify(self)
        if (response.isSuccess) {
            MKWalletMyFlowsModel *model = [MKWalletMyFlowsModel mj_objectWithKeyValues:response.reqResult];
            NSArray *array = [MKWalletMyFlowsListModel mj_objectArrayWithKeyValuesArray:response.reqResult[@"list"]];
            if (self.page == 1) {
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:array];
            } else {
                [self.dataArray addObjectsFromArray:array];
            }
            if (model.pages.integerValue == 0) {
                self.page --;
                [self.mTab.mj_footer endRefreshingWithNoMoreData];
            }
//            if (array.count < 10 || self.page == model.pages.integerValue) {
//                [self.mTab.mj_footer endRefreshingWithNoMoreData];
//            } else {
////                [self.mTab.mj_footer endRefreshing];
//            }
            [self.mTab.mj_header endRefreshing];
            self.showEmpty = YES;
            [self.mTab reloadData];

        } else {
//            [self.mTab.mj_footer endRefreshing];
//            [self.mTab.mj_header endRefreshing];
            if (self.page > 1) {
                self.page -- ;
            }
        }
    }];
}
- (void)loadMore {
    self.page ++;
    [self loadData];
    [self.mTab.mj_footer endRefreshing];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.page = 1;
    [self netWorking_MKWalletMyWalletPOST];
    [self loadData];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

#pragma mark - tab delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 18+10+12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKBanlanceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(MKBanlanceCell.class)];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
//    NSString *title = @"快来将我填满吧";
//    NSDictionary *attributes = @{
//        NSFontAttributeName:[UIFont systemFontOfSize:16],
//        NSForegroundColorAttributeName:RGBCOLOR(131, 145, 175)
//    };
//    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
//}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.showEmpty;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
#pragma mark - getter
- (UIView *)topView {
    if (!_topView) {
        _topView = UIView.new;
        _topView.backgroundColor = HEXCOLOR(0x242a37);
        _topView.layer.cornerRadius = 12;
        _topView.layer.shadowColor = [UIColor blackColor].CGColor;
        _topView.layer.shadowOffset = CGSizeMake(0,0);
        _topView.layer.shadowOpacity = 0.5;
        _topView.layer.shadowRadius = 20;

        UIImageView *igv = UIImageView.new;
        [_topView addSubview:igv];
        [igv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(SCALING_RATIO(26));
            make.top.offset(SCALING_RATIO(7));
            make.width.height.offset(SCALING_RATIO(35));
        }];
        igv.image = KIMG(@"balance");
        igv.contentMode = UIViewContentModeScaleAspectFit;
        UILabel *lab = UILabel.new;
        [_topView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView).offset(SCALING_RATIO(17));
            make.left.equalTo(igv.mas_right).offset(SCALING_RATIO(8));
            make.height.offset(22);
        }];
        lab.text = @"当前余额(元)";
        lab.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        lab.textColor = UIColor.whiteColor;
       
        [_topView addSubview:self.withdrawBtn];
        [self.withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView).offset(67);
            make.right.equalTo(self.topView).offset(-67);
            make.bottom.equalTo(self.topView.mas_bottom).offset(-10);
            make.height.offset(28);
        }];
        self.withdrawBtn.layer.cornerRadius =SCALING_RATIO(11);
        self.withdrawBtn.layer.masksToBounds = 1;
        [self.withdrawBtn setBackgroundImage:KIMG(@"gradualColor") forState:UIControlStateNormal];
        [self.withdrawBtn setTitle:@"余额提现" forState:UIControlStateNormal];
        [self.withdrawBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.withdrawBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.withdrawBtn addTarget:self action:@selector(withdrawClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_topView addSubview:self.balanceCount];
        [self.balanceCount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(igv.mas_left).offset(0);
            make.right.equalTo(lab.mas_right).offset(0);
            make.top.mas_equalTo(lab.mas_bottom).offset(0);
//            make.width.mas_lessThanOrEqualTo(SCALING_RATIO(200));
        }];
        
        [_topView addSubview:self.canWithdrawLab];
        [self.canWithdrawLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.balanceCount.mas_bottom).offset(0);
            make.left.equalTo(igv.mas_left).offset(0);
            make.right.equalTo(lab.mas_right).offset(0);
        }];
        self.canWithdrawLab.textAlignment = NSTextAlignmentCenter;
        self.canWithdrawLab.textColor = kWhiteColor;
        self.canWithdrawLab.font = [UIFont systemFontOfSize:11];

        [_topView addSubview:self.topRightLab];
        [self.topRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topView).offset(22);
            make.left.equalTo(lab.mas_right).offset(70);
            make.right.equalTo(self.topView.mas_right).offset(25);
        }];
        self.topRightLab.textAlignment = NSTextAlignmentCenter;
        self.topRightLab.textColor = kWhiteColor;
        self.topRightLab.font = [UIFont systemFontOfSize:11];

        [_topView addSubview:self.topRightLab2];
        [self.topRightLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topRightLab.mas_bottom).offset(4);
            make.left.equalTo(self.topRightLab.mas_left).offset(0);
            make.right.equalTo(self.topRightLab.mas_right).offset(0);
        }];
        self.topRightLab2.textAlignment = NSTextAlignmentCenter;
        self.topRightLab2.textColor = kWhiteColor;
        self.topRightLab2.font = [UIFont systemFontOfSize:11];

        
        [_topView addSubview:self.topRightLab3];
        [self.topRightLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topRightLab2.mas_bottom).offset(4);
            make.left.equalTo(self.topRightLab.mas_left).offset(0);
            make.right.equalTo(self.topRightLab.mas_right).offset(0);
        }];
        self.topRightLab3.textAlignment = NSTextAlignmentCenter;
        self.topRightLab3.textColor = kWhiteColor;
        self.topRightLab3.font = [UIFont systemFontOfSize:11];
    }
    return _topView;
}

- (UILabel *)topRightLab {
    if(!_topRightLab) {
       _topRightLab = UILabel.new;
    }
    return _topRightLab;
}
- (UILabel *)topRightLab2 {
    if(!_topRightLab2) {
       _topRightLab2 = UILabel.new;
    }
    return _topRightLab2;
}
- (UILabel *)topRightLab3 {
    if(!_topRightLab3) {
       _topRightLab3 = UILabel.new;
    }
    return _topRightLab3;
}

- (UILabel *)canWithdrawLab {
    if(!_canWithdrawLab) {
        _canWithdrawLab = UILabel.new;
    }
    return _canWithdrawLab;
}

- (UIButton *)withdrawBtn {
    if(!_withdrawBtn) {
        _withdrawBtn = UIButton.new;
    }
    return _withdrawBtn;
}

- (UIView *)botView {
    if (!_botView) {
        _botView = UIView.new;
        _botView.backgroundColor = HEXCOLOR(0x242a37);
        _botView.layer.cornerRadius = 12;
        _botView.layer.shadowColor = [UIColor blackColor].CGColor;
        _botView.layer.shadowOffset = CGSizeMake(0,0);
        _botView.layer.shadowOpacity = 0.5;
        _botView.layer.shadowRadius = 20;
  
        
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
        lab.textColor = UIColor.whiteColor;
        lab.text = @"余额流水";
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
        botLab.hidden = YES;
        [_botView addSubview:botLab];
        [botLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-10);
            make.height.offset(12);
        }];
        botLab.textColor = COLOR_HEX(0xffffff, 0.4);
        botLab.font = [UIFont systemFontOfSize:12];
        botLab.text = @"仅显示当天的抖币流水";
        
        [_botView addSubview:self.mTab];
        [self.mTab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(49);
            make.left.right.offset(0);
            make.bottom.offset(-22);
        }];
    }
    return _botView;
}
- (UIView *)tipView
{
    if (!_tipView) {
        _tipView  = UIView.new;
        _tipView.backgroundColor = HEXCOLOR(0x242a37);
        _tipView.layer.cornerRadius = 12;
        _tipView.layer.shadowColor = [UIColor blackColor].CGColor;
        _tipView.layer.shadowOffset = CGSizeMake(0,0);
        _tipView.layer.shadowOpacity = 0.5;
        _tipView.layer.shadowRadius = 20;
        
        
        UILabel *lab = UILabel.new;
        [_tipView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.centerY.offset(0);
        }];
        lab.text = @"若连续30天未登录，未提现的收益将清空";
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = kWhiteColor;
        lab.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tipView;
}
- (UILabel *)balanceCount {
    if (!_balanceCount) {
        _balanceCount = UILabel.new;
        _balanceCount.textColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(200), 20)]];
        _balanceCount.textAlignment = NSTextAlignmentCenter;
        _balanceCount.font = [UIFont fontWithName:@"PingFangSC-Medium" size:30];
    }
    return _balanceCount;
}
- (UITableView *)mTab {
    if (!_mTab) {
        _mTab = UITableView.new;
        _mTab.delegate = self;
        _mTab.dataSource = self;
        [_mTab registerClass:MKBanlanceCell.class forCellReuseIdentifier:NSStringFromClass(MKBanlanceCell.class)];
        _mTab.showsVerticalScrollIndicator = 0;
        _mTab.separatorStyle = 0;
        _mTab.backgroundColor = HEXCOLOR(0x242a37);
        _mTab.mj_header = self.tableViewHeader;
        _mTab.mj_footer = self.tableViewFooter;
        _mTab.emptyDataSetSource = self;
        _mTab.emptyDataSetDelegate = self;
        _mTab.mj_footer.hidden = NO;
//        @weakify(self)
//        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            @strongify(self)
//            [self loadMore];
//        }];
//        [footer setTitle:@"没有更多流水" forState:MJRefreshStateNoMoreData];
    }
    return _mTab;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = NSMutableArray.new;
    }
    return _dataArray;
}
@end
