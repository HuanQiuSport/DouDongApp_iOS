//
//  ProductionVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ProductionVC.h"
#import "ProductionVC+VM.h"
#import "MKPersonMadeVideoModel.h"
#import "MKPersonalnfoModel.h"
#import "RecommendVC.h"
@interface ProductionVC ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
LMHWaterFallLayoutDeleaget
>

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)NSMutableArray *shops;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)NSUInteger columnCount;
@property(nonatomic,strong)LMHWaterFallLayout *waterFallLayout;
///
@property (assign,nonatomic) NSInteger mkPageIndex;
@end

@implementation ProductionVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    ProductionVC *vc = ProductionVC.new;
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
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"050013"];
    self.navigationController.navigationBar.hidden = YES;
    self.collectionView.alpha = 1;
    
    
    
    
}
- (void)requestData{
   self.mkPageIndex = 1;
    WeakSelf
   [self requestWith:0 WithPageNumber:1 WithPageSize:10 WithUserID:self.mkPernalModel.id WithType:@"2" Block:^(id data) {
        
        if ((Boolean)data) {
            
             [weakSelf.collectionView reloadData];
            
        }else{
            
             [weakSelf.collectionView reloadData];
            
        }
        
    }];
}

#pragma mark - 下拉刷新
-(void)pullToRefresh{
    WeakSelf
    self.mkPageIndex = 1;
    [self requestWith:0 WithPageNumber:1 WithPageSize:10 WithUserID:self.mkPernalModel.id WithType:@"2" Block:^(id data) {
        [weakSelf.tableViewHeader endRefreshing];
        if ((Boolean)data) {
            
             [self.collectionView reloadData];
            
        }else{
            
        }
        
    }];
}
#pragma mark -  上拉加载更多
- (void)loadMoreRefresh{
    self.mkPageIndex += 1;
    WeakSelf
    [self requestWith:0 WithPageNumber:self.mkPageIndex WithPageSize:10 WithUserID:self.mkPernalModel.id WithType:@"2" Block:^(id data) {
        [weakSelf.tableViewFooter endRefreshing];
        if ((Boolean)data) {
            
             [self.collectionView reloadData];
            
        }else{
            self.mkPageIndex -= 1;
        }
        
    }];
}

#pragma mark —— UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
//    self.collectionView.mj_footer.hidden = self.shops.count == 0;
//    return self.shops.count;
    return self.mkMadeModel.list.count;;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VedioCell" forIndexPath:indexPath];
    
    cell.mkVideoType = MKVideoType_MadeInMe;
    
    MKVideoDemandModel *model = self.mkMadeModel.list[indexPath.item];
    
    [cell richElementsInCellWithModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    WeakSelf
    [RecommendVC ComingFromVC:weakSelf comingStyle:ComingStyle_PUSH presentationStyle:UIModalPresentationFullScreen requestParams:@{@"index":@(indexPath.item),@"model":self.mkMadeModel,@"VideoListType":@(MKVideoListType_C)} success:^(id data) {
        
    } animated:YES];
     
}

#pragma mark —— LMHWaterFallLayoutDeleaget
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout
  heightForItemAtIndexPath:(NSUInteger)indexPath
                 itemWidth:(CGFloat)itemWidth{
    return MAINSCREEN_WIDTH / 2;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return SCALING_RATIO(20);
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return SCALING_RATIO(2);
}
#pragma mark —— lazyLoad
-(LMHWaterFallLayout *)waterFallLayout{
    if (!_waterFallLayout) {
        _waterFallLayout = LMHWaterFallLayout.new;
        _waterFallLayout.delegate = self;
    }return _waterFallLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                             SCALING_RATIO(50),
                                                                             SCREEN_WIDTH,
                                                                             SCREEN_HEIGHT)
                                                 collectionViewLayout:self.waterFallLayout];
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.mj_header = self.tableViewHeader;
    _collectionView.mj_footer = self.tableViewFooter;
    _collectionView.mj_footer.hidden = NO;
    [_collectionView setBackgroundColor:kClearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[VideoCell class]
        forCellWithReuseIdentifier:@"VedioCell"];
    //注册区头
//    [_collectionView registerClass:[HQTopStopView class]
//        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//               withReuseIdentifier:ReuseIdentifier];
    [self.view addSubview:_collectionView];
    return _collectionView;
}
- (MKPersonMadeVideoModel *)mkMadeModel{
    
    if (!_mkMadeModel) {
        
        _mkMadeModel = [[MKPersonMadeVideoModel alloc]init];
    }
    return _mkMadeModel;
}

- (MKPersonalnfoModel *)mkPernalModel{
    
    if (!_mkPernalModel) {
        
        _mkPernalModel = [[MKPersonalnfoModel alloc]init];
    }
    return _mkPernalModel;
}
@end
