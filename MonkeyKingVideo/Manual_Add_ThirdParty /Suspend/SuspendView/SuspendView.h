//
//  SuspendView.h
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuspendView : UIView

@property(nonatomic,copy)MKDataBlock suspendViewBlock;

-(void)actionSuspendViewBlock:(MKDataBlock)suspendLabBlock;

@end

NS_ASSUME_NONNULL_END

/**
 使用方法：
 self.VIEW.vc = self;
 
 */
