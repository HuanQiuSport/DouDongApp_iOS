//
//  RecommendVC+ActiveUser.m
//  MonkeyKingVideo
//
//  Created by george on 2020/10/2.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "RecommendVC+ActiveUser.h"

@implementation RecommendVC (ActiveUser)

- (void) activeStart{
    __block int i = 0 ;
    self.activeTimer  =  [YYTimer timerWithTimeInterval:60*10  repeats:YES usingBlock:^(YYTimer * _Nonnull timer) {
        i++;
        if (i <= 1) return;
        NSDate *nowDate = [NSDate date];
        NSDate *oldDate = GetUserDefaultObjForKey(@"oldDate");

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];

        NSString *oldDateString = [dateFormatter stringFromDate:oldDate];
        NSString *nowDateString = [dateFormatter stringFromDate:nowDate];

        if (![oldDateString isEqualToString:nowDateString]) {
            SetUserDefaultKeyWithObject(@"oldDate", nowDate);
            [self sendActiveUser];
            [self.activeTimer invalidate];
        }else{
//            NSLog(@"不调用");
            [self.activeTimer invalidate];
        }
    }];
}

@end
