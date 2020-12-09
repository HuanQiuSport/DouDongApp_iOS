//
//  MKVideoAdModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/23/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKVideoAdModel : JSONModel

///
@property (strong,nonatomic) NSString <Optional>*id;

/// 广告类型
@property (strong,nonatomic) NSString <Optional>*adType;

/// 广告名称
@property (strong,nonatomic) NSString <Optional>*adName;

/// 广告站点
@property (strong,nonatomic) NSString <Optional>*adSite;

/// 广告开始时间
@property (strong,nonatomic) NSString <Optional>*startTime;

/// 广告结束时间
@property (strong,nonatomic) NSString <Optional>*endTime;

///  广告视频 封面
@property (strong,nonatomic) NSString <Optional>*adImg;

/// 广告跳转链接
@property (strong,nonatomic) NSString <Optional>*adLink;

/// 广告下载链接
@property (strong,nonatomic) NSString <Optional>*adDownload;

/// 广告视频 播放地址
@property (strong,nonatomic) NSString <Optional>*adVideoUrl;

/// 广告视频 是否有效
@property (strong,nonatomic) NSString <Optional>*isValid;

///
@property (strong,nonatomic) NSString <Optional>*remark;

/// 广告创建时间
@property (strong,nonatomic) NSString <Optional>*createTime;
/// 广告更新时间
@property (strong,nonatomic) NSString <Optional>*createUser;
/// 广告创建用户
@property (strong,nonatomic) NSString <Optional>*updateTime;

/// 广告更新用户
@property (strong,nonatomic) NSString <Optional>*updateUser;

/// 广告是否可以跳转
@property (strong,nonatomic) NSString <Optional>*canSkip;

/// 关注按钮
@property (strong,nonatomic) NSString <Optional>*opType;

/// 广告logo图片
@property (strong,nonatomic) NSString <Optional>*logoImg;

///  
@property (strong,nonatomic) NSString <Optional>*spreadVideo;

@end

NS_ASSUME_NONNULL_END
