//
//  LikeVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LikedVC.h"
#import "LikedVC+VM.h"
#import "RecommendVC.h"
#import "MKPersonalnfoModel.h"
#import "MKPersonalLikeModel.h"
#import "MKVideoDemandModel.h"
@interface LikedVC ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
LMHWaterFallLayoutDeleaget
>

/// 新的View
@property (strong,nonatomic) UICollectionView *mkCollectionView;
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

@implementation LikedVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    LikedVC *vc = LikedVC.new;
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
//    self.collectionView.alpha = 1;
    self.mkCollectionView.alpha = 1;
    
}
- (void)requestData{
    
    self.mkPageIndex = 1;
    [self requestWith:0 WithPageNumber:1 WithPageSize:10 WithUserID:self.mkPernalModel.id WithType:@"1" Block:^(id data) {
        if ((Boolean)data) {
//            [self.collectionView reloadData];
             [self.mkCollectionView reloadData];
        }else{
            
        }
    }];
}
#pragma mark - 下拉刷新
-(void)pullToRefresh{
    NSLog(@"下拉刷新");
    self.mkPageIndex = 1;
    [self.tableViewHeader endRefreshing];
    [self requestWith:0 WithPageNumber:1 WithPageSize:10 WithUserID:self.mkPernalModel.id WithType:@"1" Block:^(id data) {
        if ((Boolean)data) {
//            [self.collectionView reloadData];
            [self.mkCollectionView reloadData];
        }else{
            
        }
    }];
}
#pragma mark -  上拉加载更多
- (void)loadMoreRefresh{
    NSLog(@"上拉加载更多");
    [self.tableViewFooter endRefreshing];
    self.mkPageIndex += 1;
    [self requestWith:0 WithPageNumber:self.mkPageIndex WithPageSize:10 WithUserID:self.mkPernalModel.id WithType:@"1" Block:^(id data) {
        if ((Boolean)data) {
//            [self.collectionView reloadData];
            [self.mkCollectionView reloadData];
        }else{
            self.mkPageIndex -= 1;
        }
    }];
}
#pragma mark —— UICollectionViewDataSource
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView
//     numberOfItemsInSection:(NSInteger)section{
////    self.collectionView.mj_footer.hidden = self.shops.count == 0;
////    return self.shops.count;
//    return self.mkLikeModel.list.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
//                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VedioCell" forIndexPath:indexPath];
//    cell.mkVideoType = MKVideoType_Like;
//    MKVideoDemandModel *model = self.mkLikeModel.list[indexPath.item];
//    [cell richElementsInCellWithModel:model];
//    return cell;
//}
//
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
      WeakSelf
    [RecommendVC ComingFromVC:weakSelf comingStyle:ComingStyle_PUSH presentationStyle:UIModalPresentationFullScreen requestParams:@{@"index":@(indexPath.item),@"model":self.mkLikeModel,@"VideoListType":@(MKVideoListType_D)} success:^(id data) {

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
    [_collectionView registerClass:[UICollectionViewCell class]
           forCellWithReuseIdentifier:@"cellIdentifier"];
    //cellIdentifier
    //注册区头
//    [_collectionView registerClass:[HQTopStopView class]
//        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//               withReuseIdentifier:ReuseIdentifier];
    [self.view addSubview:_collectionView];
    return _collectionView;
}

- (MKPersonalLikeModel *)mkLikeModel{
    
    if (!_mkLikeModel) {
        
        _mkLikeModel = [[MKPersonalLikeModel alloc] init];
    }
    
    return _mkLikeModel;
}
- (MKPersonalnfoModel *)mkPernalModel{
    
    if (!_mkPernalModel) {
        
        _mkPernalModel = [[MKPersonalnfoModel alloc]init];
    }
    return _mkPernalModel;
}



#pragma mark -
- (UICollectionView *)mkCollectionView{
    
    if (!_mkCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 2.5;
        layout.sectionInset = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0);
        _mkCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50*KDeviceScale,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height- 50*KDeviceScale) collectionViewLayout:layout];
      
//        [_myCollectionView registerNib:[UINib nibWithNibName:@"CT_MyCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CT_MyCollectionReusableView"];
        //    [_myCollectionView registerClass:[CT_MyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CT_MyCollectionReusableView"];
//        [_myCollectionView registerNib:[UINib nibWithNibName:@"CT_MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"myCollectionViewCell"];
        [_mkCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        _mkCollectionView.dataSource = self;
        _mkCollectionView.delegate = self;
        [_mkCollectionView registerClass:[VideoCell class]
               forCellWithReuseIdentifier:@"VedioCell"];
        _mkCollectionView.mj_header = self.tableViewHeader;
        _mkCollectionView.mj_footer = self.tableViewFooter;
        _mkCollectionView.mj_footer.hidden = NO;
        [self.view addSubview:_mkCollectionView];
        [_mkCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(KDeviceScale *50);
        }];
    }
    return _mkCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return self.mkLikeModel.list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VedioCell" forIndexPath:indexPath];
    cell.mkVideoType = MKVideoType_Like;
    MKVideoDemandModel *model = self.mkLikeModel.list[indexPath.item];
    [cell richElementsInCellWithModel:model];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (([UIScreen mainScreen].bounds.size.width-15)/2);
    CGSize size = CGSizeMake(width, width);
    return size;
}



@end
