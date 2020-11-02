//
//  SDVideoMenuDataModel.m
//  SDVideoCameraDemo
//
//  Created by 王巍栋 on 2020/4/15.
//  Copyright © 2020 骚栋. All rights reserved.
//

#import "SDVideoMenuDataModel.h"

@implementation SDVideoMenuDataModel

- (void)setMenuType:(VideoMenuType)menuType {

    _menuType = menuType;
    
    NSArray *normalImageNameArray = @[@"翻转镜头"];
    NSArray *selectImageNameArray = @[@"翻转镜头"];
    NSArray *normalTitleArray = @[@""];
    NSArray *selectTitleArray = @[@""];
    
    self.normalImageName = normalImageNameArray[menuType];
    self.selectImageName = selectImageNameArray[menuType];
    self.normalTitle = normalTitleArray[menuType];
    self.selectTitle = selectTitleArray[menuType];
}


@end
