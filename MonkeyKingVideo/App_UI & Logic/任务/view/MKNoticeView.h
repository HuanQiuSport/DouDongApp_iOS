//
//  MKNoticeView.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/2.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKNoticeView : UIView
@property(nonatomic,strong) NSArray<NSString *> *dataSource;
-(void)refreshSkin;
@end

NS_ASSUME_NONNULL_END
