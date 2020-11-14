//
//  MKPMView.h
//  MonkeyKingVideo
//
//  Created by admin on 2020/10/16.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^JCKMarqueeViewBlock) (NSInteger);
@interface MKPMView : UIView
@property(nonatomic,copy)JCKMarqueeViewBlock block;

@property(nonatomic,strong)NSArray *marqueeTitleArray;
@property(nonatomic,strong)NSArray *marqueeContentArray;

@property(nonatomic,assign)CGFloat animationDuration;//滚动时间
@property(nonatomic,assign)CGFloat pauseDuration;//停顿时间

- (void)start;
-(void)refreshSkin;
@end
