//
//  MKPlayVideoView.m
//  KSPlayer
//
//  Created by hansong on 7/3/20.
//  Copyright © 2020 hansong. All rights reserved.
//

#import "MKPlayVideoView.h"

static MKPlayVideoView * staticMKPlayVideoView = nil;
@implementation MKPlayVideoView

- (void)dealloc {
//    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

///*
// 单例：主页面对象
// */
//+ (MKPlayVideoView *)shareMKPlayVideoView;
//{
//    @synchronized(self)
//    {
//        if(staticMKPlayVideoView == nil)
//        {
//            staticMKPlayVideoView=[[self alloc] init];
//        }
//    }
//    return staticMKPlayVideoView;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
        [self mkAddSubView];
        
        [self mkLayOutView];
    
        
        
        [self mkAddViewClick];
    }
    return self;
}
#pragma mark - 添加子视图
- (void)mkAddSubView{
    
    self.mkVideoView.frame = CGRectMake(0, 0, MAINSCREEN_WIDTH, kScreenHeight);
    
    [self addSubview:self.mkVideoView];
    
     self.autoresizesSubviews = TRUE;
    
    
    [self addSubview:self.mkFontImageView];
    
    [self addSubview:self.mkPlayUserView];

}
#pragma mark - 布局子视图
- (void)mkLayOutView{
    
    [self.mkFontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
  
#pragma mark - 视图点击时间
- (void)mkAddViewClick{
    WeakSelf
    [self.mkPlayUserView.mkAttentionButton addAction:^(UIButton *btn) {
        
        if([weakSelf.mkDelegate respondsToSelector:@selector(didClickPlayAttention:WithPlayID:)]){
            
            [weakSelf.mkDelegate didClickPlayAttention:weakSelf WithPlayID:weakSelf.index];
        }
        
    }];
    
    [self.mkPlayUserView.mkRightBtuttonView.mkZanView.mkButton addAction:^(UIButton *btn) {
        
        if([weakSelf.mkDelegate respondsToSelector:@selector(didClickPlayZan:WithPlayID:)]){
            
            [weakSelf.mkDelegate didClickPlayZan:weakSelf WithPlayID:weakSelf.index];
            
        }
        
    }];
    
    [self.mkPlayUserView.mkRightBtuttonView.mkShareView.mkButton addAction:^(UIButton *btn) {
        
        if([weakSelf.mkDelegate respondsToSelector:@selector(didClickPlayShare:WithPlayID:)]){
            
            [weakSelf.mkDelegate didClickPlayShare:weakSelf WithPlayID:weakSelf.index];
            
        }
        
    }];
    
    [self.mkPlayUserView.mkRightBtuttonView.mkCommentView.mkButton addAction:^(UIButton *btn) {
        
        if([weakSelf.mkDelegate respondsToSelector:@selector(didClickPlayReplay:WithPlayID:)]){
            
            [weakSelf.mkDelegate didClickPlayReplay:weakSelf WithPlayID:weakSelf.index];
            
        }
        
    }];
    
    [self.mkPlayUserView.mkLoginView addGestureRecognizer:JHGestureType_Tap block:^(__kindof UIView *view, __kindof UIGestureRecognizer *gesture) {
        
        if([weakSelf.mkDelegate respondsToSelector:@selector(didClickPlayLogin:WithPlayID:)]){
            
            [weakSelf.mkDelegate didClickPlayLogin:weakSelf WithPlayID:weakSelf.index];
            
        }
        
    }];
       
}


- (UIView *)mkVideoView{
    
    if (!_mkVideoView) {
        
        _mkVideoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, kScreenHeight)];
    }
    return _mkVideoView;
}

-(void)mkReload:(NSString *)urlStr{

//    NSLog(@"播放地址====%@",urlStr);
  
}

- (MKPlayUserInfoView *)mkPlayUserView{
    
    if (!_mkPlayUserView) {
        
        _mkPlayUserView = [[MKPlayUserInfoView alloc]initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, kScreenHeight)];
        
    }
    
    return _mkPlayUserView;
}
- (UIImageView *)mkFontImageView{
    
    if (!_mkFontImageView) {
        
        _mkFontImageView = [[UIImageView alloc]init];
        
    }
    return _mkFontImageView;
}
- (MKVideoDemandModel *)mkModelLive{
    
    if (!_mkModelLive) {
     
        _mkModelLive = [[MKVideoDemandModel alloc]init];
    }
//    NSLog(@"%@",_mkModelLive);
    return _mkModelLive;
}
@end
