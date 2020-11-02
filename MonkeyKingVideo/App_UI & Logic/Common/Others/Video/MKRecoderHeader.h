//
//  MKRecoderHeader.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/10/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#ifndef MKRecoderHeader_h
#define MKRecoderHeader_h

#define kCommonFont(fSize) [UIFont systemFontOfSize:fSize]

#import "UIView+SDAutoLayout.h"
#import "Masonry.h"
#import "UIButton+Block.h"

typedef NS_ENUM(NSUInteger, UPLOADSTATUS) {
    UPLOAD_NORMAL,
    UPLOAD_ING,
    UPLOAD_SUCCESS,
    UPLOAD_FAILE,
    UPLOAD_SUCCESS_TITLE,
};
#pragma mark 視頻錄製相關
#define KLocalVideoName [NSString stringWithFormat:@"%@%@",@"jhdajdnanjdas",@"12345678"]//本地視頻名稱[PublicDataManage sharedPublicDataManage].accno

#define KUploadVideoSuccessNotification @"KUploadVideoSuccessNotification"    //短視訊上傳成功通知
#define KUploadVideoFailedNotification @"KUploadVideoFailedNotification"    //短視訊上傳失敗通知
#define KUploadVideoIngNotification @"KUploadVideoIngNotification"    //短視訊上傳中通知
#define kHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ADAPTATIONRATIO     SCREEN_WIDTH / 750.0f

#define GKColorRGBA(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]
#define GKColorRGB(r, g, b)     GKColorRGBA(r, g, b, 1.0)

#endif /* MKRecoderHeader_h */
