//
//  main.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


int main(int argc, char * argv[]) {
    NSString *appDelegateClassName;
    @autoreleasepool {                                                                                                                                          
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }

    return UIApplicationMain(argc, argv, nil,appDelegateClassName);
}
