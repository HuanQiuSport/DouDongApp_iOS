//
//  MKSingeUserCenterVC+Net.h
//  MonkeyKingVideo
//
//  Created by hansong on 8/14/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKSingeUserCenterVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKSingeUserCenterVC (Net)
#pragma mark - 获取基本信息
-(void)getDataUserData:(NSString *)authorId
                 Block:(MKDataBlock)block;

#pragma mark - 视频列表数据
-(void)requestWith:(NSInteger)type
    WithPageNumber:(NSInteger)pageNumber
      WithPageSize:(NSInteger)pageSize
             Block:(MKDataBlock)block;

#pragma mark - 添加关注 ｜ 取消关注
-(void)requestAttentionWith:(NSString*)userID
                  WithBlock:(MKDataBlock)block;
#pragma mark - 获取用户关注详情  GET 删除
-(void)requestDeleteAttentionWith:(NSString*)userID
                        WithBlock:(MKDataBlock)block;

#pragma mark - 添加黑名单
- (void)requestAddBlackListWith:(NSString*)userID WithBlock:(MKDataBlock)block;

#pragma mark - 获取用户详情
- (void)requestAttentionDetailWith:(NSString*)userID WithBlock:(MKDataBlock)block;

@end

NS_ASSUME_NONNULL_END
