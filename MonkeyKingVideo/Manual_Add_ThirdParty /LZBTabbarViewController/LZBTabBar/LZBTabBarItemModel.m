//
//  LZBTabBarItemModel.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/12.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "LZBTabBarItemModel.h"

@implementation LZBTabBarItemModel

-(instancetype)initWith:(NSString *)selectImage
          unselectImage:(NSString *)unselectImage
                  title:(NSString *)title
       selectTitleColor:(UIColor *)selectTitleColor
     unselectTitleColor:(UIColor *)unselectTitleColor {
    if(self = [super init]) {
        _selectImage = [UIImage imageNamed:selectImage];
        _unselectImage = [UIImage imageNamed:unselectImage];
        _title = title;
        _selectTitleColor = selectTitleColor;
        _unselectTitleColor = unselectTitleColor;
    }
    return self;
}

@end
