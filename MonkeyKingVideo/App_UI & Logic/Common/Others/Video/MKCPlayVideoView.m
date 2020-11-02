

//
//  MKCPlayVideoView.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/8/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKCPlayVideoView.h"
#import "MKVideoFrontView.h"
#import "MKVideoDemandModel.h"
@interface MKCPlayVideoView()
<
UIScrollViewDelegate
>
@property (nonatomic, strong) NSMutableArray * mkLives;
@property (nonatomic, strong) MKVideoDemandModel *mkCurrentlive;
//@property (nonatomic, strong) UIImageView *mkUpperImageView, *mkMiddleImageView, *mkDownImageView;


@property (nonatomic, strong) MKVideoFrontView *mkUpperFrontView, *mkMiddleFrontView, *mkDownFrontView;
//@property (strong,nonatomic) MKPlayUserInfoView *mkUpperPlayUserInfoView,*mkMiddlePlayUserInfoView,*mkDownPlayUserInfoView;
@property (nonatomic, strong) MKVideoDemandModel *mkUpperLive, *mkMiddleLive, *mkDownLive;
@property (nonatomic, assign) NSInteger mkCurrentIndex, mkPreviousIndex;

@end

@implementation MKCPlayVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        self.contentSize = CGSizeMake(0, frame.size.height * 3);
        
        self.contentOffset = CGPointMake(0, frame.size.height);
        
        self.pagingEnabled = YES;
        
        self.opaque = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.showsHorizontalScrollIndicator = NO;
        
        self.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        self.delegate = self;
        
        self.mkUpperFrontView = [[MKVideoFrontView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        
        self.mkMiddleFrontView = [[MKVideoFrontView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, frame.size.height)];

         self.mkDownFrontView = [[MKVideoFrontView alloc] initWithFrame:CGRectMake(0, frame.size.height*2, frame.size.width, frame.size.height)];

        
        [self addSubview:self.mkUpperFrontView];
        
        [self addSubview:self.mkMiddleFrontView];
        
        [self addSubview:self.mkDownFrontView];

        self.autoresizesSubviews = YES;

        self.mkPlayUserInfoView = [[MKPlayUserInfoView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        [self mkAddViewClick];

      
    }
    return self;
}

- (void)mkAddViewClick{
    @weakify(self)
//    UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(statusAction:)];
//
////    tapGesturRecognizer.cancelsTouchesInView = NO;
//
////    tapGesturRecognizer.delegate = self;
//
//    tapGesturRecognizer.numberOfTapsRequired = 1;
////
//    [_mkPlayUserInfoView addGestureRecognizer:tapGesturRecognizer];
//
    
    UITapGestureRecognizer *zanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTwoHanderZan:)];

//    zanTap.cancelsTouchesInView = NO;

//    zanTap.delegate = self;

    zanTap.numberOfTapsRequired = 2;

//    zanTap.numberOfTouchesRequired = 2;

//    [tapGesturRecognizer requireGestureRecognizerToFail:zanTap];
    [_mkPlayUserInfoView addGestureRecognizer:zanTap];
    
    
    [self.mkPlayUserInfoView.mkAttentionButton addAction:^(UIButton *btn) {
        @strongify(self)
        if (btn.selected) {
            return;
        }
        if([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayAttention:WithPlayID:)]){
            
            [self.mkPlayerDelegate didClickPlayAttention:self WithPlayID:self.mkIndex];
        }
        
    }];
    
    [self.mkPlayUserInfoView.mkRightBtuttonView.mkZanView.mkButton addAction:^(UIButton *btn) {
        @strongify(self)

        if([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayZan:WithPlayID:)]){

            [self.mkPlayerDelegate didClickPlayZan:self WithPlayID:self.mkIndex];
        }
    }];
    
    [self.mkPlayUserInfoView.mkRightBtuttonView.mkShareView.mkButton addAction:^(UIButton *btn) {
        @strongify(self)
        if([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayShare:WithPlayID:)]){
            [self.mkPlayerDelegate didClickPlayShare:self WithPlayID:self.mkIndex];
        }
    }];
    
    [self.mkPlayUserInfoView.mkRightBtuttonView.mkCommentView.mkButton addAction:^(UIButton *btn) {
        @strongify(self)
        if([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayReplay:WithPlayID:)]){
            
            [self.mkPlayerDelegate didClickPlayReplay:self WithPlayID:self.mkIndex];
            
        }
        
    }];
    [self.mkPlayUserInfoView.mkLoginView addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
        @strongify(self)
        if([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayLogin:WithPlayID:)]){
            
            [self.mkPlayerDelegate didClickPlayLogin:self WithPlayID:self.mkIndex];
            
        }
        
    }];
    
    
    [self.mkPlayUserInfoView.mkUserImageView addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
        @strongify(self)
        if([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayUserInfo:WithPlayID:)]){
            
            [self.mkPlayerDelegate didClickPlayUserInfo:self WithPlayID:self.mkIndex];
            
        }
        
    }];
    
    [self.mkPlayUserInfoView.mkAdView addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
        @strongify(self)
        if([self.mkPlayerDelegate respondsToSelector:@selector(didTwoClickPlayAD:currentPlayerIndex:)]){
            
            [self.mkPlayerDelegate didTwoClickPlayAD:self currentPlayerIndex:self.mkIndex];
            
        }
        
    }];
          
}

#pragma mark -
- (void)statusAction:(UITapGestureRecognizer *)tap{
//    NSLog(@"状态改逻辑");
    if (tap.numberOfTapsRequired == 2 ) {
        return;
    }
    
    
    
    MKVideoStatus status = _mkVideoStatus;
    
    if (status == MKVideoStatus_loading) {
        
//        NSLog(@"加载中1");
        return;
    }
    if (status == MKVideoStatus_playing) {
        
//        NSLog(@"播放中");
        
        self.mkVideoStatus = MKVideoStatus_pause;
        
    }
    if (status == MKVideoStatus_pause) {
        
//        NSLog(@"暂停中");
        
        self.mkVideoStatus = MKVideoStatus_playing;
        
    }
    if (status == MKVideoStatus_faile) {
        
//        NSLog(@"播放失败");
        
        self.mkVideoStatus = MKVideoStatus_loading;
        
    }
#pragma warnning - 注意视频的播放状态
    if (_mkPlayerDelegate &&[_mkPlayerDelegate respondsToSelector:@selector(didClickPlayOrStop:currentPlayerStatu:)]) {
        
        [_mkPlayerDelegate didClickPlayOrStop:self currentPlayerStatu:_mkVideoStatus];
        
    }
}
- (void)tapTwoHanderZan:(UITapGestureRecognizer *)tap{
    
//    NSLog(@"点击此时 %lu",(unsigned long)tap.numberOfTouchesRequired); // 点击时的手指数量
//
//    NSLog(@"点击此时 %lu",(unsigned long)tap.numberOfTapsRequired);// 点击次数
    
    if (tap.numberOfTapsRequired == 1) {
        return;
    }

    if([self.mkPlayerDelegate respondsToSelector:@selector(didTwoClickPlayZan:currentPlayerIndex:)]){
        
        [self.mkPlayerDelegate didTwoClickPlayZan:self currentPlayerIndex:self.mkCurrentIndex];
        
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.tapCount <= 1) {
        if (self.mkVideoStatus == MKVideoStatus_playing) {
            [self setMkVideoStatus:MKVideoStatus_pause];
        } else if (self.mkVideoStatus == MKVideoStatus_pause) {
            [self setMkVideoStatus:MKVideoStatus_playing];
        }
    }else {
        if ([self.mkPlayerDelegate respondsToSelector:@selector(didTwoClickPlaySpecialZan:touchesBegan:withEvent:)]) {
            [self.mkPlayerDelegate didTwoClickPlaySpecialZan:self touchesBegan:touches withEvent:event];
        }
        if ([self.mkVideoInfoModel.isPraise isEqualToString:@"1"]) {
            
        }else{
            [self controlViewDidClick];
        }
    }
}
- (void)controlViewDidClick{
    
    if ([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayZan:WithPlayID:)]) {
        
           [self.mkPlayerDelegate didClickPlayZan:self WithPlayID:self.mkIndex];
        
    }
}


- (void)setMkVideoStatus:(MKVideoStatus)mkVideoStatus{
    
    _mkVideoStatus = mkVideoStatus;
    
    if (mkVideoStatus == MKVideoStatus_loading) {
        
//        NSLog(@"加载中");
//        NSLog(@"加载中-添加加载圈");
        _mkPlayUserInfoView.mkStatusImage.image = nil;
        
    }
    
    if (mkVideoStatus == MKVideoStatus_playing) {
//        NSLog(@"播放中2");
        _mkPlayUserInfoView.mkStatusImage.image = nil;
        [[MKTools shared] dissmissLoadingInView:self.superview animated:YES];
    }
    
    if (mkVideoStatus == MKVideoStatus_pause) {
//        NSLog(@"暂停中");
         [[MKTools shared] dissmissLoadingInView:self.superview animated:YES];
        _mkPlayUserInfoView.mkStatusImage.image = [UIImage imageNamed:@"暂停播放"];
        
        
    }
    
    if (mkVideoStatus == MKVideoStatus_faile) {
        
//        NSLog(@"播放失败");
        [[MKTools shared] dissmissLoadingInView:self.superview animated:YES];
        _mkPlayUserInfoView.mkStatusImage.image = [UIImage imageNamed:@"重复播放"];
        
        
    }
    
}
#pragma mark - setter 创建对象
- (NSMutableArray *)mkLives{
    
    if (!_mkLives) {
        
        _mkLives = [NSMutableArray array];
    }
    return _mkLives;
}

- (void)dealloc
{
//    NSLog(@"播放器釋放");
}

- (void)setMkVideoInfoModel:(MKVideoDemandModel *)mkVideoInfoModel{
    _mkVideoInfoModel = mkVideoInfoModel;
    #pragma mark - ⚠️ 用户数据填充
//    [self prepareForImageViewB:_mkPlayUserInfoView withLive:mkVideoInfoModel];
}


- (void)updateForLives:(NSMutableArray *)livesArray withCurrentIndex:(NSInteger)index
{
  if (livesArray.count && [livesArray firstObject]) {
      
    [self.mkLives removeAllObjects];
      
    [self.mkLives addObjectsFromArray:livesArray];
      
    self.mkCurrentIndex = index;
      
    self.mkPreviousIndex = index;
      
    
    _mkUpperLive = [[MKVideoDemandModel alloc] init];
      
      
    _mkMiddleLive = (MKVideoDemandModel *)_mkLives[_mkCurrentIndex];
      
      
    _mkDownLive = [[MKVideoDemandModel alloc] init];
      
    
    if (_mkCurrentIndex == 0) {
        
      _mkUpperLive = (MKVideoDemandModel *)[_mkLives lastObject];
        
    } else {
        
      _mkUpperLive = (MKVideoDemandModel *)_mkLives[_mkCurrentIndex - 1];
    }
    if (_mkCurrentIndex == _mkLives.count - 1) {
        
      _mkDownLive = (MKVideoDemandModel *)[_mkLives firstObject];
        
    } else {
        
      _mkDownLive = (MKVideoDemandModel *)_mkLives[_mkCurrentIndex + 1];
    }
    
      
      self.mkUpperFrontView.mkLive = _mkUpperLive;
      self.mkMiddleFrontView.mkLive = _mkMiddleLive;
      self.mkDownFrontView.mkLive = _mkDownLive;
      
      [self prepareForImageViewA:self.mkUpperFrontView.mkImageView withLive:_mkUpperLive WithIndex:0];

      [self prepareForImageViewA:self.mkMiddleFrontView.mkImageView withLive:_mkMiddleLive WithIndex:1];

      [self prepareForImageViewA:self.mkDownFrontView.mkImageView withLive:_mkDownLive WithIndex:2];
    
  }
}

- (void)prepareForImageViewA: (UIImageView *)imageView withLive:(MKVideoDemandModel *)live WithIndex:(NSInteger )indexId{
    
    [self prepareForImageView: imageView  withLive:live];

    if (indexId == 0 ) {
        
        [self prepareForImageViewB:self.mkUpperFrontView.mkUserInfoView withLive:live];
        
    }else if (indexId == 1 ){
        
        [self prepareForImageViewB:self.mkMiddleFrontView.mkUserInfoView withLive:live];
        
    }else if (indexId == 2 ){
        
        [self prepareForImageViewB:self.mkDownFrontView.mkUserInfoView withLive:live];
    }
    
    
    
}
- (void)prepareForImageViewB:(MKPlayUserInfoView *)mkPlayUserInfoView withLive:(MKVideoDemandModel *)live{
  
    [mkPlayUserInfoView.mkUserImageView sd_setImageWithURL:[NSURL URLWithString:live.headImage.stringByRemovingPercentEncoding] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        mkPlayUserInfoView.mkUserImageView.image = image;
    }];
    
    mkPlayUserInfoView.mkRightBtuttonView.mkZanView.mkTitleLable.text = live.praiseNum;
    
    [mkPlayUserInfoView.mkRightBtuttonView.mkZanView.mkButton setSelected:!live.isPraise];
    
    if (!live.isPraise) {
        
        mkPlayUserInfoView.mkRightBtuttonView.mkZanView.mkImageView.image = KIMG(@"喜欢-点击");
        
    }else{
        
        mkPlayUserInfoView.mkRightBtuttonView.mkZanView.mkImageView.image = KIMG(@"喜欢-未点击");
    }
    
    mkPlayUserInfoView.mkRightBtuttonView.mkCommentView.mkTitleLable.text = live.commentNum;
    
    
    mkPlayUserInfoView.mkDescribeLabel.text = live.videoTitle;
    
    
    mkPlayUserInfoView.mkUserNameLabel.text = [NSString stringWithFormat:@"@%@",[NSString ensureNonnullString:live.author ReplaceStr:@"抖动用户"]];
    
    if ([live.isAttention integerValue] == 0) {
        
        mkPlayUserInfoView.mkAttentionButton.hidden = NO;
        
        mkPlayUserInfoView.mkAttentionButton.selected = NO;
        
    }else{
        
        mkPlayUserInfoView.mkAttentionButton.hidden = YES;
        
        mkPlayUserInfoView.mkAttentionButton.selected = YES;
        
    }
    
//    if (![MKTools mkLoginIsLogin]) {
//        
//        mkPlayUserInfoView.mkLoginView.hidden = YES;
//        
//    }else{
//        
//       mkPlayUserInfoView.mkLoginView.hidden = NO;
//        
//    }
}
- (void) prepareForImageView: (UIImageView *)imageView withLive:(MKVideoDemandModel *)live
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:live.videoImg]];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self switchPlayer:scrollView];

}

- (void)switchPlayer:(UIScrollView*)scrollView
{
  CGFloat offset = scrollView.contentOffset.y;
    
//    NSLog(@"offset = %f",offset);
    if (_mkCurrentIndex == 0&& offset <= SCREEN_HEIGHT) {
        
        [scrollView setContentOffset:CGPointMake(0, SCREEN_HEIGHT) animated:NO];
        
        
//        [MBProgressHUD wj_showPlainText:@"欧吼，已经到顶了" view:nil];
        
        return;
    } else {
//        NSLog(@"不返回");
    }

    
  if (self.mkLives.count) {
      
    if (offset >= 2*self.frame.size.height)
    {//2*self.frame.size.height = 1792
        //下划
        // slides to the down player
        
        scrollView.contentOffset = CGPointMake(0, self.frame.size.height);
        
        _mkCurrentIndex++;
        
        self.mkUpperFrontView.mkImageView.image = self.mkMiddleFrontView.mkImageView.image;
        
         self.mkUpperFrontView.mkUserInfoView = self.mkMiddleFrontView.mkUserInfoView;
        
        self.mkMiddleFrontView.mkImageView.image = self.mkDownFrontView.mkImageView.image;
        
        self.mkMiddleFrontView.mkUserInfoView = self.mkDownFrontView.mkUserInfoView;
        
//        self.mkCurrentPlayer.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        
        if (_mkCurrentIndex == self.mkLives.count - 1)
        {
            _mkDownLive = [self.mkLives firstObject];
            
        } else if (_mkCurrentIndex == self.mkLives.count)
        {
            _mkDownLive = self.mkLives[1];
            
            _mkCurrentIndex = 0;
            
        } else
        {
            _mkDownLive = self.mkLives[_mkCurrentIndex+1];
        }
        WeakSelf
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf prepareForImageViewA:weakSelf.mkDownFrontView.mkImageView withLive:weakSelf.mkDownLive WithIndex:2];
        });
        
      
        
        if (_mkPreviousIndex  == _mkCurrentIndex) {
            
            return;
        }
        
        if ([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayChange:currentPlayerIndex:)]) {
            
            [self.mkPlayerDelegate didClickPlayChange:self currentPlayerIndex:_mkCurrentIndex];
            
            _mkPreviousIndex = _mkCurrentIndex;
//            NSLog(@"current index in delegate:2 %ld -%s",_mkCurrentIndex,__FUNCTION__);
        }
        
    }
      
    else if (offset <= 0)
    {
        //上拉
      // slides to the upper player
      scrollView.contentOffset = CGPointMake(0, self.frame.size.height);
        
      _mkCurrentIndex--;
        
        self.mkDownFrontView.mkImageView.image = self.mkMiddleFrontView.mkImageView.image;
        
        self.mkDownFrontView.mkUserInfoView = self.mkMiddleFrontView.mkUserInfoView;
        
        self.mkMiddleFrontView.mkImageView.image = self.mkUpperFrontView.mkImageView.image;
        
        self.mkMiddleFrontView.mkUserInfoView = self.mkUpperFrontView.mkUserInfoView;
        
      
//      self.mkCurrentPlayer.view.frame = CGRectMake(0, SCREEN_HEIGHT , SCREEN_WIDTH, SCREEN_HEIGHT);

      
      if (_mkCurrentIndex == 0)
      {
        _mkUpperLive = [self.mkLives lastObject];
        
      } else if (_mkCurrentIndex == -1)
      {
        _mkUpperLive = self.mkLives[self.mkLives.count - 2];
          
        _mkCurrentIndex = self.mkLives.count-1;
          
        
      } else
      {
        _mkUpperLive  = self.mkLives[_mkCurrentIndex - 1];
      }
        WeakSelf
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf prepareForImageViewA:weakSelf.mkUpperFrontView.mkImageView withLive:weakSelf.mkUpperLive WithIndex:0];
        });
        
        
      
      if (_mkPreviousIndex == _mkCurrentIndex) { return; }
        
      if ([self.mkPlayerDelegate respondsToSelector:@selector(didClickPlayChange:currentPlayerIndex:)]) {

        [self.mkPlayerDelegate didClickPlayChange:self currentPlayerIndex:_mkCurrentIndex];

        _mkPreviousIndex = _mkCurrentIndex;

      }
    }
  }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
//    NSLog(@"滑動結束 index = %ld",(long)_mkCurrentIndex);
    
    
    if (_mkCurrentIndex==_mkLives.count) {
        
//        NSLog(@"");
    }
}



@end
