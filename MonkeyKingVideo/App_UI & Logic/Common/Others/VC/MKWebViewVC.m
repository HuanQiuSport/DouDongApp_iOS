//
//  MKWebViewVC.m
//  MonkeyKingVideo
//
//  Created by hansong on 7/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKWebViewVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

#import <WebKit/WebKit.h>
#import "MyCoinVC.h"
#import "MyWalletDetailVC.h"

@interface MKWebViewVC ()<WKScriptMessageHandler,WKNavigationDelegate,WKUIDelegate,NSURLConnectionDelegate>
{
    BOOL _authenticated;    //是否认证
    NSURLConnection *_urlConnection;
    NSURLRequest *_request;
}
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation MKWebViewVC
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KLoginSuccessNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KRegisSuccessNotifaction object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = HEXCOLOR(0xEEEEEE);//[UIColor whiteColor];
    
    [SceneDelegate sharedInstance].customSYSUITabBarController.lzb_tabBarHidden = YES;
    
    
//     [MKTools showLoadingView:nil];
    
     [self addProgressView];
    
       [self initData];
    
//     [self setTitle:_strtitle];
    
//    [self loadNavItems];
    
//    [self addViews];
    CGRect frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.width = kScreenWidth;
    frame.size.height = kScreenHeight;
    self.view.layer.masksToBounds = NO;
    
    frame.origin.x = 0;
    // 设置偏好设置
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    //是否支持JavaScript
    config.preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;

    self.webView = [[WKWebView alloc] initWithFrame:frame configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];

    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *_request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:_request];

    WKUserContentController *userCC = config.userContentController;
    //JS调用OC 添加处理脚本

    /* 返回设置 */
    [userCC addScriptMessageHandler:self name:@"BackToSetting"];
    /* 返回我的 */
    [userCC addScriptMessageHandler:self name:@"BackToMine"];
    /* 复制 */
    [userCC addScriptMessageHandler:self name:@"toCopyText"];
    /* 邀请好友 */
    [userCC addScriptMessageHandler:self name:@"inviteFriends"];
 
    /* 邀请链接 */
    [userCC addScriptMessageHandler:self name:@"link"];
    /* 微信 */
    [userCC addScriptMessageHandler:self name:@"wechat"];
    /* qq */
    [userCC addScriptMessageHandler:self name:@"qq"];
    /* 保存图片 */
    [userCC addScriptMessageHandler:self name:@"SaveQrcode"];
    /*去兑换*/
    [userCC addScriptMessageHandler:self name:@"JumpToChange"];
    
    /*提现*/
    [userCC addScriptMessageHandler:self name:@"withdraw"];
    /* 分享链接  */
    [userCC addScriptMessageHandler:self name:@"shareUrl"];
    /* 绑定银行卡  */
    [userCC addScriptMessageHandler:self name:@"bankCard"];
    
    //    [self changeAgent];
        
    //    [self addNotifaction];
    if ([_url containsString:@"?"]) {
//              NSLog(@"链接包含参数");
//              if (![NSString isNilOrEmpty:[PublicDataManage sharedPublicDataManage].token]) {
//                  _url = [NSString stringWithFormat:@"%@&%@",_url,KTokenString];
//              }
//          } else {
//              NSLog(@"链接不包含参数");
//              if (![NSString isNilOrEmpty:[PublicDataManage sharedPublicDataManage].token]) {
//                  _url = [NSString stringWithFormat:@"%@?%@",_url,KTokenString];
//              }
          }
//       _webView.scalesPageToFit = YES;
       _webView.backgroundColor = HEXCOLOR(0xEEEEEE);
       if (isiPhoneX || isiPhoneXR__XMax) {
           if (@available(iOS 11.0, *)) {
               _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
           }
       }
     [[MKTools shared] addLoadingInView:self.view];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _webView.opaque = NO;
    _webView.backgroundColor = RGBCOLOR(36,42,55);
//    [self.navigationController.navigationBar addSubview:_progressView];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSURL *url = [NSURL URLWithString:_url];
    _request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:_request];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [_progressView removeFromSuperview];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initData {
    _authenticated = NO;
}

- (void)addProgressView{
//    _progressProxy = [[NJKWebViewProgress alloc] init];
//    _webView.delegate = _progressProxy;
//    _progressProxy.webViewProxyDelegate = self;
//    _progressProxy.progressDelegate = self;
//
//    CGFloat progressBarHeight = 2.f;
//    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
//    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
//    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
//    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
//    [_progressView setProgress:0 animated:YES];
}

- (void)loadNavItems
{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton * backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 56, 44)];
    [backItem setImage:[UIImage imageNamed:@"Public_Back"] forState:UIControlStateNormal];
    [backItem setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
//    if (kIOSVersions >=11.0) {
//        backItem.imageEdgeInsets = UIEdgeInsetsMake(0, -38.5, 0, 0);
//    }

    [backItem setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [backItem setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
    [backItem addTarget:self action:@selector(clickedBackItem:) forControlEvents:UIControlEventTouchUpInside];
//    _backItem = backItem;
    [backView addSubview:backItem];
    
    UIButton * closeItem = [[UIButton alloc]initWithFrame:CGRectMake(44, 0, 44, 44)];
    [closeItem setTitle:@"关闭" forState:UIControlStateNormal];
    [closeItem setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [closeItem addTarget:self action:@selector(clickedCloseItem:) forControlEvents:UIControlEventTouchUpInside];
    closeItem.hidden = YES;
//    _closeItem = closeItem;
    [backView addSubview:closeItem];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = KNavigationItemSpace;

    UIBarButtonItem * leftItemBar = [[UIBarButtonItem alloc]initWithCustomView:backView];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftItemBar];
}
- (void)addViews {
}

- (void)changeAgent {
    [self.webView evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSString *userAgent = result;
        
        if (isPad) {
            NSString *customUserAgent = [userAgent stringByReplacingOccurrencesOfString:@"iPad" withString:@"XKZB Iphone"];
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":customUserAgent}];

        } else if((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)) {
            NSString *customUserAgent = [userAgent stringByReplacingOccurrencesOfString:@"iPhone" withString:@"XKZB Iphone"];
            [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":customUserAgent}];
        }
    }];
}
- (void)addNotifaction {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:KLoginSuccessNotifaction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(regisSuccess) name:KRegisSuccessNotifaction object:nil];
}

- (void)loginSuccess {
//    NSLog(@"通知登录成功");
//    [self regisSuccess];
}
- (void)regisSuccess {
//    NSLog(@"通知注册成功");
    
//    if ([_url containsString:@"?"]) {
//        NSLog(@"链接包含参数");
//        if (![NSString isNilOrEmpty:[PublicDataManage sharedPublicDataManage].token]) {
//            _url = [NSString stringWithFormat:@"%@&%@",_url,KTokenString];
//        }
//    } else {
//        NSLog(@"链接不包含参数");
//        if (![NSString isNilOrEmpty:[PublicDataManage sharedPublicDataManage].token]) {
//            _url = [NSString stringWithFormat:@"%@?%@",_url,KTokenString];
//        }
//    }

    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}
#pragma mark 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"页面开始加载时调用");
}
#pragma mark 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
 
    
//    NSLog(@"当内容开始返回时调用");
}

#pragma mark 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
//    self.title = self.titleStr;
//    NSLog(@"页面加载完成之后调用");
    [[MKTools shared] dissmissLoadingInView:self.view animated:YES];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:webView.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *tmpresponse = (NSHTTPURLResponse*)response;
//        NSLog(@"statusCode:%ld", tmpresponse.statusCode);
        if (tmpresponse.statusCode != 200) {
            // 页面报错
            WeakSelf
            dispatch_async(dispatch_get_main_queue() , ^{
                [MBProgressHUD wj_showError:@"服务器发生未知错误"];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
            
        }
    }];
    [dataTask resume];
}
#pragma mark 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"页面加载失败时调用");
    [[MKTools shared] dissmissLoadingInView:self.view animated:YES];
}
#pragma mark 接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
//    NSLog(@"接收到服务器跳转请求之后再执行");
}
#pragma mark 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
//    NSLog(@"收到响应后 === %@",navigationResponse);
    WKNavigationResponsePolicy actionPolicy = WKNavigationResponsePolicyAllow;
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
    
}
#pragma mark 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    // 拦截请求头，重新添加请求头信息
    NSMutableURLRequest *mutableRequest = [navigationAction.request mutableCopy];
    NSDictionary *requestHeaders = navigationAction.request.allHTTPHeaderFields;

//    NSLog(@"发送请求之前 === %@",navigationAction);

//    NSLog(@"发送请求之前重新添加请求头信息 === %@ || %@",requestHeaders,requestHeaders);



    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;

    NSString *urlstring = navigationAction.request.URL.absoluteString;
    _request = navigationAction.request;

    NSURLRequest *request = _request;
//    NSLog(@"发送请求之前============WKURL:%@",urlstring);


    //这句是必须加上的，不然会异常
    decisionHandler(WKNavigationActionPolicyAllow);

}
#pragma mark - WLScriptMessageHandler
// 释放WKUserContentController代码
-(void)removeAllScriptMsgHandle{
    WKUserContentController *controller = self.webView.configuration.userContentController;
    [controller removeScriptMessageHandlerForName:@"BackToSetting"];
    [controller removeScriptMessageHandlerForName:@"BackToMine"];
    [controller removeScriptMessageHandlerForName:@"toCopyText"];
    [controller removeScriptMessageHandlerForName:@"inviteFriends"];
 
    [controller removeScriptMessageHandlerForName:@"link"];
    /* 微信 */
    [controller removeScriptMessageHandlerForName:@"wechat"];
    /* qq */
    [controller removeScriptMessageHandlerForName:@"qq"];
    [controller removeScriptMessageHandlerForName:@"SaveQrcode"];
    [controller removeScriptMessageHandlerForName:@"JumpToChange"];
    
    [controller removeScriptMessageHandlerForName:@"withdraw"];
    [controller removeScriptMessageHandlerForName:@"shareUrl"];
    /* 绑定银行卡  */
     [controller removeScriptMessageHandlerForName:@"bankCard"];
}

//js交互方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    /*
     NSLog(@"%@",message.name);//方法名
     NSLog(@"%@",message.body);//传递的数据
     */
    NSLog(@"方法名  %@",message.name);//方法名
    NSLog(@"传递的数据  %@",message.body);//传递的数据
    if ([message.name isEqualToString:@"BackToSetting"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([message.name isEqualToString:@"withdraw"]) {
//        NSLog(@"点击了调用了。。withdraw");
        WeakSelf
        if ([MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:YES])
        {
            NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body];
            [MyWalletDetailVC ComingFromVC:weakSelf
                                      comingStyle:ComingStyle_PUSH
                                presentationStyle:UIModalPresentationAutomatic
                                    requestParams:@{
                                        @"MyWalletStyle":@(MyWalletStyle_CURRENTCOIN),
                                        @"balance":paramsDic[@"message"][@"balance"],
                                        @"goldNumber":paramsDic[@"message"][@"goldNumber"]
                                    }
                                          success:^(id data) {
                
            }
                                         animated:YES];
        }
        else
        {
            
            
          
        }
    }
    #pragma mark - 绑卡
    else if ([message.name isEqualToString:@"bankCard"])
    {
        [self.navigationController popViewControllerAnimated:YES];
//        NSLog(@"点击了调用了。。bankCard");
        NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body]; // 用该方法把web的参数Json转模型
        NSDictionary *dic = paramsDic[@"message"];
        self.webblock(dic);
        
    }
    #pragma mark - 分享链接
    else if ([message.name isEqualToString:@"shareUrl"]) {
//        NSLog(@"点击了调用了。。shareUrl");

        NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body]; // 用该方法把web的参数Json转模型
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string= [NSString stringWithFormat:@"%@",paramsDic[@"message"][@"shareUrl"]];
        [MBProgressHUD wj_showPlainText:@"复制成功，快去分享吧" view:self.view];
    }
    else if ([message.name isEqualToString:@"BackToMine"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    #pragma mark - 跳转兑换
    else if ([message.name isEqualToString:@"JumpToChange"])
    {
//        NSLog(@"点击了调用了。。JumpToChange");
        WeakSelf
        if ([MKTools mkLoginIsYESWith:weakSelf WithiSNeedLogin:YES])
        {
            NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body];
            [MyCoinVC ComingFromVC:weakSelf
                                      comingStyle:ComingStyle_PUSH
                                presentationStyle:UIModalPresentationAutomatic
                                    requestParams:@{
                                        @"MyWalletStyle":@(MyWalletStyle_CURRENTCOIN),
                                        @"balance":paramsDic[@"message"][@"balance"],
                                        @"goldNumber":paramsDic[@"message"][@"goldNumber"]
                                    }
                                          success:^(id data) {
                
            }
                                         animated:YES];
        }
        else
        {
            
            
          
        }
    }
    else if ([message.name isEqualToString:@"toCopyText"])
    {
 
                //        NSDictionary *paramsDic = [self getURLParameters:request.URL.absoluteString];
                NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body]; // 用该方法把web的参数Json转模型
        //        NSString *inviteCode = [paramsDic objectForKey:@"inviteCode"];//edEnvelope
//                NSLog(@"点击了调用了。。link| %@ | %@|",paramsDic[@"message"][@"inviteCode"],message.body);
                //          http://172.24.135.208/taskpage/InvitFriends?toUrl=toCopyText&invitCode=4HQ54A
                UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string= [NSString stringWithFormat:@"%@",paramsDic[@"message"][@"inviteCode"]];

                [MBProgressHUD wj_showPlainText:@"已复制" view:self.view];
    }
    else if ([message.name isEqualToString:@"inviteFriends"])
    {
        NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body];
        NSString *toUrl = [paramsDic objectForKey:@"inviteCode"];
        NSString *inviteCode = [paramsDic objectForKey:@"inviteCode"];
        NSString *edEnvelope = [paramsDic objectForKey:@"edEnvelope"];
        NSString *url = [paramsDic objectForKey:@"url"];
        NSString *type = [paramsDic objectForKey:@"type"];
        
        NSString *pasteCopyStr = [NSString stringWithFormat:@"点击【%@】\n下载%@,\n填我的邀请码【%@】\n领取最高【%@元】红包,红包立即提现，复制信息进入%@\n自动填邀请码领取",url,@"抖动App",inviteCode,edEnvelope,@"抖动App"];
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string= pasteCopyStr;
        if([type isEqualToString:@"wechat"])
        {
            [MKTools openWechatWith:self.view];
            
        }
        else if([type isEqualToString:@"qq"])
        {
           [MKTools openQQWith:self.view];
        }
        else if([type isEqualToString:@"qrcode"])
        {
            
        }
        else if([type isEqualToString:@"link"])
        {
//            NSLog(@"点击了调用了。。link| %@ | %@|",message.name,message.body);
            [MBProgressHUD wj_showPlainText:@"已复制" view:self.view];
               
        }
 
        
    }
    else if ([message.name isEqualToString:@"qq"])
    {
//        NSLog(@"点击了调用了。。inviteFriends");
        NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body];
        NSDictionary *messageDic = paramsDic[@"message"];
        NSString *inviteCode = [messageDic objectForKey:@"inviteCode"];
        NSString *edEnvelope = [messageDic objectForKey:@"redEnvelope"];
        NSString *url = [messageDic objectForKey:@"url"];
        
        NSString *pasteCopyStr = [NSString stringWithFormat:@"点击【%@】\n下载%@,\n填我的邀请码【%@】\n领取最高【%@元】红包,红包立即提现，复制信息进入%@\n自动填邀请码领取",url,@"抖动App",inviteCode,edEnvelope,@"抖动App"];
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string= pasteCopyStr;
        
        [MKTools openQQWith:self.view];
    }
    else if ([message.name isEqualToString:@"wechat"])
    {
//        NSLog(@"点击了调用了。。inviteFriends");
        NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body];
        NSDictionary *messageDic = paramsDic[@"message"];
        NSString *inviteCode = [messageDic objectForKey:@"inviteCode"];
        NSString *edEnvelope = [messageDic objectForKey:@"redEnvelope"];
        NSString *url = [messageDic objectForKey:@"url"];
        
        NSString *pasteCopyStr = [NSString stringWithFormat:@"点击【%@】\n下载%@,\n填我的邀请码【%@】\n领取最高【%@元】红包,红包立即提现，复制信息进入%@\n自动填邀请码领取",url,@"抖动App",inviteCode,edEnvelope,@"抖动App"];
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string= pasteCopyStr;
        
        [MKTools openWechatWith:self.view];
    }
    else if ([message.name isEqualToString:@"link"])
    {
            //        NSDictionary *paramsDic = [self getURLParameters:request.URL.absoluteString];
            NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body]; // 用该方法把web的参数Json转模型
    //        NSString *inviteCode = [paramsDic objectForKey:@"inviteCode"];//edEnvelope
//            NSLog(@"点击了调用了。。link| %@ | %@|",paramsDic[@"message"][@"inviteCode"],message.body);
            //          http://172.24.135.208/taskpage/InvitFriends?toUrl=toCopyText&invitCode=4HQ54A
            UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string= [NSString stringWithFormat:@"%@",paramsDic[@"message"][@"url"]];

            [MBProgressHUD wj_showPlainText:@"复制成功，快去分享吧" view:self.view];
    }
    else if ([message.name isEqualToString:@"SaveQrcode"])
    {

        
        NSDictionary *paramsDic = [MKTools dicWithJsonStr:message.body];
//        NSLog(@"点击了调用了。。SaveQrcode| %@",paramsDic[@"message"]);
        NSString *url = [NSString stringWithFormat:@"%@",paramsDic[@"message"][@"url"]];
        NSArray *urls = [url componentsSeparatedByString:@","];
//        NSLog(@"%@",urls[1]);
        [MKTools saveImageFullScrrenTo:[NSString stringWithFormat:@"%@",urls[1]] WithView:self.view];
    }

//    return YES;
}


#pragma mark -
#pragma mark NSURLConnectionDelegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
//    static CFArrayRef certs;
//    if (!certs) {
//        certs = [[ObjectCTools shared] cerCFArrayRef];
//    }
//
//    SecTrustRef trust = [[challenge protectionSpace] serverTrust];
//    int err;
//    SecTrustResultType trustResult = 0;
//    err = SecTrustSetAnchorCertificates(trust, certs);
//    if (err == noErr) {
//        err = SecTrustEvaluate(trust,&trustResult);
//    }
//    BOOL trusted = (err == noErr) && ((trustResult == kSecTrustResultProceed)||(trustResult == kSecTrustResultConfirm) || (trustResult == kSecTrustResultUnspecified));
//
//    if (trusted) {
//        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
//    }else{
//        [challenge.sender cancelAuthenticationChallenge:challenge];
//    }
    
    
    
    
    if ([challenge previousFailureCount] == 0){
        _authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
//    NSURL *url = [NSURL URLWithString:_url];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
    [[MKTools shared] dissmissLoadingInView:self.view animated:YES];
}

#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _authenticated = YES;
    [_webView loadRequest:_request];
    [_urlConnection cancel];
}

#pragma mark - NJKWebViewProgressDelegate
//-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
//{
//    [_progressView setProgress:progress animated:YES];
//    //    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//}

#pragma mark -
#pragma mark 截取URL中的参数
/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}

@end
