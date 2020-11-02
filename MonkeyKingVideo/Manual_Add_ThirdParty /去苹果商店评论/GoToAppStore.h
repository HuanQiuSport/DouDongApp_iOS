//
//  GoToAppStore.h
//  MonkeyKingVideo
//
//  Created by hansong on 9/29/20.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoToAppStore : NSObject<UIAlertViewDelegate>
{
    #if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    
    UIAlertView *alertViewTest;
    
    #else
    
    UIAlertController *alertController;
    
    #endif
    

}

@property (nonatomic,strong) NSString * myAppID;//appID


- (void)showGotoAppStore:(UIViewController *)VC;
@end

NS_ASSUME_NONNULL_END
