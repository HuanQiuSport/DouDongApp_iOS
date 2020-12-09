//
//  MKVideoInfoModel.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/8/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 视频信息
@interface MKVideoInfoModel : JSONModel
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
/// 视频大小
@property (nonatomic, strong) NSString<Optional> *videoSize;
/// 视频时间
@property (nonatomic, strong) NSString<Optional> *videoTime;
/// 视频标题
@property (nonatomic, strong) NSString<Optional> *videoTitle;


@property (nonatomic, strong) NSString<Optional> *isPraise;


@property (nonatomic, strong) NSString<Optional> *isAttention;

@end

NS_ASSUME_NONNULL_END
