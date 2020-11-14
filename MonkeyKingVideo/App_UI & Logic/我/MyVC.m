//
//  MyVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/24.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyVC.h"
#import "MyVC+VM.h"
//#import "DIYScanVC.h"
#import "MKSettingVC.h"
#import "MyVideoVC.h"
#import "EditUserInfoVC.h"
#import "MKSystemInfoVC.h"
#import "MyWalletDetailVC.h"
#import "MKAttentionVC.h"
#import "MyFansVC.h"

#import "UserInfoTBVCell.h"
#import "MyWalletTBVCell.h"
#import "MyVedioTBVCell.h"
#import "AnotherTBVCell.h"

//#import <FBMemoryProfiler/FBMemoryProfiler.h>
#import "MKWebViewVC.h"
#import "UIBarButtonItem+Badge.h"
#import "LikeDidBackDelegate.h"
#import "RecommendVC.h"

@interface MyVC ()
<
UITableViewDelegate
,UITableViewDataSource
,LikeDidBackDelegate
,UIViewControllerInteractivePushGestureDelegate
>

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)UIBarButtonItem *scanBtnItem;
@property(nonatomic,strong)UIBarButtonItem *msgBtnItem;
@property(nonatomic,strong)UIBarButtonItem *settingBtnItem;
@property(nonatomic,strong)MKWebViewVC *webViewVC;

@end

@implementation MyVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MKRecordStartNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KLoginSuccessNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KRegisSuccessNotifaction object:nil];
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    MyVC *vc = MyVC.new;
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

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0x242A37);
    self.gk_navLeftBarButtonItem = self.scanBtnItem;
    self.gk_navRightBarButtonItems = @[self.msgBtnItem,self.settingBtnItem];
    self.gk_navTitle = @"";
    self.gk_statusBarHidden = NO;
    self.navigationController.navigationBar.hidden = YES;
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    self.tableView.alpha = 1;
    [self addNotification];
    self.settingBtnItem.badge.text = self.myVCModel.msgNum.stringValue;
    self.settingBtnItem.badgeBGColor = [UIColor redColor];
    self.interactivePushGestureEnabled = NO; // 设置成YES会导致整个app变卡，估计是手势冲突
    self.interactivePushGestureDelegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    //data
    if (![NSString isNullString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token]) {
        [self netWorking_MKWalletMyWalletPOST];
    }else{
        //跳回首页
        [SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex = 0;
    }
    [self.tableView reloadData];
    [self.tableView reloadRow:2 inSection:0 withRowAnimation:UITableViewRowAnimationFade];
    MyVedioTBVCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
//
//    [cell.release_LikeVC.mkLiked requestData:^(id data) {
//        [cell.release_LikeVC.mkLiked.collectionView reloadData];
//    }];
//
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}

//- (UIViewController *)destinationViewControllerFromViewController:(UIViewController *)fromViewController {
//    return MKSystemInfoVC.new;
//}
#pragma mark ——  下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    if (![NSString isNullString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token]) {
        [self netWorking_MKWalletMyWalletPOST];
        
        MyVedioTBVCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        
        [cell.release_LikeVC.mkLiked requestData:^(id data) {
            
        }];
        
    }
}
#pragma mark —— 上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
}
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handerNotification:) name:MKRecordStartNotification  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Login) name:KLoginSuccessNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:KLoginOutNotifaction object:nil];
}
/// 发布视频 入口
- (void)handerNotification:(NSNotification *)notifi{
    if([notifi.name isEqualToString:MKRecordStartNotification]){
        NSLog(@"发布你的第一个视频");
        [[MKTools shared] showMBProgressViewOnlyTextInView:self.view text:@"正在开发中的功能" dissmissAfterDeley:2.5];
//          MKRecordVideoVC *vc = MKRecordVideoVC.new;
//          [self.navigationController pushViewController:vc animated:YES];
    }
//    if([notifi.name isEqualToString:KLoginSuccessNotifaction]){
//         [self.tableView reloadData];
//    }
//
//    if([notifi.name isEqualToString:KLoginOutNotifaction]){
//        [self.tableView reloadData];
//    }
}
- (void)Login{
    [self.tableView reloadData];
}
- (void)logout{
    [self.tableView reloadData];
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return [UserInfoTBVCell cellHeightWithModel:NULL];
            break;
        case 1:
            return [MyWalletTBVCell cellHeightWithModel:NULL];
            break;
        case 2:
            return [MyVedioTBVCell cellHeightWithModel:NULL];
            break;
        case 3:
            return [AnotherTBVCell cellHeightWithModel:NULL];
            break;
        default:
            return 0;
            break;
    }
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            @weakify(self)
            [EditUserInfoVC ComingFromVC:weak_self
                             comingStyle:ComingStyle_PUSH
                       presentationStyle:UIModalPresentationAutomatic
                           requestParams:nil
                                 success:^(id data) {}
                                animated:YES];
        }break;
        case 1:{
            
        }break;
        case 2:{
            
        }break;
        case 3:{
            
        }break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            UserInfoTBVCell *cell = [UserInfoTBVCell cellWith:tableView];
            @weakify(self)
            [cell action:^(id data) {
                if ([data isKindOfClass:UIButton.class]) {
#pragma mark - 关注
                    FSCustomButton *btn = (FSCustomButton *)data;
                    if ([btn.titleLabel.text containsString:@"关注"]) {
                        [MKAttentionVC ComingFromVC:weak_self
                                        comingStyle:ComingStyle_PUSH
                                  presentationStyle:UIModalPresentationAutomatic
                                      requestParams:@{
                                          @"mkType":@(0)
                                      }
                                            success:^(id data) {}
                                           animated:YES];
                        
#pragma mark - 粉丝
                    }else if ([btn.titleLabel.text containsString:@"粉丝"]){
                        [MKAttentionVC ComingFromVC:weak_self
                                        comingStyle:ComingStyle_PUSH
                                  presentationStyle:UIModalPresentationAutomatic
                                      requestParams:@{
                                          @"mkType":@(1)
                                      }
                                            success:^(id data) {}
                                           animated:YES];
                        
                    }else{}
                }
            }];
            [cell richElementsInCellWithModel:self.myVCModel];
            return cell;
        }break;
        case 1:{
            MyWalletTBVCell *cell = [MyWalletTBVCell cellWith:tableView];
            [cell richElementsInCellWithModel:@{
                @"balance":[NSString stringWithFormat:@"%.2f",self.myVCModel.balance.floatValue],
                @"goldNumber":[NSString stringWithFormat:@"%.2f",self.myVCModel.goldNumber.floatValue]
            }];
            @weakify(self)
            [cell action:^(id data) {
//                @strongify(self)
                Coin *coin = (Coin *)data;
#pragma mark - 当前余额
                if ([coin.tagStr isEqualToString:@"当前余额"]) {
                    [MyWalletDetailVC ComingFromVC:weak_self
                                       comingStyle:ComingStyle_PUSH
                                 presentationStyle:UIModalPresentationAutomatic
                                     requestParams:@{
                                         @"MyWalletStyle":@(MyWalletStyle_CURRENTBALANCE),
                                         @"balance":self.myVCModel.balance,
                                         @"goldNumber":self.myVCModel.goldNumber
                                     }
                                           success:^(id data) {}
                                          animated:YES];
#pragma mark - 当前金币
                }else if ([coin.tagStr isEqualToString:@"当前金币"]){
                    [MyWalletDetailVC ComingFromVC:weak_self
                                       comingStyle:ComingStyle_PUSH
                                 presentationStyle:UIModalPresentationAutomatic
                                     requestParams:@{
                                         @"MyWalletStyle":@(MyWalletStyle_CURRENTCOIN),
                                         @"balance":self.myVCModel.balance,
                                         @"goldNumber":self.myVCModel.goldNumber
                                     }
                                           success:^(id data) {}
                                          animated:YES];
                }else{}
            }];
            return cell;
        }break;
        case 2:{
            MyVedioTBVCell *cell = [MyVedioTBVCell cellWith:tableView];
            
            cell.release_LikeVC.mkLiked.mkLikeVCDelegate = self;
            
            [cell richElementsInCellWithModel:nil];
            @weakify(self)
            [cell action:^(id data) {
#pragma mark - 查看更多
                [MyVideoVC ComingFromVC:weak_self
                            comingStyle:ComingStyle_PUSH
                      presentationStyle:UIModalPresentationAutomatic
                          requestParams:nil
                                success:^(id data) {}
                               animated:YES];
            }];
            
            [cell.release_LikeVC.mkLiked requestData:^(id data) {
                
            }];
            [cell.release_LikeVC.mkLiked.collectionView reloadData];
            return cell;
        }break;
        case 3:{
            AnotherTBVCell *cell = [AnotherTBVCell cellWith:tableView];
            [cell richElementsInCellWithModel:nil];
            @weakify(self)
            [cell action:^(id data) {
                @strongify(self)
                if ([data isKindOfClass:FSCustomButton.class]) {
                    FSCustomButton *btn = (FSCustomButton *)data;
                    [[MKTools shared] cleanCacheAndCookie];
                    if ([btn.titleLabel.text isEqualToString:@"填写邀请码"]) {
                        [NSObject showSYSAlertViewTitle:@"功能开发中,敬请期待..."
                                                message:nil
                                        isSeparateStyle:NO
                                           btnTitleArr:@[@"确认"]
                                         alertBtnAction:@[@""]
                                               targetVC:self
                                           alertVCBlock:^(id data) {
                            //DIY
                        }];
                        return;
                        self.webViewVC.url = [NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5InvitationCode,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
                    }else if ([btn.titleLabel.text isEqualToString:@"帮助中心"]){
                        self.webViewVC.url = [NSString stringWithFormat:@"%@%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5HelpCenter];
                    }else if ([btn.titleLabel.text isEqualToString:@"邀请好友"]){
                        self.webViewVC.url =[NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5Invit,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
                    }else{
                        
                    }
                    [self.navigationController pushViewController:self.webViewVC
                                                         animated:YES];
                }
            }];
            return cell;
        }break;
        default:
            return UITableViewCell.new;
            break;
    }
}

#pragma mark —— 点击事件


#pragma mark - 点击喜欢 跳转 推荐列表
- (void)didClickLikeVC:(NSMutableDictionary *)tempDic currentPlayerIndex:(NSInteger)index{
    WeakSelf
    [RecommendVC ComingFromVC:weakSelf comingStyle:ComingStyle_PUSH presentationStyle:UIModalPresentationFullScreen requestParams:tempDic success:^(id data) {
        
    } animated:YES];
}

#pragma mark - 扫一扫
-(void)scanBtnClickEvent:(UIButton *)sender{
    [NSObject showSYSAlertViewTitle:@"功能开发中,敬请期待..."
                            message:nil
                    isSeparateStyle:NO
                        btnTitleArr:@[@"确认"]
                     alertBtnAction:@[@""]
                            targetVC:self
                       alertVCBlock:^(id data) {
        //DIY
    }];
    return;
//    @weakify(self)
//    [DIYScanVC ComingFromVC:weak_self
//                comingStyle:ComingStyle_PUSH
//          presentationStyle:UIModalPresentationAutomatic
//              requestParams:nil
//                    success:^(id data) {}
//                   animated:YES];
}

#pragma mark - 消息
-(void)msgBtnClickEvent:(UIButton *)sender{
    [self.navigationController pushViewController:MKSystemInfoVC.new
                                         animated:YES];
}

#pragma mark - 点击
-(void)settingBtnClickEvent:(UIButton *)sender{
    [self.navigationController pushViewController:MKSettingVC.new
                                         animated:YES];
}
#pragma mark —— lazyLoad
-(UIBarButtonItem *)scanBtnItem{
    if (!_scanBtnItem) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(0,
                               0,
                               44,
                               44);
        [btn setImage:KIMG(@"扫一扫")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(scanBtnClickEvent:)
      forControlEvents:UIControlEventTouchUpInside];
        _scanBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _scanBtnItem;
}

-(UIBarButtonItem *)msgBtnItem{
    if (!_msgBtnItem) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(0,
                               0,
                               44,
                               44);
        [btn setImage:KIMG(@"设置")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(settingBtnClickEvent:)
      forControlEvents:UIControlEventTouchUpInside];
        _msgBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _msgBtnItem;
}

-(UIBarButtonItem *)settingBtnItem{
    if (!_settingBtnItem) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(0,
                               0,
                               44,
                               44);
        [btn setImage:KIMG(@"消息")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(msgBtnClickEvent:)
      forControlEvents:UIControlEventTouchUpInside];
        _settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _settingBtnItem;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = HEXCOLOR(0x242A37);
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.mj_footer.automaticallyHidden = NO;//默认根据数据来源 自动显示 隐藏footer，这个功能可以关闭
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
            make.left.right.equalTo(self.view);
            extern CGFloat LZB_TABBAR_HEIGHT;
            make.bottom.equalTo(self.view).offset(-LZB_TABBAR_HEIGHT);
        }];
        [self.view layoutIfNeeded];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0 ;
        _tableView.mj_header = self.tableViewHeader;
        _tableView.mj_footer = self.tableViewFooter;
        _tableView.mj_footer.hidden = NO;
    }return _tableView;
}

-(MKWebViewVC *)webViewVC{
    if (!_webViewVC) {
        _webViewVC = MKWebViewVC.new;
    }return _webViewVC;
}

@end
