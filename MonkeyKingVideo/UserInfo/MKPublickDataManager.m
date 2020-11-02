//
//  MKPublickDataManager.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/12/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKPublickDataManager.h"
static MKPublickDataManager *static_publicDataManage = nil;
@interface MKPublickDataManager()
@property (strong,nonatomic) NSString *mkAccno;

@end

@implementation MKPublickDataManager
@synthesize isShowComment = _isShowComment;
+ (MKPublickDataManager *) sharedPublicDataManage
{
    @synchronized(self){
        if ( nil == static_publicDataManage ) {
            static_publicDataManage = [[MKPublickDataManager alloc] init];
        }
    }
    return static_publicDataManage;
}
#pragma mark - 登录model
- (MKLoginModel *)mkLoginModel{
    MKLoginModel *bdmodel = [[MKLoginModel getUsingLKDBHelper] searchSingle:[MKLoginModel class] where:nil orderBy:nil];
    return bdmodel;
}
#pragma mark - 推荐列表 当前播放视频信息
- (NSMutableString *)currentVideoString{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"currentVideoString"];
}
- (void)setCurrentVideoString:(NSMutableString *)currentVideoString{
    [[NSUserDefaults standardUserDefaults]setValue:currentVideoString forKey:@"currentVideoString"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
#pragma mark - 推荐列表 当前播放视频用户信息

- (NSMutableString *)currentVideoUserString{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"currentVideoUserString"];;
}
- (void)setCurrentVideoUserString:(NSMutableString *)currentVideoUserString{
    [[NSUserDefaults standardUserDefaults]setValue:currentVideoUserString forKey:@"currentVideoUserString"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
#pragma mark - isShowComment
- (void)setIsShowComment:(BOOL)isShowComment {
    _isShowComment = isShowComment;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_isShowComment] forKey:@"isShowComment"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (BOOL)isShowComment {
    
    NSUserDefaults *userfault=[NSUserDefaults standardUserDefaults];
    _isShowComment = [[userfault objectForKey:@"isShowComment"] integerValue];
    return _isShowComment;
}

@end
