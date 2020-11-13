//
//  LZBTabBarItemModel.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/12.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZBTabBarItemModel : NSObject

@property(nonatomic,strong) UIImage *selectImage;
@property(nonatomic,strong) UIImage *unselectImage;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) UIColor *selectTitleColor;
@property(nonatomic,strong) UIColor *unselectTitleColor;


-(instancetype)initWith:(NSString *)selectImage
          unselectImage:(NSString *)unselectImage
                  title:(NSString *)title
       selectTitleColor:(UIColor *)selectTitleColor
     unselectTitleColor:(UIColor *)unselectTitleColor;

@end

NS_ASSUME_NONNULL_END
