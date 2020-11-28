//
//  MKMineVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/17/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKMineVC.h"
#import "PagingViewTableHeaderView.h"
#import "MKMineVC+NET.h"
#import "MKAttentionVC.h"
#import "MKSingUserCenterDetailVC.h"
#import "MKPersonalnfoModel.h"
#import "MyWalletDetailVC.h"
#import "MKWebViewVC.h"
#import "MKSystemInfoVC.h"
#import "MKSettingVC.h"
#import "EditUserInfoVC.h"

#import "MyCoinVC.h"
#import "TKCarouselView.h"
//#import <PPBadgeView.h>

@interface MKMineVC ()<JXCategoryViewDelegate,MKMineDidDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIView *ategoryViewBgView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

/// ProductionVC
@property (strong,nonatomic) MKSingUserCenterDetailVC *mkProductVC;
/// LikedVC
@property (strong,nonatomic) MKSingUserCenterDetailVC *mkLikedVC;

/// 进入页面属性
@property (assign,nonatomic) MKGoToPersonalType mkGoToPersonalType;
@property (nonatomic, assign) BOOL isHeaderRefreshed;

/// adjust hiden
@property (assign,nonatomic) CGFloat mkScrollFLoat;

@property(nonatomic,strong)UIBarButtonItem *scanBtnItem;
@property(nonatomic,strong)UIBarButtonItem *msgBtnItem;
@property(nonatomic,strong)UIBarButtonItem *settingBtnItem;

@property(nonatomic,assign)NSInteger recordIndex;

@end

@implementation MKMineVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    WeakSelf
    if ([MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:NO]) {
        [self getData];
        // 上传成功过来的
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successUploadAction) name:@"SuccessUploadPushToMine" object:nil];
    }
    #warning UserDefault存页面暂时解决上传页面返回问题
    SetUserDefaultKeyWithValue(@"selectedIndex", @"4");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    WeakSelf
//    if ([MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:NO]) {
//        [self getData];
//    }
     [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    self.navigationController.navigationBar.hidden = self.mkScrollFLoat;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view sendSubviewToBack:self.gk_navigationBar];
    self.gk_navRightBarButtonItems = @[self.msgBtnItem];
//    [self.settingBtnItem pp_addDotWithColor:[UIColor colorWithPatternImage:KIMG(@"画板")]];
//    self.gk_navLeftBarButtonItems =  @[self.settingBtnItem];
    
    self.gk_navTitle = @"";
    self.gk_statusBarHidden = NO;
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
    [self mkAddView];
    [self addNotifaction];
    [self logout];
    [self refreshSkin];
}

-(void)refreshSkin {
    if ([SkinManager manager].skin == MKSkinWhite) {
        UIColor *backColor = UIColor.whiteColor;
        self.view.backgroundColor = HEXCOLOR(0xF7F7F7);
        self.categoryView.backgroundColor = backColor;//
        self.categoryView.titleColor = HEXCOLOR(0x8F8F94);
        self.categoryView.titleSelectedColor = UIColor.blackColor;
        self.userHeaderView.backgroundColor = backColor;
        self.pagerView.backgroundColor = backColor;
        self.categoryView.subviews.firstObject.backgroundColor = backColor;
        self.pagerView.mainTableView.backgroundColor = HEXCOLOR(0xF7F7F7);
        self.pagerView.listContainerView.listCellBackgroundColor = backColor;
        self.gk_navBackgroundColor = backColor;
    } else {
        self.view.backgroundColor = MKBakcColor;
        self.categoryView.backgroundColor = MKBakcColor;//
        self.categoryView.titleColor = MKNoSelectColor;
        self.categoryView.titleSelectedColor = UIColor.redColor;
        self.userHeaderView.backgroundColor = MKBakcColor;
        self.pagerView.backgroundColor = MKBakcColor;
        self.pagerView.mainTableView.backgroundColor = MKBakcColor;
        self.categoryView.subviews.firstObject.backgroundColor = MKBakcColor;
        self.pagerView.mainTableView.backgroundColor = MKBakcColor;
        self.pagerView.listContainerView.listCellBackgroundColor = MKBakcColor;
        self.gk_navBackgroundColor = MKBakcColor;
    }
    [self.userHeaderView refreshSkin];
}



- (void)addNotifaction {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:KLoginSuccessNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:KLoginOutNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshHeadImg) name:MKRefreshHeadImgNotification object:nil];
    
}

- (void)loginSuccess {
    [self loginSuccessUI];
    [self getData];
}

-(void)loginSuccessUI {
    _userHeaderView.mkPersonView.mkBanerView.alpha = 1;
    _userHeaderView.mkPersonView.loginBtn.hidden = 1;
    _userHeaderView.mkPersonView.loginLab.hidden = 1;
    _userHeaderView.mkPersonView.mkUserLabel.hidden = 0;
    _userHeaderView.mkPersonView.mkAttentionBtn.hidden = 0;
    _userHeaderView.mkPersonView.mkDetailLabel.hidden = 0;
    _userHeaderView.mkPersonView.mkSexAge.hidden = 0;
    _userHeaderView.mkPersonView.mkArea.hidden = 0;
    _userHeaderView.mkPersonView.mkConstellationLab.hidden = 0;
    _userHeaderView.mkPersonView.mkEditorBtn.hidden = 0;
    _userHeaderView.mkPersonView.mkArea.hidden = NO;
    _userHeaderView.mkPersonView.mkSexAge.hidden = NO;
    _userHeaderView.mkPersonView.mkConstellationLab.hidden = NO;

}


- (void)logout {
    _userHeaderView.mkPersonView.loginBtn.hidden = 0;
    _userHeaderView.mkPersonView.loginLab.hidden = 0;
    _userHeaderView.mkPersonView.mkSexAge.hidden = 1;
    _userHeaderView.mkPersonView.mkArea.hidden = 1;
    _userHeaderView.mkPersonView.mkConstellationLab.hidden = 1;
    _userHeaderView.mkPersonView.mkAttentionNumView.mkNumberLabel.text = @"0";
    _userHeaderView.mkPersonView.mkZanNumView.mkNumberLabel.text = @"0";
    _userHeaderView.mkPersonView.mkFansNumView.mkNumberLabel.text = @"0";
    _userHeaderView.mkPersonView.mkArea.hidden = YES;
    _userHeaderView.mkPersonView.mkSexAge.hidden = YES;
    _userHeaderView.mkPersonView.mkConstellationLab.hidden = YES;
    _userHeaderView.mkPersonView.mkUserLabel.hidden = 1;
    _userHeaderView.mkPersonView.mkAttentionBtn.hidden = 1;
    _userHeaderView.mkPersonView.mkDetailLabel.hidden = 1;
    _userHeaderView.mkPersonView.mkUserImageView.image = KIMG(@"替代头像");
    _userHeaderView.mkPersonView.mkUserVIPImageView.hidden = 1;
    _userHeaderView.mkPersonView.mkEditorBtn.hidden = 1;
}

- (void)successUploadAction
{
//    [self.categoryView selectedIndex:0];
    [self.categoryView selectItemAtIndex:0];
}
- (void)refreshHeadImg{
    [_userHeaderView.mkPersonView.mkUserImageView
     sd_setImageWithURL:[NSURL URLWithString:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.headImage]
     placeholderImage:[UIImage imageNamed:@"default_avatar_white.jpg"]];
}

- (void)getData{
    
    WeakSelf
    NSLog(@"%@",[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid);
    [self getDataUserData:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid Block:^(id data) {
        
        
        if ((Boolean)data) {
            
            NSLog(@"数据请求成功");
            
//            NSLog(@"%@",weakSelf.mkPernalModel);
            [weakSelf MKaddValue];
            
            
        }else{
            
            NSLog(@"数据请求失败");
            
        }
    }];
    
    

}
- (void)mkAddView{
    
    self.view.backgroundColor = MKBakcColor;
    self.navigationController.navigationBar.translucent = false;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.titles = @[@"作品",@"喜欢"];
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_categoryView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _categoryView.bounds;
    maskLayer.path = maskPath.CGPath;
    _categoryView.layer.mask = maskLayer;
    
   
    
    
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = MKBakcColor;//
    self.categoryView.delegate = self;
    self.categoryView.titleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:22 weight:UIFontWeightRegular];
    self.categoryView.titleSelectedColor = [[MKTools shared] getColorWithColor:RGBCOLOR(247,131,97) andCoe:0.3 andEndColor:RGBCOLOR(245,75,100)];//[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(50, 25)]];
    self.categoryView.cellWidth = SCALING_RATIO(135);
    self.categoryView.titleColor = MKNoSelectColor;
    self.userHeaderView.backgroundColor = MKBakcColor;
    self.pagerView.backgroundColor = MKBakcColor;
    self.pagerView.mainTableView.backgroundColor = MKBakcColor;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
    [self.pagerView reloadData];
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(135), 3*KDeviceScale)]];;
    lineView.indicatorWidth = SCALING_RATIO(135);
    lineView.indicatorHeight = 3*KDeviceScale;
    self.categoryView.indicators = @[lineView];
    self.categoryView.subviews.firstObject.backgroundColor = MKBakcColor;
    [self.categoryView setDefaultSelectedIndex:self.recordIndex];
    self.pagerView.mainTableView.gestureDelegate = self;
    self.pagerView.mainTableView.backgroundColor = MKBakcColor;
    [self.view addSubview:self.pagerView];

    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    self.pagerView.listContainerView.listCellBackgroundColor = MKBakcColor;
    self.gk_navLineHidden = YES;
    self.gk_backStyle = GKNavigationBarBackStyleWhite;
    self.gk_navBackgroundColor = MKBakcColor;
    
    if (self.mkScrollFLoat == MKMineVC_JXTableHeaderViewHeight) {
        [self.view sendSubviewToBack:self.gk_navigationBar];
    }else{
        [self.view sendSubviewToBack:self.pagerView];
    }
}

- (void)MKaddValue{
    [self loginSuccessUI];
    self.userHeaderView.mkPersonView.mkAttentionBtn.selected = [self.mkPernalModel.attention isEqualToString:@"1"]?YES:NO;
    //[self.mkPernalModel.areSelf isEqualToString:@"1"]?YES:NO
    self.userHeaderView.mkPersonView.mkAttentionBtn.hidden = YES;
    self.userHeaderView.mkPersonView.mkUserVIPImageView.hidden = YES;
    [_userHeaderView.mkPersonView setAtttionStyle:_userHeaderView.mkPersonView.mkAttentionBtn.selected];
    if ([self.mkPernalModel.headImage rangeOfString:@"headimg"].location != NSNotFound) {
        _userHeaderView.mkPersonView.mkUserImageView.image = [UIImage imageNamed:@"default_avatar_white.jpg"];
    }
    else
    {
        [_userHeaderView.mkPersonView.mkUserImageView sd_setImageWithURL:[NSURL URLWithString:self.mkPernalModel.headImage]];
    }
    
    _userHeaderView.mkPersonView.mkUserLabel.text = self.mkPernalModel.nickName;
    _userHeaderView.mkPersonView.mkUserLabel.hidden = NO;
    _userHeaderView.mkPersonView.mkDetailLabel.text = [NSString ensureNonnullString:self.mkPernalModel.remark ReplaceStr:@"填写个人签名更容易获得别人的关注。"];
    _userHeaderView.mkPersonView.mkAttentionNumView.mkNumberLabel.text = self.mkPernalModel.focusNum;
    _userHeaderView.mkPersonView.mkFansNumView.mkNumberLabel.text = self.mkPernalModel.fansNum;
    _userHeaderView.mkPersonView.mkZanNumView.mkNumberLabel.text = self.mkPernalModel.praiseNum;
    _userHeaderView.mkPersonView.mkArea.text = [NSString ensureNonnullString:self.mkPernalModel.area ReplaceStr:@"浙江省"];
    _userHeaderView.mkPersonView.mkConstellationLab.text = [NSString ensureNonnullString:self.mkPernalModel.constellation ReplaceStr:@"狮子座"];
    
    // @"女" : @"男"
    [_userHeaderView.mkPersonView.mkSexAge setImage: self.mkPernalModel.sex.boolValue?KIMG(@"女"):KIMG(@"男") forState:UIControlStateNormal];
    NSString *ageTemp = [NSString stringWithFormat:@"%@岁",[NSString ensureNonnullString:self.mkPernalModel.age ReplaceStr:@"18"]];
    [_userHeaderView.mkPersonView.mkSexAge setTitle:ageTemp forState:UIControlStateNormal];
    _userHeaderView.mkPersonView.mkMultiBtnView.mkDelegate = self;
    self.mkProductVC.mkPernalModel = self.mkPernalModel;
    
    self.mkLikedVC.mkPernalModel = self.mkPernalModel;
    
    [self.mkProductVC requestData];
    
    [self.mkLikedVC requestData];
    
    @weakify(self)
    [_userHeaderView.mkPersonView.mkFansNumView.mkButton addAction:^(UIButton *btn) {
        
        if (![MKTools mkLoginIsYESWith:weak_self]) { return; }
        
        [MKAttentionVC ComingFromVC:weak_self
                        comingStyle:ComingStyle_PUSH
                  presentationStyle:UIModalPresentationAutomatic
                      requestParams:@{
                          @"mkType":@(1),
                          @"dataModel":weak_self.mkPernalModel
                      }
                            success:^(id data) {}
                           animated:YES];
    }];
    
    [_userHeaderView.mkPersonView.mkAttentionNumView.mkButton addAction:^(UIButton *btn) {
        if (![MKTools mkLoginIsYESWith:weak_self]) { return; }
       MKAttentionVC *attention =  [MKAttentionVC ComingFromVC:weak_self
                        comingStyle:ComingStyle_PUSH
                  presentationStyle:UIModalPresentationAutomatic
                      requestParams:@{
                          @"mkType":@(0),@"dataModel":weak_self.mkPernalModel
                      }
                            success:^(id data) {}
                           animated:YES];
        
        [attention attentionVCBlock:^(id data) {
            MKPersonalnfoModel *model = (MKPersonalnfoModel *)data;
            weak_self.userHeaderView.mkPersonView.mkFansNumView.mkNumberLabel.text = model.fansNum;
            weak_self.userHeaderView.mkPersonView.mkZanNumView.mkNumberLabel.text = model.praiseNum;
        }];
    }];
    [_userHeaderView.mkPersonView mkRefreshUILayout];
    [_userHeaderView.mkPersonView addOherView];
    
    
    [self.userHeaderView.mkPersonView.mkEditorBtn addAction:^(UIButton *btn) {
        [EditUserInfoVC ComingFromVC:weak_self
              comingStyle:ComingStyle_PUSH
        presentationStyle:UIModalPresentationAutomatic
            requestParams:nil
                  success:^(id data) {}
                 animated:YES];
    }];
}
#pragma mark - 消息
-(void)msgBtnClickEvent:(UIButton *)sender{
    if(![MKTools mkLoginIsYESWith:self]) {
        return;
    }
    [self.navigationController pushViewController:MKSystemInfoVC.new
                                         animated:YES];
}

#pragma mark - 点击
-(void)settingBtnClickEvent:(UIButton *)sender{
    if(![MKTools mkLoginIsYESWith:self]) {
        return;
    }
    [self.navigationController pushViewController:MKSettingVC.new
                                         animated:YES];
}
- (void)didClickMineView:(UIView *)superView WithIndex:(NSInteger)index{

    switch (index) {
        case 0:
            [self goToBance];
            break;
        case 1:
             [self goToGoldNumber];
            break;
        case 2:
             [self goToInviteFriends];
            break;
        case 3:
             [self goToInviteCode];
            break;
        case 4:
             [self goToHelpCenter];
            break;
        default:
            break;
    }
}

#pragma mark - 我的抖币
- (void)goToGoldNumber{
    @weakify(self)
    [MyCoinVC ComingFromVC:weak_self
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIModalPresentationAutomatic
                     requestParams:@{
                         @"MyWalletStyle":@(MyWalletStyle_CURRENTCOIN),
                         @"balance":self.mkPernalModel.balance,
                         @"goldNumber":self.mkPernalModel.goldNumber
                     }
                           success:^(id data) {}
                          animated:YES];
}
#pragma mark - 我的余额
- (void)goToBance{
    
    @weakify(self)
    [MyWalletDetailVC ComingFromVC:weak_self
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIModalPresentationAutomatic
                     requestParams:@{
                         @"MyWalletStyle":@(MyWalletStyle_CURRENTBALANCE),
                         @"balance":self.mkPernalModel.balance,
                         @"goldNumber":self.mkPernalModel.goldNumber
                     }
                           success:^(id data) {}
                          animated:YES];
}
#pragma mark - 邀请好友
- (void)goToInviteFriends{
    
    MKWebViewVC *vc = MKWebViewVC.new;
    
    vc.url =[NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5Invit,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 填写邀请码
- (void)goToInviteCode{
//          self.webViewVC.url =[NSString stringWithFormat:@"%@%@?token=%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5Invit,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
    MKWebViewVC *vc = MKWebViewVC.new;
    
    vc.url = [NSString stringWithFormat:@"%@%@?token=%@&goback=yes",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5InvitationCode,[MKPublickDataManager sharedPublicDataManage].mkLoginModel.token];
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 帮助中心
- (void)goToHelpCenter{
    
    MKWebViewVC *vc = MKWebViewVC.new;
    
    vc.url = [NSString stringWithFormat:@"%@%@",[URL_Manager sharedInstance].BaseUrl_H5,[URL_Manager sharedInstance].MKH5HelpCenter];
    
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)Sure{
    
}
- (JXPagerListRefreshView *)pagerView{
    
    if (!_pagerView) {
        
        _pagerView= [[JXPagerListRefreshView alloc]initWithDelegate:self];
        _pagerView.layer.masksToBounds = true;
        _pagerView.layer.cornerRadius = 15;
        
    }
    return _pagerView;
}

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"🌲%@",@(scrollView.contentOffset.y));
}
- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"🌲🌲%@",@(scrollView.contentOffset.y));
}
- (void)setMainTableViewToMaxContentOffsetY{
    NSLog(@"🌲🌲🌲%@",@(self.pagerView.mainTableViewMaxContentOffsetY));
}
- (void)setListScrollViewToMinContentOffsetY:(UIScrollView *)scrollView{
    NSLog(@"🌲🌲🌲🌲%@",@(scrollView.contentOffset.y));
}
- (CGFloat)minContentOffsetYInListScrollView:(UIScrollView *)scrollView{
    return 100;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat tabbarHeight =  isiPhoneX_series() ? (50 + isiPhoneX_seriesBottom) : 50;
    self.pagerView.frame = CGRectMake(0,kStatusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height- kStatusBarHeight - tabbarHeight - 12);
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return MKMineVC_JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return MKMineVC_JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.categoryView.titles.count;
}
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView{
      NSLog(@"🌲🌲🌲🌲🌲🌲%@",@(scrollView.contentOffset.y));
    self.mkScrollFLoat = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y == MKMineVC_JXTableHeaderViewHeight ) {
        [self.view sendSubviewToBack:self.gk_navigationBar];
    }else{
        [self.view sendSubviewToBack:self.pagerView];
        NSLog(@"🌲🌲🌲🌲🌲🌲🔥🔥%@",@(scrollView.contentOffset.y));
    }
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}
- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    
    return @[self.mkProductVC,self.mkLikedVC][index];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    
    if (index == 0) {
        [self.mkProductVC requestData];
    }
    if (index == 1){
        [self.mkLikedVC requestData];
    }
    self.recordIndex = index;
}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}
- (MKSingUserCenterDetailVC<JXPagerViewListViewDelegate> *)mkProductVC{
    
    if (!_mkProductVC) {
        
        _mkProductVC = [[MKSingUserCenterDetailVC alloc]init];
        
        _mkProductVC.type = @"2";
        _mkProductVC.type2 = @"1";
    }
    return _mkProductVC;
}

- (MKSingUserCenterDetailVC<JXPagerViewListViewDelegate> *)mkLikedVC{
    
    if (!_mkLikedVC) {
        
        _mkLikedVC = [[MKSingUserCenterDetailVC alloc]init];
        
        _mkLikedVC.type = @"1";
        _mkLikedVC.type2 = @"1";
    }
    return _mkLikedVC;
}
- (MKPersonalnfoModel *)mkPernalModel{
    
    if (!_mkPernalModel) {
        
        _mkPernalModel = [[MKPersonalnfoModel alloc]init];
        
    }
    return _mkPernalModel;
}
- (PagingViewTableHeaderView *)userHeaderView{
    if (!_userHeaderView) {
        _userHeaderView = [[PagingViewTableHeaderView alloc] init];
        [_userHeaderView.mkPersonView setNoLoginData];
        _userHeaderView.mkPersonView.mkBanerView.alpha = 1;
    }
    return _userHeaderView;
}

-(UIBarButtonItem *)msgBtnItem{
    if (!_msgBtnItem) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(0, 0, 44,44);
        [btn setImage:KIMG(@"white_profile_设置")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(settingBtnClickEvent:)
      forControlEvents:UIControlEventTouchUpInside];
        _msgBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _msgBtnItem;
}
#pragma mark —— lazyLoad
-(UIBarButtonItem *)scanBtnItem{
    if (!_scanBtnItem) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(0, 0, 44,44);
        [btn setImage:KIMG(@"扫一扫")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(scanBtnClickEvent:)
      forControlEvents:UIControlEventTouchUpInside];
        _scanBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _scanBtnItem;
}
-(UIBarButtonItem *)settingBtnItem{
    if (!_settingBtnItem) {
        UIButton *btn = UIButton.new;
//        [btn pp_addDotWithColor:[UIColor redColor]];
        btn.frame = CGRectMake(0,  0, 44,  44);
        [btn setImage:KIMG(@"消息")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(msgBtnClickEvent:)
      forControlEvents:UIControlEventTouchUpInside];
        _settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _settingBtnItem;
}


@end
