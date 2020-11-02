//
//  MKCloseButton.m
//  MonkeyKingVideo
//
//  Created by hansong on 6/28/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKCloseButton.h"

@implementation MKCloseButton

- (instancetype)init{
    if (self = [super init]) {
        [self setImage:KIMG(@"关闭")
              forState:UIControlStateNormal];
    }return self;
}

@end
