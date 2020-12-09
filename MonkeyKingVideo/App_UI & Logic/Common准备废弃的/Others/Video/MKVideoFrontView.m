

//
//  MKVideoFrontView.m
//  MonkeyKingVideo
//
//  Created by hansong on 9/1/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKVideoFrontView.h"
#import "MKPlayUserInfoView.h"
#import "MKVideoDemandModel.h"
@implementation MKVideoFrontView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mkImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
        self.mkImageView.image = KIMG(@"av.png");
        self.mkImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:self.mkImageView];
        
        
        self.mkUserInfoView = [[MKPlayUserInfoView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.mkUserInfoView];
        self.mkUserInfoView.hidden = NO;
    }
    return self;
}
- ( MKVideoDemandModel*)mkLive{
    
    if (!_mkLive) {
        
        _mkLive = [[MKVideoDemandModel alloc]init];
    }
    return _mkLive;
}
- (void)updatePageInfo:(MKPlayUserInfoView *)playerScrollView WithModel:(MKVideoDemandModel *)live{
    
}
@end
