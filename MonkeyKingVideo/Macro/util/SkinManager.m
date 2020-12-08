//
//  SkinManager.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/12.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "SkinManager.h"

static SkinManager *manager=nil; //放入外部
@implementation SkinManager


+(instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SkinManager alloc] init];
    });
    return manager;
}

@end
