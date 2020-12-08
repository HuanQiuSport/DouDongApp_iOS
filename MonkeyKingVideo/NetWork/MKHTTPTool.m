//
//  MKHTTPTool.m
//  MonkeyKingVideo
//
//  Created by xxx on 2020/11/2.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKHTTPTool.h"
#import "MKTools.h"
#import "MKPublickDataManager.h"

@interface MKHTTPTool()

@property(nonatomic,strong) AFHTTPSessionManager *manager;

@property(nonatomic,strong) AFURLSessionManager *sessionManager;

@end

static MKHTTPTool *tool=nil; //放入外部
@implementation MKHTTPTool


+(instancetype)shareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool  = [[MKHTTPTool alloc] init];
        tool.manager = [AFHTTPSessionManager manager];
        tool.manager.operationQueue.maxConcurrentOperationCount = 5;
        tool.manager.requestSerializer.timeoutInterval = 20;
        tool.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        tool.manager.responseSerializer = [AFJSONResponseSerializer serializer];
//        tool.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain",@"text/html",@"text/javascript", nil];
//        [tool.manager.requestSerializer setValue:@"video/mp4" forHTTPHeaderField:@"Content-Type"];
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        tool.sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        tool.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    return tool;
}



//上传图片
-(void)uploadVideoData:(NSData *)data
                  path:(NSString *)path
              progress:(void(^)(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend))uploadProgress
              callBack:(void(^)(bool status, NSError *error))callBack {
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]
//          cachePolicy:NSURLRequestUseProtocolCachePolicy
//          timeoutInterval:120];
//        NSDictionary *headers = @{
//            @"Content-Type": @"video/mp4",
//        };
//        [request setAllHTTPHeaderFields:headers];
//        [request setHTTPMethod:@"PUT"];
//        [request setHTTPBody:data];
//        NSURLSession *session = [NSURLSession sharedSession];
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
//        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//          if (error) {
//              callBack(false,error);
//          } else {
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
//            if(httpResponse.statusCode == 200) {
//                callBack(true,nil);
//            } else {
//                NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:httpResponse.statusCode userInfo:nil];
//                callBack(false,error);
//            }
//          }
//        }];
//        [dataTask resume];
//    });
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:120];
    NSDictionary *headers = @{
        @"Content-Type": @"video/mp4",
    };
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
    CGFloat totalSize = data.length;
    NSURLSessionDataTask *task = [_manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"uploadProgress = %@",uploadProgress);
        CGFloat _percent = uploadProgress.fractionCompleted * 100;
        CGFloat totalsize = totalSize /(1024.0*1024.0);
        NSString *str = [NSString stringWithFormat:@"上传文件中...%.2f",_percent];
        NSLog(@"%@ -- %.2f -- %.2f",str,uploadProgress.fractionCompleted,totalsize);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            /* 加圈圈
             // 屏蔽加载框
             dispatch_async(dispatch_get_main_queue() , ^{
             UIView *view = [[UIApplication sharedApplication].windows lastObject];
             MBProgressHUD *hub = (MBProgressHUD *)[view viewWithTag:999];
             [hub hide:YES];
             });
             
             */
            [[MKTools shared] addLoadingInViewForUploadWithText:[NSString stringWithFormat:@"%.2fM/%.2fM",uploadProgress.fractionCompleted * totalsize,totalsize]];
            
        }];
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
          if (error) {
              callBack(false,error);
          } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if(httpResponse.statusCode == 200) {
                callBack(true,nil);
            } else {
                NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:httpResponse.statusCode userInfo:nil];
                callBack(false,error);
            }
          }
    }];
    [task resume];
    
}

@end
