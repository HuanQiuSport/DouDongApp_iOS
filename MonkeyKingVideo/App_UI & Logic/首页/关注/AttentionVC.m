//
//  AttentionVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "AttentionVC.h"
#import "AttentionTBVCell.h"
#import "AttentionVC+VM.h"

#import "MKHAttentionModel.h"
#import "MKVideoDemandModel.h"
#import "RecommendVC.h"
@interface AttentionVC ()
<
UICollectionViewDataSource
,UICollectionViewDelegate
,LMHWaterFallLayoutDeleaget
>

@property(nonatomic,strong)NSMutableArray *shops;
@property(nonatomic,assign)NSUInteger columnCount;
@property(nonatomic,strong)LMHWaterFallLayout *waterFallLayout;
//data
@property(nonatomic,strong)NSMutableArray *datas;
/// 推荐VC
@property (strong,nonatomic) RecommendVC *mkRVC;
/// pageNUmbder
@property (assign,nonatomic) NSInteger mkPageNumbder;
@property (strong,nonatomic) UIImageView *mkBackImageView;
@property (strong,nonatomic) UILabel *mkBackNoDataTextLabel;
//未登录
@property (nonatomic, strong)UIView *loginView;
@property (nonatomic, strong)UILabel *loginLab1;
@property (nonatomic, strong)UILabel *loginLab2;
@property (nonatomic, strong)UIButton *loginBtn;
@end

@implementation AttentionVC

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {

    }return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testAttentionVC" object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    self.mkBackImageView.alpha = 1;
    self.mkCollectionView.alpha = 1;
    self.mkBackNoDataTextLabel.alpha = 1;
    self.mkPageNumbder = 1;
    WeakSelf
    if([MKTools mkLoginIsLogin]){
        [self.mkCollectionView addSubview:self.loginView];
        self.mkCollectionView.scrollEnabled = 0;
    }else{
        [self requestWith:0 WithPageNumber:self.mkPageNumbder WithPageSize:10 WithUserId:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid Block:^(id data) {
            if ((Boolean)data) {
                [weakSelf.mkCollectionView reloadData];
            }else{
            }
        }];
    }
    [self addNofi];
}
- (void)addNofi{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:KLoginSuccessNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutSuccess) name:KLoginOutNotifaction object:nil];
}
- (void)loginSuccess {
    [self.loginView removeFromSuperview];
    self.mkCollectionView.scrollEnabled = 1;
    [self.mkhAttentionModel.list removeAllObjects];
    [self pullToRefresh];
}
- (void)logOutSuccess {
    self.mkCollectionView.scrollEnabled = 0;
    [self.mkCollectionView addSubview:self.loginView];
    [self.mkhAttentionModel.list removeAllObjects];
    [self pullToRefresh];
}
#pragma mark ===================== 下拉刷新===================================
- (void)pullToRefresh {
    @weakify(self)
    [MKTools testOpenStart:@"下拉刷新"];
    self.mkPageNumbder = 1;
    [self requestWith:0 WithPageNumber:1 WithPageSize:10 WithUserId:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid  Block:^(id data) {
        @strongify(self)
        [self.mkCollectionView.mj_header endRefreshing];
        [MKTools testOpenResultSucess:@"下拉刷新"];
        if ((Boolean)data) {
            [self.mkCollectionView reloadData];
        }else{
        }
    }];
}
#pragma mark ===================== 下拉刷新===================================
- (void)loadMoreRefresh {
    self.mkPageNumbder ++;
    @weakify(self)
    [self requestWith:0 WithPageNumber:self.mkPageNumbder WithPageSize:10 WithUserId:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid Block:^(id data) {
        @strongify(self)
        if ((Boolean)data) {
            if (self.mkhAttentionModel.list.count == 0) {
                self.mkPageNumbder --;
            }
            [self.mkCollectionView reloadData];
        }else{
            self.mkPageNumbder --;
        }
    }];
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [UIViewController comingFromVC:self
                              toVC:RecommendVC.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:@{@"index":@(indexPath.item),
                                     @"model":self.mkhAttentionModel,
                                     @"VideoListType":@(MKVideoListType_B)}
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:^(id data) {}];
}

#pragma mark —— LMHWaterFallLayoutDeleaget
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout
  heightForItemAtIndexPath:(NSUInteger)indexPath
                 itemWidth:(CGFloat)itemWidth{
    return 274 * 1;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return 20;
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return 2;
}

#pragma mark —— lazyLoad
-(LMHWaterFallLayout *)waterFallLayout{
    if (!_waterFallLayout) {
        _waterFallLayout = LMHWaterFallLayout.new;
        _waterFallLayout.delegate = self;
    }return _waterFallLayout;
}

- (MKHAttentionModel *)mkhAttentionModel{
    if (!_mkhAttentionModel) {
        _mkhAttentionModel = [[MKHAttentionModel alloc]init];
    }
   return  _mkhAttentionModel;
}

#pragma mark - 新列表
- (UICollectionView *)mkCollectionView{
    if (!_mkCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 2.5;
        layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
        _mkCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, rectOfStatusbar() + 44,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height- rectOfStatusbar() - 44) collectionViewLayout:layout];
        [_mkCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        _mkCollectionView.dataSource = self;
        _mkCollectionView.delegate = self;
        [_mkCollectionView registerClass:[VideoCell class]
               forCellWithReuseIdentifier:@"VedioCell"];
        _mkCollectionView.mj_header = [self mjRefreshGifHeader];
        _mkCollectionView.mj_footer = [self mjRefreshAutoGifFooter];
//        _mkCollectionView.mj_footer.hidden = YES;
        [[self mjRefreshAutoGifFooter] setTitle:@"暂时没有更多了"
               forState:MJRefreshStateNoMoreData];
        _mkCollectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_mkCollectionView];
        [_mkCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
            make.top.equalTo(self.view.mas_top).offset(rectOfStatusbar() + 44);
        }];
        _mkCollectionView.backgroundColor = HEXCOLOR(0xf8f8f8);
    }
    return _mkCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.mkhAttentionModel.list.count == 0) {
        self.mkBackNoDataTextLabel.hidden = NO;
        self.mkBackNoDataTextLabel.text = [MKTools mkLoginIsLogin] ? @"" : @"暂无更多哦，请去看视频";
        self.mkBackImageView.hidden = NO;
    }else{
        self.mkBackNoDataTextLabel.hidden = YES;
    }
    return self.mkhAttentionModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VedioCell" forIndexPath:indexPath];
    cell.mkVideoType = MKVideoType_Attention;
    MKVideoDemandModel *model = self.mkhAttentionModel.list[indexPath.item];
    [cell richElementsInCellWithModel:model];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (([UIScreen mainScreen].bounds.size.width-15)/2);
    CGSize size = CGSizeMake(width, 274 * 1);
    return size;
}
- (UIImageView *)mkBackImageView{
    if (!_mkBackImageView) {
        _mkBackImageView = [[UIImageView alloc]init];
//        _mkBackImageView.image = KIMG(@"nodata");
        _mkBackImageView.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:_mkBackImageView];
        [_mkBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
            make.top.equalTo(self.view.mas_top).offset(0);
        }];
    }
    return _mkBackImageView;
}

- (UILabel *)mkBackNoDataTextLabel{
    if (!_mkBackNoDataTextLabel) {
        _mkBackNoDataTextLabel = [[UILabel alloc]init];
        _mkBackNoDataTextLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _mkBackNoDataTextLabel.textColor = HEXCOLOR(0x999999);
        _mkBackNoDataTextLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_mkBackNoDataTextLabel];
        [_mkBackNoDataTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.view);
            make.centerX.equalTo(self.view);
        }];
    }
    return _mkBackNoDataTextLabel;
}

- (UIView *)loginView {
    if (!_loginView) {
        _loginView = UIView.new;
        _loginView.backgroundColor =  [UIColor colorWithWhite:0 alpha:0];
        _loginView.frame = self.view.frame;
        [_loginView addSubview:self.loginLab1];
        [_loginView addSubview:self.loginLab2];
        [_loginView addSubview:self.loginBtn];
    }
    return _loginView;
}
- (UILabel *)loginLab1 {
    if (!_loginLab1) {
        _loginLab1 = UILabel.new;
        _loginLab1.frame = CGRectMake(0, 258, MAINSCREEN_WIDTH, 28);
        _loginLab1.text = @"你还没有登录";
        _loginLab1.textColor = HEXCOLOR(0x999999);
        _loginLab1.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
        _loginLab1.textAlignment = NSTextAlignmentCenter;
    }
    return _loginLab1;
}
- (UILabel *)loginLab2 {
    if (!_loginLab2) {
        _loginLab2 = UILabel.new;
        _loginLab2.frame = CGRectMake(0, 292, MAINSCREEN_WIDTH, 17);
        _loginLab2.text = @"登录账户查看你关注的精彩内容";
        _loginLab2.textColor = HEXCOLOR(0x999999);
        _loginLab2.font = [UIFont systemFontOfSize:12];
        _loginLab2.textAlignment = NSTextAlignmentCenter;
    }
    return _loginLab2;
}
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = UIButton.new;
        
        _loginBtn.frame = CGRectMake(50, 391, MAINSCREEN_WIDTH-100, 44);
        _loginBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor") andResizeTo:_loginBtn.frame.size]];
//        [_loginBtn setBackgroundImage:KIMG(@"login_gradualColor") forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.adjustsImageWhenHighlighted = 0;
        _loginBtn.layer.cornerRadius = 22;
        _loginBtn.layer.masksToBounds = 1;
        [_loginBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        @weakify(self)
        [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if ([MKTools mkLoginIsYESWith:self]) {
                
            }
        }];
    }
    return _loginBtn;
}

@end
