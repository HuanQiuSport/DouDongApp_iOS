//
//  SkinManager.h
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/12.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MKSkinBlack, // 黑色皮肤
    MKSkinWhite, // 白色皮肤
} MKSkin;

NS_ASSUME_NONNULL_BEGIN

@interface SkinManager : NSObject

@property(nonatomic,assign) MKSkin skin;

+(instancetype)manager;



@end

NS_ASSUME_NONNULL_END
