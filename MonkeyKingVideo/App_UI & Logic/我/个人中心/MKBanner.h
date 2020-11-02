//
//  MKBanner.h
//  MonkeyKingVideo
//
//  Created by hansong on 10/15/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKCarouselView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MKBanner : UIView
///
@property (strong,nonatomic) UIImageView *mkImageView;

///
@property (strong,nonatomic) TKCarouselView * mkCarouselView ;
@end

NS_ASSUME_NONNULL_END
