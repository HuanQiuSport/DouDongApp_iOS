//
//  MKSingUserCenterDetailVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSingUserCenterDetailVC.h"
#import "RecommendVC.h"
#import "MKPersonalnfoModel.h"
#import "MKPersonalLikeModel.h"
#import "MKVideoDemandModel.h"
#import "MKSingUserCenterDetailVC+NET.h"
#import "NSObject+Login.h"

@interface MKSingUserCenterDetailVC ()<UICollectionViewDataSource,UICollectionViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    NSString *video_id;
}
/// 新的View
@property (strong,nonatomic) UICollectionView *mkCollectionView;


@property (assign,nonatomic) NSInteger mkPageIndex;

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@property (nonatomic, strong) UILabel *noDataLab;
@property (nonatomic, strong) UILabel *noDataLab1;
@end

@implementation MKSingUserCenterDetailVC
@synthesize type;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.mkCollectionView.alpha = 1;
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = kBlackColor;
    self.navigationController.navigationBar.hidden = YES;
    [self requestData];
    [self.mkCollectionView addSubview:self.noDataLab];
    [self.noDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(MAINSCREEN_WIDTH);
        make.left.offset(0);
        make.height.offset(30);
        make.top.offset(40);
    }];
    self.noDataLab.hidden = ![MKTools mkLoginIsLogin];
    [self addNotifaction];
//
//    /// 2 ： 作品 ｜  1 ： 喜欢
//    @property (strong,nonatomic) NSString *type;
//    /// 1  ： 我   ｜  2 ：其他用户
//    @property (strong,nonatomic) NSString *type2;
    // 1. wo    1 喜欢
    // 2. 其他   2.作品
    if([self.type2 isEqualToString:self.type ]){
        if([self.type2 isEqualToString:@"1"]){ // 我的 喜欢
            _noDataLab.text = @"快来将我填满吧";
        }else{ // 其他 作品
            _noDataLab.text = @"TA还未发布作品";
        }
    }else{
        if([self.type2 isEqualToString:@"1"]){ // 我的 作品
            _noDataLab.text = @"快来将我填满吧";
        }else{ // 其他 喜欢
            _noDataLab.text = @"TA还未收藏作品";
        }
    }
    [self refreshSkin];
}

-(void)refreshSkin {
    if([SkinManager manager].skin == MKSkinWhite) {
        self.view.backgroundColor = UIColor.whiteColor;
        self.mkCollectionView.backgroundColor = UIColor.whiteColor;
        self.mkCollectionView.tintColor =  UIColor.whiteColor;
        self.noDataLab.textColor = HEXCOLOR(0x999999);
    } else {
        self.view.backgroundColor = kBlackColor;
        self.noDataLab.textColor = RGBCOLOR(131, 145, 175);
        self.mkCollectionView.backgroundColor = kBlackColor;
        self.mkCollectionView.tintColor =  kBlackColor;
    }
}

- (void)addNotifaction {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:KLoginOutNotifaction object:nil];
}
- (void)logout {
    self.noDataLab.hidden = 0;
    if (self.mkLikeModel.list.count) {
        [self.mkLikeModel.list removeAllObjects];
        [self.mkCollectionView reloadData];
    }
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
        layout.minimumInteritemSpacing = 5;
        layout.sectionInset = UIEdgeInsetsMake(5.0, 5, 5.0, 10.0);
        _mkCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT-20*1) collectionViewLayout:layout];
        _mkCollectionView.backgroundColor = kBlackColor;
        _mkCollectionView.tintColor =  kBlackColor;
        _mkCollectionView.dataSource = self;
        _mkCollectionView.delegate = self;
        [_mkCollectionView registerClass:[VideoCell class]
               forCellWithReuseIdentifier:@"VedioCell"];
        _mkCollectionView.mj_header = [self mjRefreshGifHeader];
        _mkCollectionView.mj_header.hidden = 1;
        _mkCollectionView.mj_footer = [self mjRefreshAutoGifFooter];
        _mkCollectionView.mj_footer.hidden = 1;
        _mkCollectionView.emptyDataSetSource = self;
        _mkCollectionView.emptyDataSetDelegate = self;
        [self.view addSubview:_mkCollectionView];
        [_mkCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view.mas_top).offset(20*1);
            make.bottom.equalTo(self.view).offset(-72*1);
        }];
    }
    return _mkCollectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    _mkCollectionView.mj_footer.alpha =  self.mkLikeModel.list.count;
    if (![[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid isEqualToString:self.mkPernalModel.userId]) {
        return self.mkLikeModel.list.count;
    } else {
        if (![MKTools mkLoginIsLogin]) {
            return self.mkLikeModel.list.count;
        } else {
            return 0;
        }
    }
   
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VedioCell" forIndexPath:indexPath];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 6;
    if ([self.type isEqualToString:@"1"]) {
        
        cell.mkVideoType = MKVideoType_Like;
        
    }
    if ([self.type isEqualToString:@"2"]) {
       cell.mkVideoType = MKVideoType_MadeInMe;
    }
    MKVideoDemandModel *model = self.mkLikeModel.list[indexPath.item];
    [cell richElementsInCellWithModel:model];
    cell.backgroundColor = kBlackColor;
    return cell;
}
#pragma mark - 调整cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (([UIScreen mainScreen].bounds.size.width-40)/3);
    CGSize size = CGSizeMake(width, 139*1);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%s", __FUNCTION__);
    MKVideoDemandModel *model = self.mkLikeModel.list[indexPath.item];
    /*
     if (self.mkVideoModel.videoStatus.integerValue == 0) {
         //待审核
         self.mkVideoOfReviewType = MKVideoOfReviewType_review;
     } else if (self.mkVideoModel.videoStatus.integerValue == 1) {
         //审核通过
         self.mkVideoOfReviewType = MKVideoOfReviewType_success;
     } else if (self.mkVideoModel.videoStatus.integerValue == 2) {
         //审核不通过
         self.mkVideoOfReviewType = MKVideoOfReviewType_fail;
     }
     */
    
    video_id = model.videoId;
    if ([self.type isEqualToString:@"1"]) {
        NSString *page = [NSString stringWithFormat:@"%ld",self.mkPageIndex];
        SetUserDefaultKeyWithObject(@"needrequestData",page);
        [UIViewController comingFromVC:self
                                  toVC:RecommendVC.new
                           comingStyle:ComingStyle_PUSH
                     presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                         requestParams:@{
                             @"index":@(indexPath.item),
                             @"model":self.mkLikeModel,@"VideoListType":@(MKVideoListType_D),
                             @"userId":self.mkPernalModel.userId,
                             @"type":self.type}// 自定义类型用来区分 喜欢｜作品
              hidesBottomBarWhenPushed:YES
                              animated:YES
                               success:^(id data) {}];
        
    }
    if ([self.type isEqualToString:@"2"]) {
        switch (model.videoStatus.integerValue) {
            case 0:
            {
                [NSObject showSYSAlertViewTitle:@"提示"
                                        message:@"审核通过后可查看，是否删除？"
                                isSeparateStyle:NO
                                    btnTitleArr:@[@"取消",@"删除"]
                                 alertBtnAction:@[@"",@"deleteVideo"]
                                       targetVC:self
                                   alertVCBlock:^(id data) {
                    //DIY
                }];
            }
                break;
            case 1:
            {

                NSString *page = [NSString stringWithFormat:@"%ld",self.mkPageIndex];
                SetUserDefaultKeyWithObject(@"needrequestData",page);
                [UIViewController comingFromVC:self
                                          toVC:RecommendVC.new
                                   comingStyle:ComingStyle_PUSH
                             presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                                 requestParams:@{@"index":@(indexPath.item),
                                                 @"model":self.mkLikeModel,
                                                 @"VideoListType":@(MKVideoListType_D),
                                                 @"userId":self.mkPernalModel.userId,
                                                 @"type":self.type, // 自定义类型用来区分 喜欢｜作品
                                                 @"userHeardNoClick":@(YES)}
                      hidesBottomBarWhenPushed:YES
                                      animated:YES
                                       success:^(id data) {}];
            }
                break;
            case 2:
            {
                [NSObject showSYSAlertViewTitle:@"提示"
                                        message:@"视频未通过，是否删除?"
                                isSeparateStyle:NO
                                    btnTitleArr:@[@"取消",@"删除"]
                                 alertBtnAction:@[@"",@"deleteVideo"]
                                       targetVC:self
                                   alertVCBlock:^(id data) {
                    //DIY
                }];
            }
                break;
            default:
                break;
        }
    }
}
- (void)deleteVideo
{
    if (video_id != nil) {
        [self MKDelAppVideo_POST_ViedoID:video_id];
    }
    video_id = nil;

}
- (void)requestData{
    if([SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex == 4){
        if (![MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid){
            self.noDataLab.hidden = 0;
            return;
        }
    }
//    if (self.mkPageIndex == 0 || self.mkPageIndex == 1)
//    {
//        self.mkPageIndex = 1;
//    }
//    self.mkPageIndex = 1;
    NSString *dataStr = GetUserDefaultObjForKey(@"needrequestData");
//    NSLog(@"%@",dataStr);
    if ([dataStr isEqualToString:@"yes"]) {
        self.mkPageIndex = 1;
    }
    else
    {
        if (dataStr > 0) {
            self.mkPageIndex = [dataStr integerValue];
        } else {
            self.mkPageIndex = 1;
        }
        
    }
    SetUserDefaultKeyWithObject(@"needrequestData",@"yes");
    WeakSelf
    [self requestWith:0 WithPageNumber:self.mkPageIndex WithPageSize:10 WithUserID:weakSelf.mkPernalModel.userId WithType:self.type Block:^(id data) {
        if ((Boolean)data) {
            [self.mkCollectionView reloadData];
            weakSelf.noDataLab.hidden = self.mkLikeModel.list.count;
        }else{
        }
    }];
}
- (void)refrushData
{
//    NSLog(@"下拉刷新");
    self.mkPageIndex = 1;
    [[self mjRefreshAutoGifFooter] endRefreshing];
    WeakSelf
    [self requestWith:0 WithPageNumber:1 WithPageSize:10 WithUserID:weakSelf.mkPernalModel.userId WithType:weakSelf.type Block:^(id data) {
        [weakSelf.mjRefreshGifHeader endRefreshing];
        if ((Boolean)data) {
          
            [weakSelf.mkCollectionView reloadData];
            
        }else{
            
        }
    }];
}
#pragma mark - 下拉刷新
-(void)pullToRefresh{
//    NSLog(@"下拉刷新");
    self.mkPageIndex = 1;
    [[self mjRefreshAutoGifFooter] endRefreshing];
    WeakSelf
    [self requestWith:0 WithPageNumber:1 WithPageSize:10 WithUserID:weakSelf.mkPernalModel.userId WithType:weakSelf.type Block:^(id data) {
        [weakSelf.mjRefreshGifHeader endRefreshing];
        if ((Boolean)data) {
          
            [weakSelf.mkCollectionView reloadData];
            
        }else{
            
        }
    }];
}
#pragma mark -  上拉加载更多
- (void)loadMoreRefresh{
//    NSLog(@"上拉加载更多");
    [[self mjRefreshGifHeader] endRefreshing];
    self.mkPageIndex += 1;
    WeakSelf
    [self requestWith:0 WithPageNumber:weakSelf.mkPageIndex WithPageSize:10 WithUserID:weakSelf.mkPernalModel.userId WithType:weakSelf.type Block:^(id data) {
        [weakSelf.mjRefreshAutoGifFooter endRefreshing];
        if ((Boolean)data) {
            [weakSelf.mkCollectionView reloadData];
        }else{
            weakSelf.mkPageIndex -= 1;
        }
    }];
}
- (UIScrollView *)listScrollView {
     return self.mkCollectionView;
}

- (UIView *)listView {
    return self.view;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
     self.scrollCallback = callback;
}
#pragma mark -  空数据delegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"av"];
}
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
////    NSString *text = @"暂时没有更多数据";
//    NSString *text = @"";
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular],
//                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
//                                 NSParagraphStyleAttributeName: paragraphStyle};
//    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//}

- (UILabel *)noDataLab {
    if (!_noDataLab) {
        _noDataLab = UILabel.new;

        _noDataLab.textColor = RGBCOLOR(131, 145, 175);
        _noDataLab.font = [UIFont systemFontOfSize:16];
        _noDataLab.textAlignment = NSTextAlignmentCenter;
    }
    return _noDataLab;
}

-(NSMutableSet *)videidsSet {
    if(_videidsSet == nil) {
        _videidsSet = [[NSMutableSet alloc] init];
    }
    return  _videidsSet;
}

@end
