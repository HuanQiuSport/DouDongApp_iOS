//
//  AppDelegate.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//  c

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,strong) UIWindow *window;
@property(nonatomic,strong)UINavigationController *navigationController;
@property(nonatomic,strong)CustomSYSUITabBarController *customSYSUITabBarController;

+ (AppDelegate *)sharedInstance;
- (void)saveContext;



@end

