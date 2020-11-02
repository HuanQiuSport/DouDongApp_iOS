//
//  RecommendVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/23.
//  Copyright © 2020 Jobs. All rights reserved.
//
#define CommentHeight SCREEN_HEIGHT * 508 / (508 + 159)
#import "RecommendVC+Private.h"
#import "RecommendVC.h"
#import "MKPlayVideoView.h"
#import "MKVideoPlayDelegate.h"
#import "CommentPopUpVC.h"

#import "MKCPlayVideoView.h"
#import "MKVideoInfoModel.h"
#import "MKVideoDemandModel.h"

#import "RecommendVC+VM.h"
#import "GKDoubleLikeView.h"
#import "MKAttentionModel.h"
#import "MKAdVC.h"
#import "MKPersonalLikeModel.h"
#import "MKPersonMadeVideoModel.h"
#import "MKPersonalLikeModel.h"
#import "MKDiamondsView.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"


@interface RecommendVC()<UITableViewDelegate,UITableViewDataSource,MKDouYinDelegate>
@end
@implementation RecommendVC
- (void)dealloc {

//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);

    [self removeNotification];
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    RecommendVC *vc = RecommendVC.new;
    vc.successBlock = block;
     vc.requestParams = requestParams;
    if (requestParams == nil) {
    }else{
        vc.mkIndex = [requestParams[@"index"] integerValue];
        vc.index = [requestParams[@"index"] integerValue];
        vc.mkVideoListType = [requestParams[@"VideoListType"] intValue];
        vc.userHeardNoClick = requestParams[@"userHeardNoClick"];
        if (vc.mkVideoListType == MKVideoListType_A) {
        }else{
            vc.page = vc.index/10;
        }
    }
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
//            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

#pragma mark - Lifecycle

-(instancetype)init{
    if (self = [super init]) {
        self.isCommentPopUpVCOpen = NO;
        self.liftingHeight = kScreenHeight - CommentHeight;
        self.CommentPopUpVC_Y = 0.0;
        self.CommentPopUpVC_EditY = 0.0f;
        self.isBackFromPopAdVC = NO;

    }return self;
}
- (void)videoPlayerPlayEnd:(ZFPlayerController *)videoPlayer {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.gk_navigationBar.hidden = YES;
    self.gk_statusBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    if (self.mkVideoListType == MKVideoListType_A) {
        self.isRecommend = YES;
    }
    self.gk_navLeftBarButtonItem =  self.returnBtnItem;
    //ZFPlayer
    [self.view addSubview:self.tableView];
    [self initPlayer];
    
    
    [self activeStart];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addNotification]; // 添加播放器所需通知中心
    if(![MKTools mkLoginIsLogin]){
        [self goldNumSwitch];
    }
    if (_mkShuaCoinView && _mkShuaCoinView.hidden == NO) {
        // reset
        [self.mkShuaCoinView cotinueAddCoin];
    }
    [self mkSetNavi]; // 设置导航栏
    [self keyboard];
    [self isHomeVCInRecommendVC];
    #pragma mark - 去掉重新计时
    [self recoderStartPlay:nil WithTime:0];
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = self.isCommentPopUpVCOpen;
    [self.view addSubview:_commentPopUpVC.view];
    self.player.viewControllerDisappear = NO;
    if (self.mkVideoListType == MKVideoListType_A) {
        
        // 首页加载视频的关键 这代码是重新加载请求
        [self.player zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
            [self playTheVideoAtIndexPath:indexPath];
        }];
        if ([MKTools mkArrayEmpty:self.tableView.visibleCells.mutableCopy]) {
            return;
        }
         dispatch_async(dispatch_get_main_queue(), ^{
            MKDouYinCell *cell =  self.tableView.visibleCells.firstObject;
            cell.model = self.mkRecommend.list[cell.mkCellIndex.row];
         });
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self sendNavibarToFront];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = 1;
    
    self.player.viewControllerDisappear = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.mkDiamondsView stopAddDiamond];
    [self.mkShuaCoinView stopAddCoin];
//    [self removeNotification]; // 避免重复通知
//    [self addDidDisappearNotification]; // 由于删除了所有通知，所以要另外开启的通知
}


#pragma mark - player
- (void)initPlayer {
    if (self.mkVideoListType == MKVideoListType_A) {
        self.page = 1;
    }
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    self.player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:kPlayerView];
//    self.player.disableGestureTypes =  ZFPlayerDisableGestureTypesPinch;
//    self.player.disablePanMovingDirection = ZFPlayerDisablePanMovingDirectionHorizontal;
    self.player.disableGestureTypes = ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
    if (self.mkVideoListType == MKVideoListType_A) {

    }else{
        [self.controlView updateLayout];
    }
    self.player.controlView = self.controlView;
    self.player.allowOrentitaionRotation = NO;
    self.player.WWANAutoPlay = YES;
    [self.player setShouldAutoPlay:YES];
    /// 1.0是完全消失时候
    self.player.playerDisapperaPercent = 1.0;
    
//    @weakify(self)
    __weak typeof(self) weakSelf = self;
    weakSelf.player.playerPlayStateChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, ZFPlayerPlaybackState playState) {
//        @strongify(self)
        NSLog(@"触发---%lu",(unsigned long)playState);
        if (weakSelf.mkVideoListType == MKVideoListType_A) {
            ZFAVPlayerManager*manager = (ZFAVPlayerManager *)asset;
            MKVideoDemandModel * model=  MKVideoDemandModel.new;
            for (MKVideoDemandModel *temp in weakSelf.mkRecommend.list) {
                if ([temp.videoIdcUrl isEqualToString:manager.assetURL.absoluteString]) {
                    model = temp;
                }
            }
            switch (playState) {
                    
                case ZFPlayerPlayStateUnknown:
                    NSLog(@"视频未知");
                    break;
                case ZFPlayerPlayStatePlaying:{
                    NSLog(@"视频开始");
                    self.controlView.playBtn.hidden = YES;
                    if([SceneDelegate sharedInstance].customSYSUITabBarController.selectedIndex == 4){
                        [weakSelf.player.currentPlayerManager pause];
                    }
                    // 看了3个视频并且没登录就弹出登录
                    if(weakSelf.index > 3 && [MKTools mkLoginIsLogin]){
                          if (weakSelf.mkVideoListType == MKVideoListType_A) {
                              [weakSelf mkLoginAlert];

                          }

//                        if ([MKTools mkLoginIsLogin]) {
//                            if (weakSelf.index > 4) {
//                                [weakSelf gotoAD2];
//                            }else{
//                                if (weakSelf.mkVideoListType == MKVideoListType_A) {
//                                    [weakSelf mkLoginAlert];
//
//                                }
//                            }
//                        }
                    }
                    // 看了5个视频并且登录就弹出广告
                    if (![MKTools mkLoginIsLogin] && weakSelf.index > 10) {
//                         [weakSelf gotoAD2];
                    }
                    // 登录并统计视频观看时间
//                    if (![MKTools mkLoginIsLogin]) {
//                        [self.m_playRecordArray addObject:model];
//                    }
                }break;
                case ZFPlayerPlayStatePaused:
                    if(weakSelf.index > 3 && [MKTools mkLoginIsLogin]){return;}
                    
                    [weakSelf recoderEndPlay:model WithTime:manager.currentTime];
                    break;
                case ZFPlayerPlayStatePlayFailed:
                    NSLog(@"视频错误");
                    break;
                case ZFPlayerPlayStatePlayStopped:
                    NSLog(@"视频停止");
                    break;
            }
        }else{
            
        }
    };
    weakSelf.player.playerLoadStateChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, ZFPlayerLoadState loadState) {
        NSLog(@"加载情况 %ld",loadState);
    };
    weakSelf.player.playerReadyToPlay =  ^(id  _Nonnull asset,NSURL *_Nonnull assetUR){
//        @strongify(self)
        if(weakSelf.mkVideoListType == MKVideoListType_A){
            weakSelf.mkFirstPlay = YES;
            
            ZFAVPlayerManager*manager = (ZFAVPlayerManager *)asset;
            MKVideoDemandModel * model=  MKVideoDemandModel.new;
            for (MKVideoDemandModel *temp in weakSelf.mkRecommend.list) {
                if ([temp.videoIdcUrl isEqualToString:manager.assetURL.absoluteString]) {
                    model = temp;
                }
            }
            [weakSelf.player.currentPlayerManager play]; // 自动播放关键
            
            if([MKTools mkLoginIsLogin]){
                [weakSelf recoderEndPlay:model WithTime:manager.bufferTime];
            }else{
                [weakSelf recoderStartPlay:model WithTime:manager.totalTime];
            }
        }else{
            [weakSelf.player.currentPlayerManager play];
        }
    };
    weakSelf.player.playerDidToEnd = ^(id  _Nonnull asset) {
//        @strongify(self)
        if (weakSelf.mkVideoListType == MKVideoListType_A) {
            weakSelf.mkFirstPlay = NO;
            ZFAVPlayerManager*manager = (ZFAVPlayerManager *)asset;
            MKVideoDemandModel * model=  MKVideoDemandModel.new;
            for (MKVideoDemandModel *temp in self.mkRecommend.list) {
                if ([temp.videoIdcUrl isEqualToString:manager.assetURL.absoluteString]) {
                    model = temp;
                }
            }
            if([MKTools mkLoginIsLogin]){
                [weakSelf recoderEndPlay:model WithTime:manager.bufferTime];
            }else{
                [weakSelf recoderEndPlay:model WithTime:manager.bufferTime];
            }
        }else{
            [weakSelf.player.currentPlayerManager replay];
        }
        [weakSelf.player.currentPlayerManager replay];
    };
    /// 停止的时候找出最合适的播放
    self.player.zf_scrollViewDidEndScrollingCallback = ^(NSIndexPath * _Nonnull indexPath) {
//        @strongify(self)
        if (self.player.playingIndexPath) return;
        if (indexPath.row == self.mkRecommend.list.count - 1) {
            /// 加载下一页数据
            self.page++;
            [self requestData:NO];
        }
        [self playTheVideoAtIndexPath:indexPath];
    };
    [self  listRequestData];
    if (self.mkVideoListType == MKVideoListType_A) {
//            weakSelf.controlView.playerLoadStateChangedBlock = ^(NSString * _Nonnull str) {
//            NSLog(@"view回调 %@",str);
//            if(![MKTools mkLoginIsLogin]){
//                
//                if ([str isEqualToString:@"YES"]) {
//                    // 完成后时红包走
//                    if (self.mkFirstPlay == YES) {
//                        [weakSelf.mkShuaCoinView cotinueAddCoin];
//                    }
//                } else {
//                    // 缓冲时红包不走
//                    [weakSelf.mkShuaCoinView stopAddCoin];
//                }
//            }
//        };
    }

}

#pragma mark  -cell 点击代理事件 cellDelegate
- (void)cellAction:(MKVideoDemandModel *)model type:(DouYinCellActionType)actionType view:(UIView *)view withIndexPath:(nonnull NSIndexPath *)indexPath{
    
    #pragma mark - 点赞
    if (actionType == type_support) {
        [self requestZanWith:model.videoId WithPraise:model.isPraise WithBlock:^(id data, id data2) {
            MKRightBtnView *btnView = (MKRightBtnView *)view;
            btnView.mkZanView.mkButton.selected = !btnView.mkZanView.mkButton.selected;
            if((Boolean)data){
                if ([data2 isEqual:@"1"] ) {
                    
                    return;
                }else{
                    model.praiseNum = [(NSNumber*)(((NSDictionary *)data2)[@"praiseNum"]) stringValue];
                    btnView.mkZanView.mkTitleLable.text = model.praiseNum;
                    if (!btnView.mkZanView.mkButton.selected) {
                        [MKTools mkHanderDeleteLikeVideoOfCurrentLoginWithVideoId:model.videoId.mutableCopy WithBool:NO WithNumber:[model.praiseNum integerValue]];
                    }else{
                        [MKTools mkHanderInsertLikeVideoOfCurrentLoginWithVideoId:model.videoId.mutableCopy WithBool:YES WithNumber:[model.praiseNum integerValue]];
                    }
                }
            }else{
                [MBProgressHUD wj_showError:[model.isPraise  isEqualToString:@"0"] ? @"点赞失败稍后再试":@"取消点赞失败，稍后再试"];
                if ([model.isPraise isEqualToString:@"1"]) { // 已经点赞，取消点赞,撤回取消点赞操作
                    btnView.mkZanView.mkImageView.image = KIMG(@"喜欢-未点击");
                    btnView.mkZanView.mkButton.selected = NO;
                    [MKTools mkHanderDeleteLikeVideoOfCurrentLoginWithVideoId:model.videoId.mutableCopy WithBool:NO WithNumber:[model.praiseNum integerValue]];
                }else{ // 未点赞，去点赞，撤回点赞操作
                    btnView.mkZanView.mkImageView.image = KIMG(@"喜欢-点击");
                    model.isPraise = @"1";
                    btnView.mkZanView.mkButton.selected = YES;
                    [MKTools mkHanderInsertLikeVideoOfCurrentLoginWithVideoId:model.videoId.mutableCopy WithBool:YES WithNumber:[model.praiseNum integerValue]];
                }
            }
        }];
        #pragma mark - 评论
    } else if (actionType == type_comment) {
        WeakSelf
        if(![MKTools mkLoginIsYESWith:weakSelf]){
            return;
        }
        if ([model.mkCustomtype isEqualToString:@"1"]) {
                   return;
            }
            if (self.isCommentPopUpVCOpen) {//目前为开
                [self willClose_vertical];
            }else{
                [self willOpen];
            }
        #pragma mark - 分享
    } else if (actionType == type_share) {
        if ([model.mkCustomtype isEqualToString:@"1"]) {
            return;
        }else{
            [self MakeShareView];
        }
    }
    #pragma mark - 用户
    if (actionType == type_userInfo) {
              
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSString *uidString = [userDefault objectForKey:@"UID"];
        if(self.userHeardNoClick){
            return;
        }
        if ([model.authorId isEqualToString:uidString]) {
            return;
        } else {
//            MKSingeUserCenterVC *vc = [[MKSingeUserCenterVC alloc]init];
//            vc.requestParams = @{@"videoid":model.authorId};
//            [self.navigationController pushViewController:vc animated:YES];
            
            @weakify(self)
            MKSingeUserCenterVC *vc = [[MKSingeUserCenterVC alloc]init];
            vc.requestParams = @{@"videoid":model.authorId};
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([model.mkCustomtype isEqualToString:@"1"] || [model.areSelf isEqualToString:@"1"]) {
            if ([model.areSelf isEqualToString:@"1"]) {
            }
            return;
        }
    }
    #pragma mark - 关注
    if (actionType == type_focus) {
                 
        if ([model.mkCustomtype isEqualToString:@"1"] || [model.areSelf isEqualToString:@"1"]) {
            return;
        }
        @weakify(self)
        if ([MKTools mkLoginIsYESWith:weak_self WithiSNeedLogin:YES]) {
            
        }else{
            return;
        }
        UIButton *btn = (UIButton *)view;
        
        [self requestAttentionWith:model.authorId WithBlock:^(id data) {
            
            if ((Boolean)data) {
                if ([model.isAttention isEqualToString:@"0"]) {
                    model.isAttention = @"1";
                    btn.selected = YES;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        btn.hidden = YES;
                        btn.selected = NO;
                        [MKTools mkHanderInsertAttentionOfCurrentLoginWithUseId:model.authorId.mutableCopy WithBool:YES];
                        [MBProgressHUD wj_showPlainText:@"关注成功!" view:nil];
                    });
                }else{
                    model.isAttention = @"0";
                    btn.hidden = NO;
                    btn.selected = NO;
                }
            }else{
                model.isAttention = @"0";
                btn.hidden = NO;
                btn.selected = NO;
            }
        }];
        
       }
}
#pragma mark - 刷新
- (void)pullToRefresh {
    if (self.page > 2) {
        self.page -= 1;
    }
    [self requestData:YES];
}
#pragma mark - 加载
- (void)loadMoreRefresh{
    self.page += 1;
    [self requestData:YES];
}
- (void)requestData:(BOOL)first {
    @weakify(self)
    [self requestWith:0 WithPageNumber:self.page WithPageSize:10 Block:^(id data) {
        @strongify(self)
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ((Boolean)data) {
            [self.tableView reloadData];
            if (first) {
                [self playTheIndex:self.index];
            }
        }else{
            if (self.page >= 1) {
                self.page -= 1;
            }
        }
    }];
}
- (void)listRequestData{
    if (self.mkVideoListType == MKVideoListType_A) {
        [self requestData:YES];
    }else{
        
        switch (self.mkVideoListType) {
            case MKVideoListType_A:
            {
                
                
            }break;
            case MKVideoListType_B:
            {
                MKAttentionModel *tempModel = (MKAttentionModel *)self.requestParams[@"model"];
                @try {
                    self.mkRecommend.list = [NSMutableArray arrayWithArray:tempModel.list.copy];
                } @catch (NSException *exception) {
//                    NSLog(@"%s %@",__func__,exception.reason);
                } @finally {
                    
                }
                
                self.mkRecommend.list = [NSMutableArray arrayWithArray:tempModel.list.copy];
                
            }break;
            case MKVideoListType_C:
            {
                MKPersonMadeVideoModel *tempModel = (MKPersonMadeVideoModel *)self.requestParams[@"model"];
                @try {
                    self.mkRecommend.list = [NSMutableArray arrayWithArray:tempModel.list.copy];
                } @catch (NSException *exception) {
//                    NSLog(@"%s %@",__func__,exception.reason);
                } @finally {
                    
                }
                
            }break;
                
            case MKVideoListType_D:
            {
                MKPersonalLikeModel *tempModel = (MKPersonalLikeModel *)self.requestParams[@"model"];
                @try {
                    self.mkRecommend.list = [NSMutableArray arrayWithArray:tempModel.list.copy];
                } @catch (NSException *exception) {
//                    NSLog(@"%s %@",__func__,exception.reason);
                } @finally {}
                
            }break;
            default:
                break;
        }
        [self.tableView reloadData];
        [self playTheIndex:self.index];
    }
}
- (void)playTheIndex:(NSInteger)index {
    @weakify(self)
    /// 指定到某一行播放
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if(self.mkRecommend.list.count == 0){
        return;
    }
    
    if (self.mkVideoListType == MKVideoListType_A) {
        MKVideoDemandModel *model = self.mkRecommend.list[index];
        [MKPublickDataManager sharedPublicDataManage].currentVideoString = model.videoId.mutableCopy;
        [MKPublickDataManager sharedPublicDataManage].currentVideoUserString = model.authorId.mutableCopy;
        [self playTheVideoAtIndexPath:indexPath];
    }else{
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
        [self.player zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath *indexPath) {
            @strongify(self)
            [self playTheVideoAtIndexPath:indexPath];
        }];
    }
    /// 如果是最后一行，去请求新数据
    if (index == self.mkRecommend.list.count-1) {
        /// 加载下一页数据
        self.page ++;
        [self requestData:NO];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UIScrollViewDelegate  列表播放必须实现
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView zf_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScrollToTop];
 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewDidScroll];
//    [self.controlView.sliderView startAnimating];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [scrollView zf_scrollViewWillBeginDragging];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.mkRecommend.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKDouYinCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(MKDouYinCell.class)];
    cell.model = self.mkRecommend.list[indexPath.row];
    if (self.mkVideoListType == MKVideoListType_A) {
        cell.mkListType = MKVideoListType_A;
    } else {
        cell.mkListType = MKVideoListType_B;
    }
    cell.mkCellIndex = indexPath;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self playTheVideoAtIndexPath:indexPath];
}

#pragma mark - ZFTableViewCellDelegate

- (void)zf_playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [self playTheVideoAtIndexPath:indexPath];
}


/// play the video
- (void)playTheVideoAtIndexPath:(NSIndexPath *)indexPath {
    [self.controlView.sliderView  startAnimating];
    self.index = indexPath.row;
    MKVideoDemandModel *model = self.mkRecommend.list[indexPath.row];
    
    self.videoDemandModel = model;
    NSURL *url = [NSURL URLWithString:[model.videoIdcUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.player playTheIndexPath:indexPath assetURL:url];
    [self.controlView resetControlView];
    @weakify(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        [weak_self.controlView.sliderView startAnimating];
        if ([MKTools mkLoginIsLogin]) {
            @strongify(self)
            if (self.index > 3) {
                if (self.index > 4) {
//                        [self gotoAD2];
                }else{
                    if (self.mkVideoListType  == MKVideoListType_A) {
                        #pragma mark - 首页弹出登录窗
                        [self mkLoginAlert];
                    }
                }
            }
            if (self.index > 2 && self.mkVideoListType  == MKVideoListType_D) {
                [self mkLoginAlert];
            }
             
        }
        if (self.mkVideoListType == MKVideoListType_A) {
            [MKPublickDataManager sharedPublicDataManage].currentVideoString = model.videoId.mutableCopy;
            [MKPublickDataManager sharedPublicDataManage].currentVideoUserString = model.authorId.mutableCopy;
        }
    });
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.pagingEnabled = YES;
        [_tableView registerClass:[MKDouYinCell class] forCellReuseIdentifier:NSStringFromClass(MKDouYinCell.class)];
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.contentSize = CGSizeMake(0, SCREEN_H);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.scrollsToTop = NO;
        
        _tableView.mj_header = self.tableViewHeader;
        _tableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreRefresh];
        }];
        self.tableViewFooter.stateLabel.hidden = YES;
        self.tableViewFooter.automaticallyChangeAlpha = YES;
        if (self.mkVideoListType == MKVideoListType_A) {
            _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight -  kTabBarHeight);
        } else {
            _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        }
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.rowHeight = _tableView.frame.size.height;
        _tableView.scrollsToTop = NO;
        _tableView.pagingEnabled = YES;
    }
    return _tableView;
}

- (MKDouYinControlView *)controlView {
    if (!_controlView) {
        _controlView = [MKDouYinControlView new];
        WeakSelf
        _controlView.playerLoadStateChangedBlock = ^(NSString * _Nonnull str) {
                if (self.mkVideoListType == MKVideoListType_A) {
//                    if ([str isEqualToString:@"YES"]) {
//                        [weakSelf.controlView.sliderView  stopAnimating];
//                    } else {
//                        [weakSelf.controlView.sliderView  startAnimating];
//                    }
                    NSLog(@"view回调 %@",str);
                    if(![MKTools mkLoginIsLogin]){
        
                        if ([str isEqualToString:@"YES"]) {
                            // 完成后时红包走
                            if (self.mkFirstPlay == YES) {
                                [weakSelf.mkShuaCoinView cotinueAddCoin];
                            }
                        } else {
                            // 缓冲时红包不走
                            [weakSelf.mkShuaCoinView stopAddCoin];
                        }
                    }
                }
        };
    }
    return _controlView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}


#pragma mark —— lazyload
-(CommentPopUpVC *)commentPopUpVC{
    if (!_commentPopUpVC) {
        _commentPopUpVC = CommentPopUpVC.new;
        _commentPopUpVC.videoID = self.videoDemandModel.videoId;
        _commentPopUpVC.isRecommend = YES;
        _commentPopUpVC.recommendVC = self;
        _commentPopUpVC.homeVC = self.homeVC;
        if (self.mkVideoListType == MKVideoListType_A){
            _commentPopUpVC.isRecommend = YES;
        } else {
            _commentPopUpVC.isRecommend = NO;
        }
        _commentPopUpVC.liftingHeight = kScreenHeight - CommentHeight;
        [UIView appointCornerCutToCircleWithTargetView:_commentPopUpVC.view
                                     byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                           cornerRadii:CGSizeMake(20, 20)];
        [self addChildViewController:_commentPopUpVC];
        [self.view addSubview:_commentPopUpVC.view];
        [self.view bringSubviewToFront:_commentPopUpVC.view];
        //初始化，否则控件是从上落下来的
        _commentPopUpVC.view.mj_y = SCREEN_HEIGHT;
        _commentPopUpVC.view.mj_x = 0;
        _commentPopUpVC.view.mj_w = SCREEN_WIDTH;
        _commentPopUpVC.view.mj_h = CommentHeight;
        //已经发送评论网络请求成功
        @weakify(self)
        [_commentPopUpVC commentPopUpActionBlock:^(id data) {
//            self->_mkPlayerScrollView.mkPlayUserInfoView.mkRightBtuttonView.mkCommentView.mkTitleLable.text = self->_commentPopUpVC.commentNumStr;
            MKDouYinCell *cell = [weak_self.tableView cellForRowAtIndexPath:
                                  [NSIndexPath indexPathForRow:weak_self.index inSection:0]];
            cell.rightBtnView.mkCommentView.mkTitleLable.text = [data stringValue];
            
            MKVideoDemandModel *model = self.mkRecommend.list[weak_self.index];
            model.commentNum = [data stringValue];
        }];
        //点击 或者 拖拽触发事件
        [_commentPopUpVC popUpActionBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                self->_commentPopUpVC.isClickExitBtn = YES;
                //判断评论框里面是否有值？
                if (self->_commentPopUpVC.field.text.length == 0) {
                    [self willClose_vertical];
                }else{
                    [NSObject showSYSAlertViewTitle:@"优质评论会被优先展示"
                                        message:@"确定放弃评论吗？"
                                isSeparateStyle:NO
                                    btnTitleArr:@[@"我不回复了",@"手滑啦"]
                                 alertBtnAction:@[@"GiveUpComment",@""]
                                           targetVC:self
                                   alertVCBlock:^(id data) {
                        //DIY
                    }];
                }
            }else{
                //弹出键盘的时候 没做处理
                MoveDirection moveDirection = [data intValue];
                if (moveDirection == MoveDirection_vertical_down) {
                    [self willClose_vertical];
                }else if (moveDirection == MoveDirection_horizont_right){

                }else if (moveDirection == MoveDirection_vertical_up){
                    [self willOpen];
                }else{}
            }
        }];
    }return _commentPopUpVC;
}

#pragma mark - 广告加入  播放最后一个视频的时候加载下一页
- (void)setMkIndex:(NSInteger)mkIndex{
    _mkIndex = mkIndex;
//    if (mkIndex == self.mkDataList.count -1 && self.mkDataList.count >=0  ) {
//        self.mkPageNumber += 1;
//        WeakSelf
//        [self requestWith:0 WithPageNumber:weakSelf.mkPageNumber WithPageSize:100 Block:^(id data) {
//
//            if ((Boolean)data) {
//
//                [weakSelf addDataToArray:weakSelf.mkRecommend.list];
//
//            }else{
//                weakSelf.mkPageNumber -= 1;
//            }
//        }];
//    }else{}
    
    
    
}

#pragma mark - 返回按钮
-(UIBarButtonItem *)returnBtnItem{
    if (!_returnBtnItem) {
        UIButton *btn = UIButton.new;
        btn.frame = CGRectMake(0,  0, 44,  44);
        [btn setImage:KIMG(@"return")
             forState:UIControlStateNormal];
        [btn addTarget:self
                action:@selector(returnBtnClickEvent)
      forControlEvents:UIControlEventTouchUpInside];
        _returnBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }return _returnBtnItem;
}
- (void)returnBtnClickEvent
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 布局子视图
- (void)mkLayOutView{

}
-(void)Sure{}

- (NSMutableArray *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
        [_dataMutArr addObject:[[BWItemModel alloc] initWithImg:@"weixing" text:@"微信"]];
        [_dataMutArr addObject:[[BWItemModel alloc] initWithImg:@"qq" text:@"QQ"]];
        [_dataMutArr addObject:[[BWItemModel alloc] initWithImg:@"kongjian" text:@"面对面邀请"]];
        [_dataMutArr addObject:[[BWItemModel alloc] initWithImg:@"sina" text:@"复制链接"]];
    }return _dataMutArr;
}



- (MKRecommentModel *)mkRecommend{
    
    if (!_mkRecommend) {
        
        _mkRecommend = [[MKRecommentModel alloc]init];
    }
    return _mkRecommend;
}
- (MKVideoAdModel *)mkVideoAd{
    
    if (!_mkVideoAd) {
        
        _mkVideoAd = [[MKVideoAdModel alloc]init];
    }
    return _mkVideoAd;
}
- (GKDoubleLikeView *)doubleLikeView {
    if (!_doubleLikeView) {
        _doubleLikeView = [GKDoubleLikeView new];
    }
    return _doubleLikeView;
}
- (MKDiamondsView *)mkDiamondsView{
    
    if (!_mkDiamondsView) {
        
        _mkDiamondsView = [[MKDiamondsView alloc]init];
        
    }
    return _mkDiamondsView;
}
#pragma mark - 刷币视图
- (MKShuaCoinView *)mkShuaCoinView{
    
    if (!_mkShuaCoinView) {
        
        _mkShuaCoinView = [[MKShuaCoinView alloc]init];
    }
    return _mkShuaCoinView;
}
- (UIView *)commentCoverView {
    if (!_commentCoverView) {
        _commentCoverView = UIView.new;
        _commentCoverView.backgroundColor = UIColor.blackColor;
        _commentCoverView.alpha = 0.2;
        _commentCoverView.frame = CGRectMake(0, 0, SCREEN_W, kScreenHeight - CommentHeight);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(commentCoverClick)];
        [_commentCoverView addGestureRecognizer:tap];
    }
    return _commentCoverView;
}
- (void)commentCoverClick {
    [self willClose_vertical];
}
- (MKShareView *)mkshareview
{
    if (!_mkshareview) {
        _mkshareview = [[MKShareView alloc] initWithFrame:self.view.frame];
    }
    return _mkshareview;
}
///分享弹窗
-(void)MakeShareView{
    if ([MKTools mkLoginIsYESWith:self]){
        MKVideoDemandModel *model = (MKVideoDemandModel *)[self.mkRecommend.list objectAtIndex:self.mkIndex];
        
        WeakSelf
        [self reuestShareData:^(id data, id data2) {
            if ((Boolean)data) {
                // 分享时视频停止
                [weakSelf.mkshareview showWithViedo:model.videoImg AndInviteInfo:data2];
            }
        }];
    }
    
}


- (void)recoderStartPlay:(MKVideoDemandModel *)model WithTime:(double)floatTime{
    // 开始播放
    if([self mkIsCanGetCoin]){
        
    }else{
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!self.mkFirstPlay){
            return;
        }
        if (!self.mkShuaCoinView.hidden){
             [self.mkShuaCoinView startAddCoin]; // 判断首次进来是否统计红包倒计时
        }
//        if (!self.mkDiamondsView.hidden){
//            [self.mkDiamondsView startAddDiamond];
//        }
       
//        if (!self.mkDiamondsView.hidden || !self.mkShuaCoinView.hidden) {
            if (!self.mkShuaCoinView.hidden) {
            self.playRecordArray = [NSMutableArray array];
            
            MKLoginModel *model2 = [MKPublickDataManager sharedPublicDataManage].mkLoginModel;
            
            NSMutableDictionary *dic = [NSMutableDictionary new];
            
            [dic setValue:[MKPublickDataManager sharedPublicDataManage].mkLoginModel.uid forKey:@"userId"];
            
            NSString *timeStr = [MKKeyAndSecreetTool getNowTimeTimestamp3];
            
            timeStr = [NSString stringWithFormat:@"%@%@",timeStr,@"niGMYaqV6r"];
            
            [dic setValue:[MKKeyAndSecreetTool encodeString:timeStr] forKey:@"param_play"];
            
            [self.playRecordArray addObject:@{model.videoId:@(floatTime)}];
            
            model2.coinStartPlayTime = [NSString stringWithFormat:@"%@",[MKKeyAndSecreetTool encodeString:timeStr]];
            
//            model2.diamondsStartPlayTime = [NSString stringWithFormat:@"%@",[MKKeyAndSecreetTool encodeString:timeStr]];
            
            [[MKLoginModel getUsingLKDBHelper] insertToDB:model2 callback:^(BOOL result) {
//                NSLog(@"%@",result?@"成功":@"失败");
                
            }];
        }
       
        
    });
    
}
- (void)recoderCotinuenPlay:(MKVideoDemandModel *)model WithTime:(double)floatTime{
    // 继续播放 cotinueAddCoin
    if([self mkIsCanGetCoin]){
    }else{
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.mkShuaCoinView cotinueAddCoin];
        [self.playRecordArray addObject:@{model.videoId:@(floatTime)}];
    });
}
- (void)recoderEndPlay:(MKVideoDemandModel *)model WithTime:(double)floatTime{
    // 暂停播放
    
    if([self mkIsCanGetCoin]){
    }else{
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mkShuaCoinView stopAddCoin];
//        [self.mkDiamondsView stopAddDiamond];
        [self.playRecordArray addObject:@{model.videoId:@(floatTime)}];
    });
}
- (void)recoderResetPlay:(MKVideoDemandModel *)model WithTime:(double)floatTime{
    // 重复播放
    if([self mkIsCanGetCoin]){
        
    }else{
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.mkShuaCoinView.hidden) { }
        else{
            [self.mkShuaCoinView stopAddCoin];
            [self.mkShuaCoinView resetTime];
        }
//        if (self.mkDiamondsView.hidden) {}
//        else{
//            [self.mkDiamondsView stopAddDiamond];
//            [self.mkDiamondsView resetTime];
//           
//        }
    });
}
#pragma mark -  空数据delegate
//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
//    return self.showEmpty;
//}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"av"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = self.noNetwork ? @"当前无网络链接" : @"点击可以刷新";
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view{
    [self pullToRefresh];
}
@end
#pragma clang diagnostic pop
