//
//  MKTaskPopView.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/9/29.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MKTaskPopViewBLOCK)(void);
@interface MKTaskPopView : UIView
@property (nonatomic,copy) MKTaskPopViewBLOCK popblock;
- (instancetype)initWithFrame:(CGRect)frame WithParameter:(NSString *)par;
@end

NS_ASSUME_NONNULL_END
