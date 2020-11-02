//
//  MKShareView.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MKShareViewBLOCK)(NSString *str);
@interface MKShareView : UIView
@property (nonatomic,copy) MKShareViewBLOCK shareblock;
@property (nonatomic,assign) BOOL isPlaying;
/**
 显示
 */
- (void)showWithViedo:(NSString *)imgurl AndInviteInfo:(NSDictionary *)inviteDic;
/**
 关闭
*/
- (void)removeChildView;
@end

NS_ASSUME_NONNULL_END
