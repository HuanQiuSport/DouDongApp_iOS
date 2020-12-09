//
//  MKVideoDemandModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/8/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JSONModel.h"

@protocol MKVideoDemandModel <NSObject>
@end

NS_ASSUME_NONNULL_BEGIN
/// 视频列表信息
@interface MKVideoDemandModel : JSONModel





/// 作者
@property (nonatomic, strong) NSString<Optional> *author;
/// 作者ID
@property (nonatomic, strong) NSString<Optional> *authorId;
/// 评论数
@property (nonatomic, strong) NSString<Optional> *commentNum;
/// 头像
@property (nonatomic, strong) NSString<Optional> *headImage;

/// 播放数
@property (nonatomic, strong) NSString<Optional> *playNum;

/// 点赞数
@property (nonatomic, strong) NSString<Optional> *praiseNum;

/// 发布时间
@property (nonatomic, strong) NSString<Optional> *publishTime;

/// 视频id
@property (nonatomic, strong) NSString<Optional> *videoId;

/// 视频地址
@property (nonatomic, strong) NSString<Optional> *videoIdcUrl;

/// 封面图片
@property (nonatomic, strong) NSString<Optional> *videoImg;

///视频大小
@property (nonatomic, strong) NSString<Optional> *videoSize;

/// 视频时间
@property (nonatomic, strong) NSString<Optional> *videoTime;

/// 视频标题
@property (nonatomic, strong) NSString<Optional> *videoTitle;


@property (nonatomic, strong) NSString<Optional> *isPraise;


@property (nonatomic, strong) NSString<Optional> *isAttention;

/// 自定义类型 0 视频  1 广告
@property (nonatomic, strong) NSString<Optional> *mkCustomtype;
// 自定义类型 0 跳转至直播视频  1 跳转至广告
@property (nonatomic, strong) NSString<Optional> *nextLinkUrl;
// 1 用户自己 ｜  0 其他人
@property (nonatomic, strong) NSString<Optional> *areSelf;
//0待审核 1审核通过 2审核不通过
@property (nonatomic, strong)NSString <Optional> *videoStatus;

@property (nonatomic,strong) NSString <Optional> *isVip;
@end
NS_ASSUME_NONNULL_END
