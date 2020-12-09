//
//  CoinDetailVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CoinDetailVC.h"
#import "CoinDetailVC+VM.h"

@interface CoinDetailVC ()
<
UITableViewDelegate
,UITableViewDataSource
>

@end

@implementation CoinDetailVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.walletStyle = MyWalletStyle_CURRENTCOIN;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.gk_navTitle = @"";
    self.gk_navLineHidden = YES;
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    [SceneDelegate sharedInstance].customSYSUITabBarController.gk_navigationBar.hidden = YES;
    self.tableView.alpha = 1;
    [self netWorking_MKWalletMyFlowsPOST];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = NO;
}
#pragma mark ==========<UITableViewDelegate,UITableViewDataSource>===========
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyWalletDetailTBVCell cellHeightWithModel:NULL];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.walletMyFlowsListModelMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyWalletDetailTBVCell *cell = [MyWalletDetailTBVCell cellWith:tableView];
    [cell richElementsInCellWithModel:@{
        @"MKWalletMyFlowsListModel":self.walletMyFlowsListModelMutArr[indexPath.row],
        @"MyWalletStyle":@(self.walletStyle)
    }];
    return cell;
}
#pragma mark ===================== 下拉刷新===================================
- (void)pullToRefresh {
    if (self.walletMyFlowsListModelMutArr.count) {
        [self.walletMyFlowsListModelMutArr removeAllObjects];
    }
    [self netWorking_MKWalletMyFlowsPOST];
}
#pragma mark ===================== 上拉加载更多===================================
- (void)loadMoreRefresh {
}
-(void)endRefreshing:(BOOL)refreshing{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = [UIColor colorWithPatternImage:KIMG(@"桌布")];
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.mj_footer.automaticallyHidden = NO;//默认根据数据来源 自动显示 隐藏footer，这个功能可以关闭
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0 ;
        _tableView.mj_header = [self mjRefreshGifHeader];
        _tableView.mj_footer = [self mjRefreshAutoGifFooter];
        _tableView.mj_footer.hidden = NO;
        _tableView.ly_emptyView = [EmptyView emptyViewWithImageStr:@"Indeterminate Spinner - Small"
                                                          titleStr:@""
                                                         detailStr:@""];
        if (self.walletMyFlowsListModelMutArr.count) {
            [_tableView ly_hideEmptyView];
        }else{
            [_tableView ly_showEmptyView];
        }
    }return _tableView;
}

-(NSMutableArray<MKWalletMyFlowsListModel *> *)walletMyFlowsListModelMutArr{
    if (!_walletMyFlowsListModelMutArr) {
        _walletMyFlowsListModelMutArr = NSMutableArray.array;
    }return _walletMyFlowsListModelMutArr;
}

@end
