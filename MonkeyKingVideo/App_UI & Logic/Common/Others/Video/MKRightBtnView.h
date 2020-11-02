//
//  MKRightBtnView.h
//  MonkeyKingVideo
//
//  Created by hansong on 7/5/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKImageBtnVIew.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKRightBtnView : UIView
///  赞
@property (strong,nonatomic) MKImageBtnVIew *mkZanView;
///  评
@property (strong,nonatomic) MKImageBtnVIew *mkCommentView;
///  分享
@property (strong,nonatomic) MKImageBtnVIew *mkShareView;

@end

NS_ASSUME_NONNULL_END
