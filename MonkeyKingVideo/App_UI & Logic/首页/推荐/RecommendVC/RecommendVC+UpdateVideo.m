//
//  RecommendVC+UpdateVideo.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//
#import "RecommendVC+Private.h"
#import "RecommendVC+UpdateVideo.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
#pragma clang diagnostic ignored "-Wundeclared-selector"
@implementation RecommendVC (UpdateVideo)
#pragma mark -
- (void)reloadPlayerWithLive:(MKVideoDemandModel *)live playerScrollView:(MKCPlayVideoView *)playerScrollView{

}
#pragma mark - 更新当前播放视频 信息
- (void)updateCurrentVideoInfo:(MKCPlayVideoView *)playerScrollView WithModel:(MKVideoDemandModel *)live{

}
/// NO 不播放  YES 播放
- (BOOL)isPlayVideo{
//    NSLog(@"当前播放类型===%lu --当前可见控制器 %@===",(unsigned long)self.mkVideoListType,[self.navigationController.visibleViewController className]);
    if (![self.navigationController.visibleViewController className]) { //  当前播放器的名字是Null,返回NO
        return NO;
    }
    if ([self.navigationController.visibleViewController className] == nil) { //  当前播放器的名字是nil,返回NO
        return NO;
    }
    switch (self.mkVideoListType) {
            
        case MKVideoListType_A:{ // 首页推荐列表
            if ([[self.navigationController.visibleViewController className] isEqualToString:[CustomSYSUITabBarController className]]) {
                return YES;
            }else{
                return NO;
            }
        }break;
        case MKVideoListType_B:{ // 关注列表
            if ([[self.navigationController.visibleViewController className] isEqualToString:[RecommendVC className]]) {
                return YES;
            }else{
                return NO;
            }
        }break;
        case MKVideoListType_C:
            if ([[self.navigationController.visibleViewController className] isEqualToString:[RecommendVC className]]) {
                return YES;
            }else{
                return NO;
            }
            break;
        case MKVideoListType_D:
//            NSLog(@"%@",[self.navigationController.visibleViewController className]);
            if ([[self.navigationController.visibleViewController className] isEqualToString:[RecommendVC className]]) {
                return YES;
            }else{
                return NO;
            }
            break;
    }
    return NO;
    
    
}

#pragma mark - 更新数据源
- (void)updateModel {
 
}

#pragma ma4k - 添加数据
- (void)addDataToArray:(NSMutableArray <MKVideoDemandModel *>*)array{
  
}
- (void)refreshVideoList{
   
}

#pragma ma4k - 拉取数据
- (void)getData{
    [[MKTools shared] addLoadingInView:self.view];
    @weakify(self)
    [self requestWith:0 WithPageNumber:1 WithPageSize:100 Block:^(id data) {
        [[MKTools shared] dissmissLoadingInView:self.view animated:YES];
        @strongify(self)
        if ((Boolean)data) {
            
            self.mkIndex = 0;
            
            [self addDataToArray:self.mkRecommend.list];
            
        }else{
            
            [self addtestData];
        }
    }];
}
#pragma mark - 本地测试数据
- (void)addtestData{
  
}
@end
#pragma clang diagnostic pop
