//
//  LikeVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "LikeVC.h"
#import "LikeVC+VM.h"
#import "RecommendVC.h"
@interface LikeVC ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
LMHWaterFallLayoutDeleaget
>

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)FSCustomButton *recordYourLoveBtn;
@property(nonatomic,strong)UILabel *tipsLab;

@property(nonatomic,assign)NSUInteger columnCount;
@property(nonatomic,strong)LMHWaterFallLayout *waterFallLayout;
@end

@implementation LikeVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    LikeVC *vc = LikeVC.new;
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

-(void)viewDidLoad{
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = HEXCOLOR(0x242A37);
    self.navigationController.navigationBar.hidden = YES;
    self.recordYourLoveBtn.alpha = 1;
    self.tipsLab.alpha = 1;
    WeakSelf
   
    
    [self requestData:^(id data) {
        
    }];
}
- (void)requestData:(MKDataBlock)block{
      WeakSelf
    if([MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:NO]){
        
    }else{
        return;
    }
    
    [self requestWith:0 WithPageNumber:1 WithPageSize:4 WithUserID:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid WithType:@"1" Block:^(id data) {
        if ((Boolean)data) {
            if (weakSelf.mkLikeModel.list.count == 0) {
                weakSelf.tipsLab.hidden = NO;
                weakSelf.recordYourLoveBtn.hidden = NO;
                block(@(YES));
            }else{
               [weakSelf.view addSubview:self.collectionView];
               [weakSelf.collectionView reloadData];
                weakSelf.tipsLab.hidden = YES;
                weakSelf.recordYourLoveBtn.hidden = YES;
                block(@(NO));
                
            }
        }else{
            
        }
    }];
}
-(void)recordYourLoveBtnClickEvent:(UIButton *)sender{
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    if(self.mkLikeModel.list.count > 3){
        
      return 3;
        
    }else{
        
      return self.mkLikeModel.list.count;
        
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VedioCellL" forIndexPath:indexPath];
    
    cell.mkVideoType = MKVideoType_MyLike;
    
    MKVideoDemandModel *model = self.mkLikeModel.list[indexPath.item];
    
    [cell richElementsInCellWithModel:model];

    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
//    if (self.mkLikeVCDelegate && [self.mkLikeVCDelegate respondsToSelector:@selector(didClickLikeVC:currentPlayerIndex:)]) {
//        
//        [self.mkLikeVCDelegate didClickLikeVC:@{@"index":@(indexPath.item),@"model":self.mkLikeModel,@"VideoListType":@(MKVideoListType_D)}.mutableCopy  currentPlayerIndex:0];
//        
//    }
    
    
//    WeakSelf
    StrongSelf
    UINavigationController *nvc  =[[UINavigationController alloc]initWithRootViewController:strongSelf];
    [RecommendVC ComingFromVC:nvc comingStyle:ComingStyle_PUSH presentationStyle:UIModalPresentationFullScreen requestParams:@{@"index":@(indexPath.item),@"model":self.mkLikeModel,@"VideoListType":@(MKVideoListType_D)} success:^(id data) {
        
    } animated:YES];
}

#pragma mark —— LMHWaterFallLayoutDeleaget
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout
  heightForItemAtIndexPath:(NSUInteger)indexPath
                 itemWidth:(CGFloat)itemWidth{
    return 67 *KDeviceScale;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return SCALING_RATIO(20);
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    return SCALING_RATIO(3);
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
                                                                             0,
                                                                             SCREEN_WIDTH,
                                                                             SCREEN_HEIGHT)
                                                 collectionViewLayout:self.waterFallLayout];
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    _collectionView.mj_header = self.tableViewHeader;
//    _collectionView.mj_footer = self.tableViewFooter;
    _collectionView.mj_footer.hidden = NO;
    [_collectionView setBackgroundColor:kClearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.bounces = NO;
    [_collectionView registerClass:[VideoCell class]
        forCellWithReuseIdentifier:@"VedioCellL"];
    //注册区头
   
    return _collectionView;
}
#pragma mark —— lazyLoad
-(FSCustomButton *)recordYourLoveBtn{
    if (!_recordYourLoveBtn) {
        _recordYourLoveBtn = FSCustomButton.new;
        _recordYourLoveBtn.buttonImagePosition = FSCustomButtonImagePositionLeft;
        _recordYourLoveBtn.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                              SCALING_RATIO(10),
                                                              0,
                                                              0);
        _recordYourLoveBtn.backgroundColor = kGrayColor;
        _recordYourLoveBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica"
                                                             size:11];
        [_recordYourLoveBtn setImage:KIMG(@"获赞")
                          forState:UIControlStateNormal];
        [_recordYourLoveBtn setTitle:@"记录你的喜欢"
                          forState:UIControlStateNormal];//
        [_recordYourLoveBtn addTarget:self
                             action:@selector(recordYourLoveBtnClickEvent:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_recordYourLoveBtn];
        [_recordYourLoveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(SCALING_RATIO(10));
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(169), SCALING_RATIO(40)));
        }];
        [UIView cornerCutToCircleWithView:_recordYourLoveBtn
                                  AndCornerRadius:SCALING_RATIO(40 / 4)];
    }return _recordYourLoveBtn;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.text = @"点赞的视频都在这里";
        _tipsLab.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                             size:11];
        _tipsLab.textColor = kWhiteColor;
        [self.view addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.recordYourLoveBtn.mas_bottom).offset(SCALING_RATIO(7));
            make.centerX.equalTo(self.view);
        }];
    }return _tipsLab;
}

- (MKPersonalLikeModel *)mkLikeModel{
    
    if (!_mkLikeModel) {
        
        _mkLikeModel = [[MKPersonalLikeModel alloc] init];
    }
    
    return _mkLikeModel;
}

@end
