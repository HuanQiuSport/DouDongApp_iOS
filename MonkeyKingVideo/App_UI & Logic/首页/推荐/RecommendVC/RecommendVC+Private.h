//
//  RecommendVC+Private.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//


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
#import "RecommendVC+Delegates.h"
#import "RecommendVC+Notification.h"
#import "RecommendVC+UpdateVideo.h"
#import "RecommendVC+TopAndBottomBar.h"
#import "RecommendVC+Share.h"
#import "RecommendVC+Ads.h"
#import "RecommendVC+Comment.h"
#import "MKShareView.h"
#import "RecommendVC+Diamand.h"
#import "MKRecommentModel.h"
#import "MKVideoAdModel.h"
#import "RecommendVC+MKMoney.h"
#import "MKShuaCoinView.h"
#import "RecommendVC+ActiveUser.h"

#import "RecommendVC+CoinNet.h"
#import "MKKeyAndSecreetTool.h"
#import "RecommendVC+LoginAlert.h"
#import "UIScrollView+EmptyDataSet.h"

#import "MKDouYinCell.h"
#import "MKDouYinControlView.h"
#import "ZFPlayerMediaPlayback.h"

#pragma mark - 广告
#import "RecommendVC+Ads2.h"
#import "MKAdvertisingController.h"
#import "RecommendVC+LocalAds.h"
NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC ()<UITableViewDelegate,UITableViewDataSource,MKDouYinDelegate,MKVideoPlayDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) GKDoubleLikeView          *doubleLikeView;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;
///  新分享
@property (nonatomic,strong) MKShareView *mkshareview;
/// 评论控制器
@property(nonatomic,strong)CommentPopUpVC *commentPopUpVC;
@property(nonatomic,strong)NSMutableArray *dataMutArr;
@property(nonatomic,strong)NSString *videoid;

@property(nonatomic,strong)MKVideoDemandModel *videoDemandModel;
//@property(nonatomic,strong)NSMutableArray *mkDataList;
@property(nonatomic,assign)NSInteger mkIndex;
//@property(nonatomic,assign)VideoType videoType;
@property(nonatomic,assign)NSInteger mkMemid;
//@property(nonatomic,strong)MKCPlayVideoView* mkPlayerScrollView;

@property (strong) YYTimer *timer;
@property (strong) YYTimer *activeTimer;
//@property(nonatomic,strong)MKAdVC *adVC;

@property(nonatomic,assign)CGFloat CommentPopUpVC_Y;
@property(nonatomic,assign)CGFloat CommentPopUpVC_EditY;//编辑状态下，键盘弹出的时候的CommentPopUpVC.view的高度
@property(nonatomic,assign)BOOL isCommentPopUpVCOpen;//当前CommentPopUpVC.view 是否开合?
@property(nonatomic,assign)CGFloat liftingHeight;
@property(nonatomic,assign)BOOL isBackFromPopAdVC;//是否从广告页pop回来的？

/// page
@property (assign,nonatomic) NSInteger mkPageNumber;

///
@property (strong,nonatomic) MKDiamondsView *mkDiamondsView;

@property (strong,nonatomic) MKShuaCoinView *mkShuaCoinView;

@property (nonatomic,strong)UIView *commentCoverView;

///  数据
@property(strong,nonatomic)MKRecommentModel *mkRecommend;
///  数据
@property(strong,nonatomic)MKVideoAdModel *mkVideoAd;
@property(assign,nonatomic)MKVideoListType mkVideoListType;

@property(nonatomic,strong)UIBarButtonItem *returnBtnItem;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) MKDouYinControlView *controlView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger playCount;
///记录进入后台播放时的index
@property (nonatomic, assign) NSInteger lastIndex;
@property (nonatomic, assign) BOOL isRecommend;

@property (nonatomic, assign) BOOL showEmpty;
@property (nonatomic, assign) BOOL noNetwork;
///
///  YES 是第一次播放 ｜  NO 不是第一次播放
@property (assign,nonatomic) Boolean mkFirstPlay;
/// 传入YES头像为不可点击
@property (assign,nonatomic) BOOL userHeardNoClick;

@property (strong,nonatomic) NSMutableArray *playRecordArray;

@property (strong,nonatomic) HomeAdView *homeAdView;



#pragma mark - 广告
//@property(nonatomic,strong)UINavigationController *navigationController;
+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated;
- (void)playPlayer;
- (void)pausePlayer;

@end

NS_ASSUME_NONNULL_END
