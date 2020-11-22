//
//  AppInfoTool.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/22.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "AppInfoTool.h"

@interface AppInfoTool()

@property(nonatomic,strong) NSDictionary *dict;

@end


static AppInfoTool *infotool=nil; //放入外部
@implementation AppInfoTool

+(instancetype)shareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infotool  = [[AppInfoTool alloc] init];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"appinfo" ofType:@"plist"];
          NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        infotool.dict = dictionary;
        
    });
    return infotool;
}

-(NSString *)channelUrl {
    NSString *channel = self.dict[@"channelUrl"];
    return channel;
}


@end
