//
//  MKTaskVerticalView.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/2.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKTaskVerticalView : UIView

@property(nonatomic,strong) NSArray<NSString *> *dataSource;

-(instancetype)initWithFrame:(CGRect)frame;
-(void)refreshSkin;
@end

NS_ASSUME_NONNULL_END
