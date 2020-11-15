//
//  MKSingeUserCenterVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSingeUserCenterVC.h"
#import "PagingViewTableHeaderView.h"
#import "MKSingeUserCenterVC+Net.h"
#import "MKAttentionVC.h"
#import "MKSingUserCenterDetailVC.h"
#import "MKPersonalnfoModel.h"

@interface MKSingeUserCenterVC () <JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
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

@property(nonatomic,strong)UIButton *rightBarBtn;
@property (nonatomic, assign)NSInteger selectedIndex;
@end

@implementation MKSingeUserCenterVC
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);

//    NSLog(@"🚀🚀🚀🚀🚀🚀%@ %@",@(self.mkScrollFLoat),@(JXTableHeaderViewHeight));
//    if (self.mkScrollFLoat == JXTableHeaderViewHeight) {
//        [self.view sendSubviewToBack:self.gk_navigationBar];
//    }else{
//
//        [self.view sendSubviewToBack:self.pagerView];
//    }
    if (self.mkScrollFLoat >= JXTableHeaderViewHeight - kStatusBarHeight - kNavigationBarHeight) {
        self.gk_navigationBar.hidden = 1;
        
    } else {
        self.gk_navigationBar.hidden = 0;
    }
//    self.gk_navigationBar.hidden = self.mkScrollFLoat;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loginSuccess) name:KLoginSuccessNotifaction object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumber *b = (NSNumber *)self.requestParams[@"MKGoToPersonalType"];
    self.mkGoToPersonalType = b.intValue;
    self.mkScrollFLoat = JXTableHeaderViewHeight;
    [self mkAddView];
    self.mkScrollFLoat = 0;
    [self.userHeaderView.mkPersonView taCenterRefresh];
#pragma mark - 拉黑 隐藏
//    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarBtn];
}

- (void) loginSuccess{
    [self getData];
}

- (void)getData{
    WeakSelf
    [self getDataUserData:self.requestParams[@"videoid"] Block:^(id data) {
        
        [weakSelf.pagerView.mainTableView.mj_header endRefreshing];
        
        if ((Boolean)data) {
            
//            NSLog(@"数据请求成功");
//
//            NSLog(@"%@",weakSelf.mkPernalModel);
            
            [weakSelf MKaddValue];
            
        }else{
            
//            NSLog(@"数据请求失败");
            
        }
    }];
}
- (void)mkAddView{
    self.view.backgroundColor = MKBakcColor;
    self.navigationController.navigationBar.translucent = false;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSString *madeStr = [NSString stringWithFormat:@"作 品 %@",self.mkPernalModel.publicVideoNum];
    NSString *likeStr = [NSString stringWithFormat:@"喜 欢 %@",self.mkPernalModel.videoPraiseNum];
    _titles = @[@"作品",@"喜欢"];

    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
        self.categoryView.titles = self.titles;
        self.categoryView.backgroundColor = MKBakcColor;//
        self.categoryView.delegate = self;
        [self.categoryView setDefaultSelectedIndex:self.selectedIndex];
        self.categoryView.titleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
        self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:22 weight:UIFontWeightRegular];
        self.categoryView.titleSelectedColor = [[MKTools shared] getColorWithColor:RGBCOLOR(247,131,97) andCoe:0.3 andEndColor:RGBCOLOR(245,75,100)];//[UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(50, 25)]];;
        self.categoryView.cellWidth = SCALING_RATIO(135);
        self.categoryView.titleColor = MKNoSelectColor;
        self.userHeaderView.backgroundColor = MKBakcColor;
        self.pagerView.backgroundColor = MKBakcColor;
        self.pagerView.mainTableView.backgroundColor = MKBakcColor;
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        self.categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
        [self.pagerView reloadData];
        
        self.pagerView.listContainerView.listCellBackgroundColor = MKBakcColor;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:CGSizeMake(SCALING_RATIO(135), 3*KDeviceScale)]];;;
        lineView.indicatorWidth = SCALING_RATIO(135);
        lineView.indicatorHeight = 3*KDeviceScale;
        self.categoryView.indicators = @[lineView];

        self.pagerView.mainTableView.gestureDelegate = self;
        [self.view addSubview:self.pagerView];

        self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
        
        self.gk_navLineHidden = YES;
        self.gk_backStyle = GKNavigationBarBackStyleWhite;
        self.gk_navBackgroundColor = MKBakcColor;
    }
    
}

- (void)MKaddValue{
    
    self.userHeaderView.mkPersonView.mkAttentionBtn.selected = [self.mkPernalModel.attention isEqualToString:@"1"]?YES:NO;
    self.userHeaderView.mkPersonView.mkUserVIPImageView.hidden = YES;
    self.userHeaderView.mkPersonView.mkAttentionBtn.hidden = [self.mkPernalModel.areSelf isEqualToString:@"1"]?YES:NO;
    [_userHeaderView.mkPersonView setAtttionStyle:_userHeaderView.mkPersonView.mkAttentionBtn.selected];
    [_userHeaderView.mkPersonView.mkUserImageView sd_setImageWithURL:[NSURL URLWithString:self.mkPernalModel.headImage]];
    _userHeaderView.mkPersonView.mkUserLabel.text = self.mkPernalModel.nickName;
    _userHeaderView.mkPersonView.mkUserLabel.hidden = NO;
    _userHeaderView.mkPersonView.mkDetailLabel.text = [NSString ensureNonnullString:self.mkPernalModel.remark ReplaceStr:@"这个人很懒，什么也没有留下"];
    
    _userHeaderView.mkPersonView.mkAttentionNumView.mkNumberLabel.text = self.mkPernalModel.focusNum;
    _userHeaderView.mkPersonView.mkFansNumView.mkNumberLabel.text = self.mkPernalModel.fansNum;
    _userHeaderView.mkPersonView.mkZanNumView.mkNumberLabel.text = self.mkPernalModel.praiseNum;
    _userHeaderView.mkPersonView.mkArea.text = [NSString ensureNonnullString:self.mkPernalModel.area ReplaceStr:@"浙江省"];
    _userHeaderView.mkPersonView.mkConstellationLab.text = [NSString ensureNonnullString:self.mkPernalModel.constellation ReplaceStr:@"狮子座"];
    
    // @"女" : @"男"
    [_userHeaderView.mkPersonView.mkSexAge setImage: self.mkPernalModel.sex.boolValue?KIMG(@"女"):KIMG(@"男") forState:UIControlStateNormal];
    [_userHeaderView.mkPersonView.mkSexAge setTitle:[NSString ensureNonnullString:[NSString stringWithFormat:@"%@岁",self.mkPernalModel.age] ReplaceStr:@"18岁"] forState:UIControlStateNormal];
    
    
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
                          @"mkType":@(3),
                          @"dataModel":weak_self.mkPernalModel
                      }
                            success:^(id data) {}
                           animated:YES];
    }];
    
    [_userHeaderView.mkPersonView.mkAttentionNumView.mkButton addAction:^(UIButton *btn) {
        if (![MKTools mkLoginIsYESWith:weak_self]) { return; }
        
        [MKAttentionVC ComingFromVC:weak_self
                        comingStyle:ComingStyle_PUSH
                  presentationStyle:UIModalPresentationAutomatic
                      requestParams:@{
                          @"mkType":@(2),@"dataModel":weak_self.mkPernalModel
                      }
                            success:^(id data) {}
                           animated:YES];
    }];
    
    [self.userHeaderView.mkPersonView.mkAttentionBtn addTarget:self action:@selector(attentionBtnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        
}
- (JXPagerListRefreshView *)pagerView{
    
    if (!_pagerView) {
        
        _pagerView= [[JXPagerListRefreshView alloc]initWithDelegate:self];
    }
    return _pagerView;
}

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"🌲%@",@(scrollView.contentOffset.y));
}
- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"🌲🌲%@",@(scrollView.contentOffset.y));
}
- (void)setMainTableViewToMaxContentOffsetY{
//    NSLog(@"🌲🌲🌲%@",@(self.pagerView.mainTableViewMaxContentOffsetY));
}
- (void)setListScrollViewToMinContentOffsetY:(UIScrollView *)scrollView{
//    NSLog(@"🌲🌲🌲🌲%@",@(scrollView.contentOffset.y));
}
- (CGFloat)minContentOffsetYInListScrollView:(UIScrollView *)scrollView{
    return 100;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagerView.frame = CGRectMake(0,kStatusBarHeight, self.view.bounds.size.width, self.view.bounds.size.height- kStatusBarHeight);
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.categoryView.titles.count;
}
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView{
//      NSLog(@"🌲🌲🌲🌲🌲🌲%@",@(scrollView.contentOffset.y));
    self.mkScrollFLoat = scrollView.contentOffset.y;
    if (self.mkScrollFLoat >= JXTableHeaderViewHeight - kStatusBarHeight - kNavigationBarHeight) {
        self.gk_navigationBar.hidden = 1;
        
    } else {
        self.gk_navigationBar.hidden = 0;
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
    self.selectedIndex = index;
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
        
        _mkProductVC.type2 = @"2";
    }
    return _mkProductVC;
}

- (MKSingUserCenterDetailVC<JXPagerViewListViewDelegate> *)mkLikedVC{
    
    if (!_mkLikedVC) {
        
        _mkLikedVC = [[MKSingUserCenterDetailVC alloc]init];
        
        _mkLikedVC.type = @"1";
        
        _mkLikedVC.type2 = @"2";
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
    }
    return _userHeaderView;
}

#pragma mark - 关注
-(void)attentionBtnClickEvent:(UIButton *)sender{
    if([self.mkPernalModel.areSelf isEqualToString:@"1"]){
        [MBProgressHUD wj_showError:@"用户不能对自己进行关注"];
        return;
    }
    
    @weakify(self)
    if ([MKTools mkLoginIsYESWith:weak_self]) {
        if (!sender.selected) {
            //关注
            [self requestAttentionWith:self.mkPernalModel.id
                                         WithBlock:^(id data) {
                @strongify(self)
                if((Boolean)data){
                   
                    sender.selected = !sender.selected;
                    [self.userHeaderView.mkPersonView setAtttionStyle:sender.selected];
//                    [self  mkUpdateHomeRecommendData];
                    [MKTools mkHanderInsertAttentionOfCurrentLoginWithUseId:self.mkPernalModel.id.mutableCopy WithBool:YES];
                    NSInteger number = [self.userHeaderView.mkPersonView.mkFansNumView.mkNumberLabel.text integerValue];
                    number += 1;
                    self.userHeaderView.mkPersonView.mkFansNumView.mkNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
                }
            }];
        }else{
            //取消关注
            [self requestDeleteAttentionWith:self.mkPernalModel.userId WithBlock:^(id data) {
                @strongify(self)
                if((Boolean)data){
                     sender.selected = !sender.selected;
                     [self.userHeaderView.mkPersonView setAtttionStyle:sender.selected];
//                     [self mkUpdateHomeRecommendData];
                    [MKTools mkHanderDeleteAttentionOfCurrentLoginWithUseId:self.mkPernalModel.id.mutableCopy WithBool:NO];
                    NSInteger number = [self.userHeaderView.mkPersonView.mkFansNumView.mkNumberLabel.text integerValue];
                    
                    if (number - 1 < 0) {
                        number = 0;
                    }else{
                        number -= 1;
                    }
                    
                    self.userHeaderView.mkPersonView.mkFansNumView.mkNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
                }
            }];
        }
    }else{}
}
#pragma mark - 进行 关注 | 取消关注 更新首页推荐列表数据
//- (void)mkUpdateHomeRecommendData{
//    if([[MKPublickDataManager sharedPublicDataManage].currentVideoUserString isEqualToString:self.mkPernalModel.userId]){
//        [[NSNotificationCenter defaultCenter] postNotificationName:MKSingleHanderNotification object:nil];
//    }
//
//}
#pragma mark —— 点击事件
-(void)rightBarBtnClickEvent:(UIButton *)sender{
    [NSObject showSYSActionSheetTitle:nil
                              message:nil
                      isSeparateStyle:YES
                          btnTitleArr:@[@"分享",@"举报",@"拉黑",@"取消"]
                       alertBtnAction:@[@"share",@"report",@"blacklist",@"cancel"]
                             targetVC:self
                               sender:sender
                         alertVCBlock:^(id data) {
        //DIY
    }];
}
#pragma mark - 分享
-(void)share{
    WeakSelf
    if (![MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:YES]) {
        return;
    }
}
#pragma mark - 举报
-(void)report{
    WeakSelf
    if (![MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:YES]) {
        [MBProgressHUD wj_showPlainText:@"正在开发中" view:self.view];
    }
}
#pragma mark - 黑名单
-(void)blacklist{
    WeakSelf
    if (![MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:YES]) {
        return;
    }else{
        [self requestAddBlackListWith:self.mkPernalModel.id WithBlock:^(id data) {
              if ((Boolean)data) {
                  [MBProgressHUD wj_showSuccess:@"加入黑名单成功"];
              }else{
                  [MBProgressHUD wj_showSuccess:@"加入黑名单失败"];
              }
          }];
    }
}
#pragma mark - 取消
-(void)cancel{
    
}

-(UIButton *)rightBarBtn{
    if (!_rightBarBtn) {
        _rightBarBtn = UIButton.new;
        [_rightBarBtn setBackgroundImage:KIMG(@"省略号")
                                forState:UIControlStateNormal];
        [_rightBarBtn addTarget:self
                         action:@selector(rightBarBtnClickEvent:)
               forControlEvents:UIControlEventTouchUpInside];
    }return _rightBarBtn;
}

@end
