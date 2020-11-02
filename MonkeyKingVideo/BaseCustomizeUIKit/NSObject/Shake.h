//
//  Shake.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/21.
//  Copyright © 2020 Jobs. All rights reserved.
//

//https://www.jianshu.com/p/50d567736fb6
//模拟器中运行时，可以通过「Hardware」-「Shake Gesture」来测试「摇一摇」功能

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///系统方法
@interface Shake_SYS : NSObject

@end

///加速仪  。
/*
 *  当App退到后台时必须停止加速仪更新
 *  回到当前时重新执行
 *  否则应用在退到后台依然会接收加速度更新
 *  可能会与其它当前应用冲突
 *  产生不好的体验
 */
@interface Shake_CoreMotion : NSObject

-(instancetype)initWhenViewDidAppear;//在viewDidAppear实现
-(void)stopAccelerometerWhenViewDidDisappear;

@end

NS_ASSUME_NONNULL_END
