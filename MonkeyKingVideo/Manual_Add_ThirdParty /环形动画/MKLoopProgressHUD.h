//
//  MKLoopProgressHUD.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/5.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKLoopProgressHUD : UIView

@property (nonatomic,strong) UIColor *strokeColor; // 圆的线条颜色
@property (nonatomic,strong) NSString *titleStr; // 描述文字
@property (nonatomic,strong) UIImage *imge; // 圆内Logo
@property (nonatomic,assign) CGFloat width; // 提示框 w
@property (nonatomic,assign) CGFloat height; // 提示框 h
@property (nonatomic,assign) CGFloat radius; // 圆半径


+ (id)shareInstance;
- (void)shows:(NSString *)progressStr;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
