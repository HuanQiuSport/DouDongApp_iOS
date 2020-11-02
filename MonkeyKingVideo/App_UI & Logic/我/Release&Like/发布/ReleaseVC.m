//
//  ReleaseVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/30.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "ReleaseVC.h"
#import "ReleaseVC+VM.h"
@interface ReleaseVC ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
LMHWaterFallLayoutDeleaget
>

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)FSCustomButton *releaseVedioBtn;
@property(nonatomic,strong)UILabel *tipsLab;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)NSUInteger columnCount;
@property(nonatomic,strong)LMHWaterFallLayout *waterFallLayout;
@end

@implementation ReleaseVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    ReleaseVC *vc = ReleaseVC.new;
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
    self.releaseVedioBtn.alpha = 1;
    self.tipsLab.alpha = 1;
    WeakSelf
    if ([MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:YES]) {
        
    }else{
        return;
    }
    
    [self requestWith:0 WithPageNumber:0 WithPageSize:4 WithUserID:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid WithType:@"2" Block:^(id data) {
        if ((Boolean)data) {
            
            if (weakSelf.mkMadeModel.list.count == 0) {
                
                weakSelf.tipsLab.hidden = NO;
                
                weakSelf.releaseVedioBtn.hidden = NO;
                
            }else{
                
                [weakSelf.view addSubview:self.collectionView];
                
                [weakSelf.collectionView reloadData];
                
                weakSelf.tipsLab.hidden = YES;
                
                weakSelf.releaseVedioBtn.hidden = YES;
                
            }
        }else{
            
        }
    }];
}

-(void)releaseVedioBtnClickEvent:(UIButton *)sender{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MKRecordStartNotification object:nil];
    
}
#pragma mark —— lazyLoadx
-(FSCustomButton *)releaseVedioBtn{
    if (!_releaseVedioBtn) {
        _releaseVedioBtn = FSCustomButton.new;
        _releaseVedioBtn.buttonImagePosition = FSCustomButtonImagePositionLeft;
        _releaseVedioBtn.titleEdgeInsets = UIEdgeInsetsMake(0,
                                                            SCALING_RATIO(10),
                                                            0,
                                                            0);
        [_releaseVedioBtn setBackgroundImage:KIMG(@"矩形")
                                    forState:UIControlStateNormal];
        [_releaseVedioBtn setImage:KIMG(@"发布影视")
                          forState:UIControlStateNormal];
        _releaseVedioBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica"
                                                           size:11];
        [_releaseVedioBtn setTitle:@"发布影片"
                          forState:UIControlStateNormal];
        [_releaseVedioBtn addTarget:self
                             action:@selector(releaseVedioBtnClickEvent:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_releaseVedioBtn];
        [_releaseVedioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(SCALING_RATIO(10));
            make.size.mas_equalTo(CGSizeMake(SCALING_RATIO(169), SCALING_RATIO(40)));
        }];
        [UIView cornerCutToCircleWithView:_releaseVedioBtn
                            AndCornerRadius:SCALING_RATIO(40 / 4)];
    }return _releaseVedioBtn;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.text = @"发布你的第一个视频";
        _tipsLab.textColor = kWhiteColor;
        _tipsLab.font = [UIFont fontWithName:@"PingFangSC-Regular"
                                        size:11];
        [self.view addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.releaseVedioBtn.mas_bottom).offset(SCALING_RATIO(7));
            make.centerX.equalTo(self.view);
        }];
    }return _tipsLab;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    
    if(self.mkMadeModel.list.count > 3){
        
      return 3;
        
    }else{
        
      return self.mkMadeModel.list.count;
        
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VedioCellR"
                                                                forIndexPath:indexPath];
    cell.mkVideoType = MKVideoType_MyMadeByMe;
    MKVideoDemandModel *model = self.mkMadeModel.list[indexPath.item];
    [cell richElementsInCellWithModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    
    
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
    _collectionView.mj_header = self.tableViewHeader;
    _collectionView.mj_footer = self.tableViewFooter;
    _collectionView.mj_footer.hidden = NO;
    [_collectionView setBackgroundColor:kClearColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.bounces = NO;
    [_collectionView registerClass:[VideoCell class]
        forCellWithReuseIdentifier:@"VedioCellR"];
    //注册区头
   
    return _collectionView;
}
@end
