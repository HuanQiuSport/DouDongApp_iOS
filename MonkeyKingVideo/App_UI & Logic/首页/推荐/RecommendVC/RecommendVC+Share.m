//
//  RecommendVC+Share.m
//  MonkeyKingVideo
//
//  Created by hansong on 8/20/20.
//  Copyright © 2020 Jobs. All rights reserved.
//


#import "RecommendVC+Private.h"
#import "RecommendVC+Share.h"
@implementation RecommendVC (Share)
///分享弹窗
-(void)MakeShareView{
    if ([MKTools mkLoginIsYESWith:self]){
        @weakify(self)
        [self reuestShareData:^(id data, id data2) {
            @strongify(self)
            if ((Boolean)data) {
                
                // 判断如果在播放，分享时视频停止
                self.mkshareview.isPlaying = NO;
                
                if (self.player.currentPlayerManager.isPlaying) {
                    [self.player.currentPlayerManager pause];
                    self.mkshareview.isPlaying = YES;
                }
                
                [self.mkshareview showWithViedo:self.videoDemandModel.videoImg AndInviteInfo:data2];
                self.mkshareview.shareblock = ^(NSString * _Nonnull str) {
//                    NSLog(@"%@",str);
                    @strongify(self)
                    // 判断如果不是手动暂停就保持原来状态
                    if ([str isEqualToString:@"play"]) {
                        [self.player.currentPlayerManager play];
//                        if (self.mkFirstPlay) {
//                            [self.mkShuaCoinView startAddCoin];
//                            [self.mkDiamondsView startAddDiamond];
//                        }
                    }
                };
            }
        }];
    }
    
}

@end
